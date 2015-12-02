require 'rails_helper'

RSpec.describe "gadgets/show", type: :view do

  before(:all) do
    load "#{Rails.root}/db/seeds.rb"
  end

  before(:each) do
    @gadget = assign(:gadget, Gadget.create!(
      :name => "Name",
      :price => 1,
      :inventory => 2
    ))  
  end

  after(:all) do
    ActiveRecord::Base.connection.execute('delete from sql_templates')
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
