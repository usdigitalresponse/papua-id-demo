class LineItemDecision < ApplicationRecord
  belongs_to :decidable, polymorphic: true
end
