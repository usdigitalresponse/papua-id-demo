class LineItemDecision < ApplicationRecord
  # TODO: Change decision to enum
  belongs_to :decidable, polymorphic: true
  scope :accepted, -> { where(decision: :accepted) }
  scope :rejected, -> { where(decision: :rejected) }

  # HACK: These should come from enum
  def accepted?; decision == 'approved'; end
  def rejected?; decision == 'rejected'; end
end
