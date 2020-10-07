class VerifyDocumentJob < ApplicationJob
  queue_as :default

  def perform(document_id)
    document = Document.find(document_id)

    # Step 1 - Setup (initialize) the document:
    # Valid values for type are: 'contract','license','passport','utility','other','internal'
    doc_params = Alloy::Api.perform("entities/#{document.applicant.entity_id}/documents", body: {name: 'license', extension: 'jpg', type: document.document_type}, endpoint: :documents)

    # Step 2 - Upload the document:
    Alloy::Api.perform("entities/#{document.applicant.entity_id}/documents/#{doc_params['document_token']}", headers: { "Content-Type" => 'application/octet-stream' }, body: document.file.download, method: :put, endpoint: :documents, body_encoding: :to_s)
    document.entity_id = doc_params["document_token"]

    # Step 3 - Run the verification:
    request_params = document.applicant.request_params.merge({
      document_token_front: doc_params["document_token"]
    })
    document.decision_response = Alloy::Api.evaluations(body: request_params, endpoint: :documents)
    document.decision = document.decision_response['summary']['outcome']
    document.entity_id = document.decision_response['entity_token']
    document.evaluation_id = document.decision_response['evaluation_token']
    document.application_token = document.decision_response['application_token']
    document.application_version_id = document.decision_response['application_version_id']
    document.processing_status = :processed

    document.save
  end
end
