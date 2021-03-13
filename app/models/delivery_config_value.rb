class DeliveryConfigValue < ApplicationRecord
  belongs_to :delivery_service_auth_key
  belongs_to :delivery_service_account
end
