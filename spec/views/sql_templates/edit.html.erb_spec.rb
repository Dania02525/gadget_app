require 'rails_helper'

RSpec.describe "sql_templates/edit", type: :view do
  before(:each) do
    @sql_template = assign(:sql_template, SqlTemplate.create!(FactoryGirl.build(:sql_template).attributes.symbolize_keys))
  end

  it "renders the edit sql_template form" do
    render

    assert_select "form[action=?][method=?]", sql_template_path(@sql_template), "post" do

      assert_select "textarea#sql_template_body[name=?]", "sql_template[body]"

      assert_select "input#sql_template_path[name=?]", "sql_template[path]"

      assert_select "input#sql_template_format[name=?]", "sql_template[format]"

      assert_select "input#sql_template_locale[name=?]", "sql_template[locale]"

      assert_select "input#sql_template_handler[name=?]", "sql_template[handler]"

      assert_select "input#sql_template_partial[name=?]", "sql_template[partial]"
    end
  end
end
