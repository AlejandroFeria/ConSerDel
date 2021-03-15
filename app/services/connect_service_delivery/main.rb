class ConnectServiceDelivery::Main
  def initialize(type)
    @type = type
  end

  def call
    DeliveryServiceCatalogue.all.each do |service|
      case service.var_name
      when 'fedex'
        ConnectServiceDelivery::Fedex.new(@type, service).call
      end
    end
  end

end
