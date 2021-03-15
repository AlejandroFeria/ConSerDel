class SaveTracking::Fedex
  def initialize(action)
    @action = action
  end

  def call
    send("by_#{@action}")
  end

  def by_new_tracking
    trackings = HTTParty.get(
      'https://dev-challenges.skydropx.com/backend_engineer/shipments_data.json'
    )
    return nil unless trackings.present?

    save_trackings(trackings)
  end

  private

  def save_trackings(trackings)
    trackings.each do |tracking|
      request = RequestTracking.find_by(number: tracking['tracking_number'])
      delivery_service = DeliveryServiceCatalogue.find_by(var_name: tracking['carrier'].downcase)
      if request.nil? && delivery_service.present?
        request = RequestTracking.new(number: tracking['tracking_number'],
          delivery_service_catalogue: delivery_service,
          active: true,
          condition: 'waiting')
        if request.save
          puts "Create new tracking #{request.number}"
          request.tracking_request_statuses.create(service_status_catalogue: ServiceStatusCatalogue.find_by(var_name: "in_process") )
        else
          puts "Errors #{request.errors.full_messages}"
        end
      end
    end
  end
end