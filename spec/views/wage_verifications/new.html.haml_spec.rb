require 'rails_helper'

RSpec.describe "wage_verifications/new", type: :view do
  before(:each) do
    assign(:wage_verification, WageVerification.new(
      applicant: nil,
      reported_wages: "9.99",
      reported_employer_name: "MyString",
      reported_employer_id: "MyString",
      reported_time_period: "MyString",
      verified_wages: "9.99",
      verified_employer_name: "MyString",
      verified_employer_id: "MyString",
      verified_time_period: "MyString",
      truework_verification_status: "MyString",
      verification_status: "MyString"
    ))
  end

  it "renders new wage_verification form" do
    render

    assert_select "form[action=?][method=?]", wage_verifications_path, "post" do

      assert_select "input[name=?]", "wage_verification[applicant_id]"

      assert_select "input[name=?]", "wage_verification[reported_wages]"

      assert_select "input[name=?]", "wage_verification[reported_employer_name]"

      assert_select "input[name=?]", "wage_verification[reported_employer_id]"

      assert_select "input[name=?]", "wage_verification[reported_time_period]"

      assert_select "input[name=?]", "wage_verification[verified_wages]"

      assert_select "input[name=?]", "wage_verification[verified_employer_name]"

      assert_select "input[name=?]", "wage_verification[verified_employer_id]"

      assert_select "input[name=?]", "wage_verification[verified_time_period]"

      assert_select "input[name=?]", "wage_verification[truework_verification_status]"

      assert_select "input[name=?]", "wage_verification[verification_status]"
    end
  end
end
