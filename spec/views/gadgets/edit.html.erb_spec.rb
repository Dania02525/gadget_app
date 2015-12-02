require 'rails_helper'

RSpec.describe "gadgets/edit", type: :view do

  before(:all) do
    load "#{Rails.root}/db/seeds.rb" 
  end

  before(:each) do
    @gadget = assign(:gadget, Gadget.create!(
      :name => "MyString",
      :price => 1,
      :inventory => 1
    ))
  end

  after(:all) do
    ActiveRecord::Base.connection.execute('delete from sql_templates')
  end

  it "renders the edit gadget form" do
    render

    assert_select "form[action=?][method=?]", gadget_path(@gadget), "post" do

      assert_select "input#gadget_name[name=?]", "gadget[name]"

      assert_select "input#gadget_price[name=?]", "gadget[price]"

    end
  end
end
