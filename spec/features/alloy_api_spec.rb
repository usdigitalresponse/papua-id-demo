require 'rails_helper'

RSpec.describe 'Alloy API', type: :feature do
  describe 'Checking Parameters' do
    it 'Can Get Parameters' do
      expect(Alloy::Api.parameters(method: 'get')).not_to be_nil
    end
  end
end
