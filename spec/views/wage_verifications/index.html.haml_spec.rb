require 'rails_helper'

RSpec.describe "wage_verifications/index", type: :view do
  before(:each) do
    assign(:wage_verifications, [
      WageVerification.create!(
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
      ),
      WageVerification.create!(
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
      )
    ])
  end

  it "renders a list of wage_verifications" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "Reported Employer Name".to_s, count: 2
    assert_select "tr>td", text: "Reported Employer".to_s, count: 2
    assert_select "tr>td", text: "Reported Time Period".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "Verified Employer Name".to_s, count: 2
    assert_select "tr>td", text: "Verified Employer".to_s, count: 2
    assert_select "tr>td", text: "Verified Time Period".to_s, count: 2
    assert_select "tr>td", text: "Truework Verification Status".to_s, count: 2
    assert_select "tr>td", text: "Verification Status".to_s, count: 2
  end
end
