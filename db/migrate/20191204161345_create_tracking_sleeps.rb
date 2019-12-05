class CreateTrackingSleeps < ActiveRecord::Migration[5.0]
  def change
    create_table :tracking_sleeps do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.float :period
      t.integer :user_id

      t.timestamps
    end
  end
end
