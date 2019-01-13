class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def start!(*)
    text =<<EOT
🔢 welcome to number recorder bot 🤖️
give me a number to record
EOT
    respond_with :message, text: text
  end

  def list!(*)
    numbers = current_user.recorded_numbers.limit(30)
    text = numbers.map{|n| "#{n.created_at}: #{n.number}"}.join("\n")
    respond_with :message, text: text
  end

  def message(message)
    text = message['text']

    unless is_numeric?(text)
      respond_with :message, text: "sorry, #{text} is not a number"
      return
    end

    current_user.recorded_numbers.create(number: text)
    respond_with :message, text: 'done'
  end

  private

  def is_numeric?(s)
    true if Float(s) rescue false
  end

  def current_user
    User.find_or_create_by(telegram_id: from['id'])
  end
end