class TrackingRequestStatus < ApplicationRecord
  belongs_to :request_tracking
  belongs_to :service_status_catalogue
  
  after_create :add_status

  def add_status
    self.request_tracking.update(
      status_name: self.service_status_catalogue.name,
      status_var_name: self.service_status_catalogue.var_name
    )
  end
end
