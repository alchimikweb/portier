module ViewHelpers
  def app_mock(options={})
    options.reverse_merge! controller: 'products', action: 'index', params: {}

    app = double()

    allow(app).to receive_messages(
      request: { controller: options[:controller], action: options[:action] },
      params: options[:params]
    )

    return app
  end
end
