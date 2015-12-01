class Gadget < ActiveRecord::Base
  validates :name, presence: true
  validates :price, presence: true
  
  after_create :start_gadget_factory

  def to_param
    "gadget-#{id}"
  end


  def start_gadget_factory
    GadgetFactory.perform_async(self.id)
  end
end
