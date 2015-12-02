require 'rails_helper'

RSpec.describe "sql_templates/show", type: :view do
  before(:each) do
    @sql_template = assign(:sql_template, SqlTemplate.create!(FactoryGirl.build(:sql_template).attributes.symbolize_keys))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Yo Dawg.../)
    expect(rendered).to match(/gadgets\/index/)
    expect(rendered).to match(/html/)
    expect(rendered).to match(/en/)
    expect(rendered).to match(/haml/)
    expect(rendered).to match(/false/)
  end
end
