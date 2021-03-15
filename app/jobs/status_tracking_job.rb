class StatusTrackingJob < ApplicationJob
  queue_as :default unless Rails.env.production?
  def perform(type = 'account')
    puts 'call status for fedex'
    ConnectServiceDelivery::Main.new(type).call
  end
end