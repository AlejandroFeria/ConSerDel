class SaveTracking::Main
  def initialize(type, action)
    @type = type
    @action = action
  end

  def call
    case @type
    when 'fedex'
      SaveTracking::Fedex.new(@action).call
    end
  end

end
