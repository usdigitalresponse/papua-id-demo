require 'rails_helper'

RSpec.describe Applicant, type: :model do
  let(:valid_attributes) { {
    first_name: 'Hilda',
    last_name: 'Whitcher',
    ssn: '078051120',
    email_address: 'hilda.whitcher@example.com',
    phone_number: '716-555-3141',
    case_number: '99-525625',
    birthdate: '1938/9/19',
    street_address: '127 Ontario St',
    city: 'Lockport',
    state: 'NY',
    postal_code: '14094'
  } }

  it 'creates applicants' do
    expect {
      Applicant.create(valid_attributes)
    }.to change(Applicant, :count).by(1)
  end

  it 'removes dashes from ssn' do
    a = build_stubbed(:applicant)
    a.ssn = '999-09-9999'
    expect(a.ssn).to eq('999099999')
  end
end
