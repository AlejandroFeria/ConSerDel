class NewTacking < ApplicationJob
  def perform(service, action)
    #SaveTracking::Main.new('fedex', 'new_tracking').call
    SaveTracking::Main.new(service, action).call
  end
end