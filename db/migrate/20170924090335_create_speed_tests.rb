class CreateSpeedTests < ActiveRecord::Migration[5.1]
  def change
    create_table :speed_tests do |t|
      t.float :download_rate
      t.float :upload_rate
      t.float :latency

      t.timestamps
    end
  end
end
