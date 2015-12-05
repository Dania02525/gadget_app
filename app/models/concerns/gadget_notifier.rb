require 'thread'
module GadgetNotifier
  extend ActiveSupport::Concern

  mattr_reader :subscribers

  @@subscribers = []

  def self.subscribe(subscriber)
    subscribers << subscriber
  end

  def self.unsubscribe(subscriber)
    subscribers.delete(subscriber)
  end

  def self.push(gadget)
    subscribers.each do |subscriber|
      subscriber << {name: ":update_inventory", data: "{\"inventory\":\"#{gadget.inventory}\", \"id\":\"#{gadget.id}\"}"}
      subscriber << {name: ":update_price", data: "{\"price\":\"#{gadget.price}\", \"id\":\"#{gadget.id}\"}"}
    end
  end

  def self.pinger(time)
    Thread.new do
      while true
        subscribers.each do |subscriber|
          subscriber << {name: ":ping", data: {}}
        end
        sleep(time)
      end
    end
  end

  class Subscriber

    def initialize(queue = Queue.new)
      @queue = queue
      GadgetNotifier.subscribe(@queue)
    end

    def pop
      while event = @queue.pop
        yield "event: #{event[:name]}\ndata: #{event[:data]}\n\n"
      end
    end

    def close
      GadgetNotifier.unsubscribe(@queue)
    end

  end

end