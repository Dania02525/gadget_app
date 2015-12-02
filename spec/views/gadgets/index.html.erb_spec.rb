require 'rails_helper'

RSpec.describe "gadgets/index", type: :view do

  before(:all) do
    load "#{Rails.root}/db/seeds.rb" 
  end

  before(:each) do
    assign(:gadgets, [
      Gadget.create!(
        :name => "Name",
        :price => 1,
        :inventory => 2
      ),
      Gadget.create!(
        :name => "Name",
        :price => 1,
        :inventory => 2
      )
    ])
  end

  after(:all) do
    ActiveRecord::Base.connection.execute('delete from sql_templates')
  end

  it "renders a list of gadgets" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
