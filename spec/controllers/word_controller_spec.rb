require 'rails_helper'

RSpec.describe WordsController, type: :controller do
  let(:word) { create(:word) }
  let!(:approved_synonym) { create(:synonym, word: word, approved: true) }
  let!(:unapproved_synonym) { create(:synonym, word: word, approved: false) }

  describe "GET #synonyms" do
    context "when the word exists" do
      before { get :synonyms, params: { text: word.text } }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns only approved synonyms" do
        json_response = JSON.parse(response.body)
        expect(json_response).to include(JSON.parse(approved_synonym.to_json)) # Ensure that the response includes the approved synonym
        expect(json_response).not_to include(JSON.parse(unapproved_synonym.to_json)) # Ensure that the response does not include the unapproved synonym
      end
    end
  end
 
end
