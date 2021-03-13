class CreateDeliveryConfigValues < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_config_values do |t|
      t.references :delivery_service_auth_key, foreign_key: true
      t.references :delivery_service_account, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
