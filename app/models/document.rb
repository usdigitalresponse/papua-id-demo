require 'base64'

class Document < ApplicationRecord
  belongs_to :applicant
  has_one_attached :file
  after_create_commit :make_descision

  enum document_type: {
    license: 1,
    passport: 2
  }

  enum processing_status: {
    unable_to_process: -1,
    queued: 0,
    processed: 1
  }

  enum descision: {
    Approved: 1,
    "Manual Review": 0,
    Denied: -1,
    unprocessed: -2
  }

  validates :document_type, inclusion: { in: document_types.keys }
  validates :file, presence: true

  protected

  def make_descision
    ValidateDocumentJob.set(wait: 5.minutes).perform_later(self.id)
  end
end
