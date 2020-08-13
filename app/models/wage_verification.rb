class WageVerification < ApplicationRecord
  belongs_to :applicant
  has_many :line_item_decisions, as: :decidable


  after_create_commit :make_decision
  enum decision: {
    Approved: 1,
    "Manual Review": 0,
    Denied: -1,
    unprocessed: -2
  }

  enum processing_status: {
    unable_to_process: -1,
    queued: 0,
    processed: 1
  }

  protected
  
  def make_decision
    # Simulate answers for each term
    ValidateWagesJob.set(wait: 1.second).perform_later(self.id)
  end
end
