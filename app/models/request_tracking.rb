class RequestTracking < ApplicationRecord
  belongs_to :delivery_service_catalogue
  has_many :tracking_request_statuses
  has_many :service_status_catalogue, through: :tracking_request_statuses
  enum condition: {
    waiting: 0,
    in_process: 1,
    success: 2,
    without_response: 3
  }

  validates :number, :condition, presence: true
  scope :in_process, -> { where(active: true) }

end