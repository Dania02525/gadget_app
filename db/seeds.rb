# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
gadget_templates = [
  {path: "gadgets/index", format: "html", locale: "en", handler: "haml", partial: false, body: 
%q(%p#notice= notice 

%h1 Listing Gadgets 

%table.table-striped.table 
  %thead 
    %tr 
      %th Name 
      %th Price 
      %th Inventory 
      %th{:colspan => "3"} 
  %tbody 
    - @gadgets.each do |gadget| 
      %tr 
        %td= gadget.name 
        %td= gadget.price 
        %td= gadget.inventory 
        %td= link_to 'Show', gadget 
        %td= link_to 'Edit', edit_gadget_path(gadget) 
        %td= link_to 'Destroy', gadget, method: :delete, data: { confirm: 'Are you sure?' } 

%br 

= link_to 'New Gadget', new_gadget_path 
)
  },
  {path: "gadgets/new", format: "html", locale: "en", handler: "haml", partial: false, body:
%q(%h1 New Gadget

= render :partial => "form"

= link_to 'Back', gadgets_path
)
  },
  {path: "gadgets/edit", format: "html", locale: "en", handler: "haml", partial: false, body:
%q(%h1 Editing Gadget

= render :partial => "form"

= link_to 'Show', @gadget
= link_to 'Back', gadgets_path
)
  },
  {path: "gadgets/show", format: "html", locale: "en", handler: "haml", partial: false, body:
%q(%p#notice= notice 

%p
  %strong Name: #{@gadget.name}

%p
  %strong Price: #{@gadget.price}

%p
  %strong Inventory: #{@gadget.inventory}

= link_to 'Edit', edit_gadget_path(@gadget)
= link_to 'Back', gadgets_path
)
  },
  {path: "gadgets/form", format: "html", locale: "en", handler: "haml", partial: true, body:
%q(= form_for(@gadget) do |f|
  - if @gadget.errors.any?
    #error_explanation
      %h2 #{pluralize(@gadget.errors.count, "error")} prohibited this gadget from being saved:
      %ul 
        - @gadget.errors.full_messages.each do |message|
          %li= message
          
  .form-group
    = f.label :name
    %br
    = f.text_field :name, class: "form-control"

  .form-group
    = f.label :price
    %br
    = f.number_field :price, class: "form-control"

  .actions
    = f.submit nil, class: 'btn btn-primary'
)
  }
]

gadget_templates.each do |seed|
  SqlTemplate.find_or_create_by(seed)
end