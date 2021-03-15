class CreateRequestTrackings < ActiveRecord::Migration[5.2]
  def change
    create_table :request_trackings do |t|
      t.references :delivery_service_catalogue, foreign_key: true
      t.string :number
      t.string :status_name
      t.string :status_var_name
      t.boolean :active
      t.integer :condition

      t.timestamps
    end
  end
end
