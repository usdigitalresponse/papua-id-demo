require 'rails_helper'

RSpec.describe "wage_verifications/show", type: :view do
  before(:each) do
    @wage_verification = assign(:wage_verification, WageVerification.create!(
      applicant: nil,
      reported_wages: "9.99",
      reported_employer_name: "Reported Employer Name",
      reported_employer_id: "Reported Employer",
      reported_time_period: "Reported Time Period",
      verified_wages: "9.99",
      verified_employer_name: "Verified Employer Name",
      verified_employer_id: "Verified Employer",
      verified_time_period: "Verified Time Period",
      truework_verification_status: "Truework Verification Status",
      verification_status: "Verification Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Reported Employer Name/)
    expect(rendered).to match(/Reported Employer/)
    expect(rendered).to match(/Reported Time Period/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Verified Employer Name/)
    expect(rendered).to match(/Verified Employer/)
    expect(rendered).to match(/Verified Time Period/)
    expect(rendered).to match(/Truework Verification Status/)
    expect(rendered).to match(/Verification Status/)
  end
end
