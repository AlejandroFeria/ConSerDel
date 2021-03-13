class CreateDeliveryServiceAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_service_accounts do |t|
      t.references :delivery_service_account, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
