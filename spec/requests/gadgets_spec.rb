require 'rails_helper'

RSpec.describe "Gadgets", type: :request do
  before(:all) do
    load "#{Rails.root}/db/seeds.rb" 
  end

  after(:all) do
    ActiveRecord::Base.connection.execute('delete from sql_templates')
  end
  
  describe "GET /gadgets" do
    it "works! (now write some real specs)" do
      get gadgets_path
      expect(response).to have_http_status(200)
    end
  end
end
