FactoryGirl.define do
  factory :sql_template do
    body "%p= 'Yo Dawg...'"
    path "gadgets/index"
    format "html"
    locale "en"
    handler "haml"
    partial false
  end

end
