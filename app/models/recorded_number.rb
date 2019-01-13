class RecordedNumber < ApplicationRecord
  belongs_to :user

  def local_created_at
    created_at.in_time_zone(user.timezone)
  end
end
