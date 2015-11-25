require 'rails_helper'

RSpec.describe "gadgets/new", type: :view do
  before(:each) do
    assign(:gadget, Gadget.new(
      :name => "MyString",
      :price => 1,
      :inventory => 1
    ))
  end

  it "renders new gadget form" do
    render

    assert_select "form[action=?][method=?]", gadgets_path, "post" do

      assert_select "input#gadget_name[name=?]", "gadget[name]"

      assert_select "input#gadget_price[name=?]", "gadget[price]"

      assert_select "input#gadget_inventory[name=?]", "gadget[inventory]"
    end
  end
end
