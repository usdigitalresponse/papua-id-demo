class Task < ApplicationRecord
  belongs_to :applicant

  enum status: {
    in_progress: 1
  }
end
