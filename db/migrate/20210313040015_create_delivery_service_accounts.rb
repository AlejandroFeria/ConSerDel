class CreateDeliveryServiceAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_service_accounts do |t|
      t.string :name

      t.timestamps
    end
  end
end
