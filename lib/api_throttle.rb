class ApiThrottle < Rack::Throttle::Hourly
      def allowed?(request)
    path_info = (Rails.application.routes.recognize_path request.url rescue {}) || {} 

    # Check if this route should be rate-limited
    if path_info[:controller] == "api/v1/people"
      super
    else
      # other routes are not throttled, so we allow them
      true
    end
  end
end