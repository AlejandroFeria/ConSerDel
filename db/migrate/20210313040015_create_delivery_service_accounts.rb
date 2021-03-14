class CreateDeliveryServiceAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_service_accounts do |t|
      t.references :delivery_service_catalogue, index: {name: "delivery_service_catalogue"}, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
