class MigrateToBigInt < ActiveRecord::Migration[5.1]
  def change
    change_column :uplink_statuses, :total_upload, :bigint
    change_column :uplink_statuses, :total_download, :bigint
  end
end
