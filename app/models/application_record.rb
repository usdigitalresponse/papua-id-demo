class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Matt's finder shortcut
  def self.[](id)
    # Allow nil search without error - this supports Model[params[model_id]] without checking if exists:
    return nil if id.nil?

    # Allow both find_by (for a hash), or find (for an integer/string):
    if id.is_a? Hash
      find_by(id)
    else
      find(id)
    end
  end
end
