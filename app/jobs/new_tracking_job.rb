class NewTrackingJob < ApplicationJob
  queue_as :default unless Rails.env.production?

  def perform(service = 'fedex', action = 'new_tracking')
    puts 'call save tracking'
    SaveTracking::Main.new(service, action).call
  end

end