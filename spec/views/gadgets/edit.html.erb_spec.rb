require 'rails_helper'

RSpec.describe "gadgets/edit", type: :view do
  before(:each) do
    @gadget = assign(:gadget, Gadget.create!(
      :name => "MyString",
      :price => 1,
      :inventory => 1
    ))
  end

  it "renders the edit gadget form" do
    render

    assert_select "form[action=?][method=?]", gadget_path(@gadget), "post" do

      assert_select "input#gadget_name[name=?]", "gadget[name]"

      assert_select "input#gadget_price[name=?]", "gadget[price]"

      assert_select "input#gadget_inventory[name=?]", "gadget[inventory]"
    end
  end
end
