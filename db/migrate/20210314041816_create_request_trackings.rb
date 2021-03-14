class CreateRequestTrackings < ActiveRecord::Migration[5.2]
  def change
    create_table :request_trackings do |t|
      t.string :number
      t.string :status_name
      t.string :status_var_name
      t.boolean :active

      t.timestamps
    end
  end
end
