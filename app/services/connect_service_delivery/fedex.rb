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
    return unless accounts.present? && @service.request_trackings.present?
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
    return nil unless config_values.present?
    config = {}
    config_values.includes(:delivery_service_auth_key).find_each do |item|
      config[item.delivery_service_auth_key.var_name.to_sym] = item.value
    end

    config
  end

  def update_tracking(config)
    puts 'Conexion con fedex'
    account_fedex = Fedex::Shipment.new(:key => config[:key],
                      :password => config[:password],
                      :account_number => config[:account_number],
                      :meter => config[:meter],
                      :mode => config[:mode])

    @service.request_trackings.in_process.each do |tracking|
      tracking.update(condition: 'in_process')
      result = account_fedex.track(:tracking_number => tracking.number)
      #begin
      debugger
        if result.present?
          update_status(result.first, tracking)
        else
          debugger
          tracking_delete(tracking)
        end

      #rescue Exception => e
      #  tracking.update(condition: 'without_response')
      #  puts 'Errors for tracking'
      #end
    end

  end

  def update_status(result, tracking)
    ServiceStatusCatalogue.all.each do |ssc|
      if ssc.status_equivalences.split.include?(result.status)
        tracking.tracking_request_statuses.create(service_status_catalogue: ssc) if tracking.var_name != ssc.var_name
      end
    end
    tracking.update(condition: 'success')
  end

  def tracking_delete(tracking)
    tracking.update(condition: 'success', active: 'false')
    tracking.tracking_request_statuses.create(service_status_catalogue: ServiceStatusCatalogue.find_by(var_name: "delete") )
  end

end
