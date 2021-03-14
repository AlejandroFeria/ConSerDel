class DeliveryServiceCatalogue < ApplicationRecord
  has_many :delivery_service_auth_keys
  has_many :delivery_service_accounts
end
