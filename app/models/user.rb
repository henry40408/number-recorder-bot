class User < ApplicationRecord
  has_many :recorded_numbers

  def latest_recorded_numbers
    recorded_numbers.order(created_at: :desc)
  end
end
