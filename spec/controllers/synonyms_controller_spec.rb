require 'rails_helper'

RSpec.describe SynonymsController, type: :controller do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:word) { create(:word) }
  let(:unapproved_synonym) { create(:synonym, word: word, approved: false) }
  let(:approved_synonym) { create(:synonym, word: word, approved: true) }

  describe "GET #index" do
    context "as an admin" do
      before do
        sign_in admin # devise test helper method
        get :index
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "renders the correct number of unapproved synonyms" do
        create_list(:synonym, 3, word: word, approved: false) 
        get :index
        json_response = JSON.parse(response.body)
        expect(json_response.length).to eq(3) 
      end

    end
  end
end