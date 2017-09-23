class CreateUplinkStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :uplink_statuses do |t|
      t.string :uplink_name, null: false
      t.string :connection_status
      t.integer :signal_bars
      t.string :network_type
      t.string :network_name
      t.integer :current_connect_time
      t.integer :current_upload_rate
      t.integer :current_download_rate
      t.integer :total_upload
      t.integer :total_download

      t.timestamps
    end
  end
end
