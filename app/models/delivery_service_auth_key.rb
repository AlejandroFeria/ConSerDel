class DeliveryServiceAuthKey < ApplicationRecord
  belongs_to :delivery_service_catalogue
  has_many :delivery_config_values
end
