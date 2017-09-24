class CreateConnectionStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :connection_statuses do |t|
      t.boolean :is_working, null: false
      t.string :current_ip
      t.string :provider

      t.timestamps
    end
  end
end
