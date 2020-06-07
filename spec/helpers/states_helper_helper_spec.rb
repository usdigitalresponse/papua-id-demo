require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the StatesHelperHelper. For example:
#
# describe StatesHelperHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe StatesHelperHelper, type: :helper do
  it('lists all 50 states') do
    expect(helper.us_states.count).to eq(50)
  end
end
