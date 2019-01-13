class CreateRecordedNumbers < ActiveRecord::Migration[5.2]
  def change
    create_table :recorded_numbers do |t|
      t.float :number
      t.integer :user_id

      t.timestamps
    end
  end
end
