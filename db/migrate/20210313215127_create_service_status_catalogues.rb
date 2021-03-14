class CreateServiceStatusCatalogues < ActiveRecord::Migration[5.2]
  def change
    create_table :service_status_catalogues do |t|
      t.string :name
      t.string :var_name
      t.string :status_equivalences

      t.timestamps
    end
  end
end
