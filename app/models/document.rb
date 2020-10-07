require 'base64'

class Document < ApplicationRecord
  belongs_to :applicant
  has_one_attached :file
  has_many :line_item_decisions, as: :decidable

  after_create_commit :make_decision

  enum document_type: {
    license: 1,
    passport: 2
  }

  enum processing_status: {
    unable_to_process: -1,
    queued: 0,
    processed: 1
  }

  enum decision: {
    Approved: 1,
    "Manual Review": 0,
    Denied: -1,
    unprocessed: -2
  }

  validates :document_type, inclusion: { in: document_types.keys }
  validates :file, presence: true

  protected

  def make_decision
    VerifyDocumentJob.set(wait: 1.second).perform_later(self.id)
  end
end
