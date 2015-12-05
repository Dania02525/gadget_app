class Gadget < ActiveRecord::Base
  include GadgetNotifier

  validates :name, presence: true
  validates :price, presence: true
  
  #after_create :start_gadget_factory

  after_update :push_notification

  def to_param
    "gadget-#{id}"
  end

  def push_notification
    GadgetNotifier.push(self)
  end

  def start_gadget_factory
    GadgetFactory.perform_async(self.id)
  end
end
