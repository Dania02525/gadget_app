require "rails_helper"

RSpec.describe SqlTemplatesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/sql_templates").to route_to("sql_templates#index")
    end

    it "routes to #new" do
      expect(:get => "/sql_templates/new").to route_to("sql_templates#new")
    end

    it "routes to #show" do
      expect(:get => "/sql_templates/1").to route_to("sql_templates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/sql_templates/1/edit").to route_to("sql_templates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/sql_templates").to route_to("sql_templates#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sql_templates/1").to route_to("sql_templates#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sql_templates/1").to route_to("sql_templates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sql_templates/1").to route_to("sql_templates#destroy", :id => "1")
    end

  end
end
