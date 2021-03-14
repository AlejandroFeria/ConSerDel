class DeliveryServiceAccount < ApplicationRecord
    has_many :delivery_config_values
    belongs_to :delivery_service_catalogue

    accepts_nested_attributes_for :delivery_config_values
end
