class AddApplicantToWageVerification < ActiveRecord::Migration[6.0]
  def change
    add_reference :wage_verifications, :applicant, index: true, type: :uuid
  end
end
