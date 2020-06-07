require 'rails_helper'

RSpec.describe "applicants/new", type: :view do
  before(:each) do
    assign(:applicant, create(:applicant))
  end

  it "renders new applicant form" do
    render

    assert_select "form[action=?][method=?]", applicants_path, "post" do

      assert_select "input[name=?]", "applicant[first_name]"

      assert_select "input[name=?]", "applicant[last_name]"

      assert_select "input[name=?]", "applicant[email_address]"

      assert_select "input[name=?]", "applicant[phone_number]"

      assert_select "input[name=?]", "applicant[street_address]"

      assert_select "input[name=?]", "applicant[city]"

      assert_select "input[name=?]", "applicant[state]"

      assert_select "input[name=?]", "applicant[postal_code]"

      assert_select "input[name=?]", "applicant[ssn]"

      assert_select "input[name=?]", "applicant[case_number]"
    end
  end
end
