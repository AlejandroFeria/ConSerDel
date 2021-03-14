class CreateTrakingRequestStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :traking_request_statuses do |t|
      t.references :request_tracking, foreign_key: true
      t.references :service_status_catalogue, foreign_key: true

      t.timestamps
    end
  end
end
