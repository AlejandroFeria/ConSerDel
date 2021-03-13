class DeliveryServiceAccount < ApplicationRecord
    has_many :delivery_config_values

    accepts_nested_attributes_for :delivery_config_values
end
