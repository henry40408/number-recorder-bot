class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def start!(*)
    text =<<EOT
🔢 welcome to number recorder bot 🤖️
give me a number to record
EOT
    respond_with :message, text: text
  end

  def message(message)
    text = message['text']

    if is_numeric?(text)
      respond_with :message, text: 'done'
    else
      respond_with :message, text: "sorry, #{text} is not a number"
    end
  end

  private

  def is_numeric?(s)
    true if Float(s) rescue false
  end
end