class CreateDeliveryServiceAuthKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_service_auth_keys do |t|
      t.references :delivery_service_catalogue, index: {name: "delivery_service_catalogue_id"}, foreign_key: true
      t.string :var_name
      t.string :name

      t.timestamps
    end
  end
end
