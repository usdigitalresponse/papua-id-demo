class LineItemDecision < ApplicationRecord
  belongs_to :decidable, polymorphic: true

  enum decision: [ :approved, :manual_review, :rejected]
end
