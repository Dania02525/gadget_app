require 'rails_helper'

RSpec.describe "SqlTemplates", type: :request do
  describe "GET /sql_templates" do
    it "works! (now write some real specs)" do
      get sql_templates_path
      expect(response).to have_http_status(200)
    end
  end
end
