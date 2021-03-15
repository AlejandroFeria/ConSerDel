class DeliveryServiceCatalogue < ApplicationRecord
  has_many :delivery_service_auth_keys
  has_many :delivery_service_accounts
  has_many :request_trackings

  accepts_nested_attributes_for :delivery_service_auth_keys, allow_destroy: true
end
