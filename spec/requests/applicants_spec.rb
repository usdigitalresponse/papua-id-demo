 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/applicants", type: :request do
  # Applicant. As you add validations to Applicant, be sure to
  # adjust the attributes here as well.
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

  describe "GET /new" do
    it "renders a successful response" do
      get new_applicant_url
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Applicant" do
        expect {
          post applicants_url, params: { applicant: valid_attributes }
        }.to change(Applicant, :count).by(1)
        expect(response).to redirect_to(new_applicant_url)
      end
    end
  end
end
