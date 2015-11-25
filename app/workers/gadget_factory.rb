class GadgetFactory
  include Sidekiq::Worker
  sidekiq_options queue: "gadget_factory"

  def perform(gadget_id)
    #slowly build the first gadget asyncronously
    sleep(60)
    gadget = Gadget.find(gadget_id)
    gadget.inventory += 1
    gadget.save
  end
  
end