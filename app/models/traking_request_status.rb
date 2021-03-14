class TrakingRequestStatus < ApplicationRecord
  belongs_to :request_tracking
  belongs_to :service_status_catalogue
end
