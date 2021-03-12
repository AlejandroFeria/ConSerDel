class CreateDeliveryServiceCatalogues < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_service_catalogues do |t|
      t.string :var_name
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
