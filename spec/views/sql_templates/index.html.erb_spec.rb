require 'rails_helper'

RSpec.describe "sql_templates/index", type: :view do
  before(:each) do
    assign(:sql_templates, [
      SqlTemplate.create!(FactoryGirl.build(:sql_template).attributes.symbolize_keys),
      SqlTemplate.create!(FactoryGirl.build(:sql_template).attributes.symbolize_keys)
    ])
  end

  it "renders a list of sql_templates" do
    render
    assert_select "tr>td", :text => "%p= 'Yo Dawg...'".to_s, :count => 2
    assert_select "tr>td", :text => "gadgets/index".to_s, :count => 2
    assert_select "tr>td", :text => "html".to_s, :count => 2
    assert_select "tr>td", :text => "en".to_s, :count => 2
    assert_select "tr>td", :text => "haml".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
