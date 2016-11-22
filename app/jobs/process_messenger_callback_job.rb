class ProcessMessengerCallbackJob < ActiveJob::Base

  queue_as :expedited

  def perform(json)
    parsed_json = json.deep_dup
    Rails.logger.info("raw json from ProcessMessengerCallbackJob task : #{parsed_json.class }#{parsed_json.inspect}")
    #analysing message as telegram message
    if parsed_json.include?('entry')
      MessageQuickly::CallbackParser.new(parsed_json).parse do |event|
        callback_handler = MessageQuickly::CallbackRegistry.handler_for(event.webhook_name)
        if callback_handler
          callback = callback_handler.new(event, parsed_json)
          callback.run
        end
      end
    end

  end

end
