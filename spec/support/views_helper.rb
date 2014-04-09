module ViewHelpers
  def app_mock(options={})
    options.reverse_merge! controller: 'products', action: 'index', params: {}

    app = double()

    app.stub(:request).and_return({ controller: options[:controller], action: options[:action] })
    app.stub(:params).and_return(options[:params])

    return app
  end
end
