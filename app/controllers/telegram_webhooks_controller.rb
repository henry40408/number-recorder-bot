class TelegramWebhooksController < Telegram::Bot::UpdatesController
  def start!(*)
    text =<<EOT
🔢 welcome to number recorder bot 🤖️
give me a number to record

/list: list numbers
/timezone: get current timezone
/timezone [time_zone]: set current timezone
EOT
    respond_with :message, text: text
  end

  def list!(*)
    numbers = current_user.latest_recorded_numbers.limit(30)
    text = numbers
               .map{|n| "#{n.local_created_at}: #{n.number}"}
               .join("\n")
    text = '(empty)' if text.blank?
    respond_with :message, text: text
  end

  def timezone!(timezone = nil, *)
    if timezone.blank?
      respond_with :message, text: current_user.timezone
      return
    end

    u = current_user
    u.timezone = timezone
    u.save!

    respond_with :message, text: "timezone has been set to #{u.timezone}"
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