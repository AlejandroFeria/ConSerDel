class DeliveryServiceCatalogue < ApplicationRecord
  has_many :delivery_service_auth_keys
  has_many :delivery_service_accounts

  accepts_nested_attributes_for :delivery_service_auth_keys, allow_destroy: true
end
