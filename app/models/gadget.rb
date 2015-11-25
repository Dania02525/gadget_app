class Gadget < ActiveRecord::Base
  after_create :start_gadget_factory


  def start_gadget_factory
    GadgetFactory.perform_async(self.id)
  end
end
