class ConnectServiceDelivery::Fedex
  require 'fedex'
  def initialize(type, service)
    @type = type
    @service = service
  end

  def call
    send("by_#{@type}")
  end

  def by_account
    accounts = @service.delivery_service_accounts

    accounts.each do |account|
      puts "Actualizando cuenta #{account.name}"
      config = map_access(account)

      next if config.nil?

      update_tracking(config)
    end
  end

  private

  def map_access(account)
    config_values = account.delivery_config_values
    return nil if config_values.present?
    config = {}
    config_values.includes(:delivery_service_auth_key).find_each do |item|
      config[item.delivery_service_auth_key.var_name.to_sym] = item.value
    end

    config
  end

  def update_tracking(config)
    account_fedex = Fedex::Shipment.new(:key => config[:key],
                      :password => config[:password],
                      :account_number => config[:account_number],
                      :meter => config[:meter],
                      :mode => config[:model])
    debugger

  end
end
