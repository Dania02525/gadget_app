require 'rails_helper'

RSpec.describe SqlTemplate, type: :model do

  let(:template_attributes) {
    FactoryGirl.build(:sql_template).attributes.symbolize_keys
  }

  describe "Resolver" do
    it "returns a template with the saved body" do
      resolver = SqlTemplate::Resolver.instance
      details = { formats: [:html], locale: [:en], handlers: [:haml] }
      expect(resolver.find_all("index", "gadgets", false, details).empty?).to be true

      SqlTemplate.create!(template_attributes)
      template = resolver.find_all("index", "gadgets", false, details).first

      #expect(template.handler).to be_kind_of(ActionView::Template::Handlers::HAML)
      expect(template.source).to eq("%p= 'Yo Dawg...'")
      expect(template.formats).to eq([:html])
      expect(template.virtual_path).to eq("gadgets/index")
      expect(template.identifier).to match(%r[SqlTemplate - \d+ - "gadgets/index"])
    end

    it "expires cache on template change" do
      template = SqlTemplate.create!(template_attributes) 
      cache_key = Object.new
      resolver = SqlTemplate::Resolver.instance
      details = { formats: [:html], locale: [:en], handlers: [:haml] }
      t = resolver.find_all("index", "gadgets", false, details, cache_key).first
      expect(t.source).to eq("%p= 'Yo Dawg...'")
      template.update_attributes(body: "%p= 'Whatup Dawg'")
      t = resolver.find_all("index", "gadgets", false, details, cache_key).first
      expect(t.source).to eq("%p= 'Whatup Dawg'")
    end
  end

end
