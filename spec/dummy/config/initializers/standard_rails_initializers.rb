Rails.application.config.filter_parameters += [:password]

Dummy::Application.config.secret_key_base = 'ae3cad0b2a7fe9cf1620b58b362sdfsdf9d5236ba303b9821fb22ac023c9dc1b07ef16f27b74e96c4294f1e02c5bfc83f2dc89c02c9fc24d1b3974f6d7c14701'

Dummy::Application.config.session_store :cookie_store, key: '_dummy_session'

ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: [:json] if respond_to?(:wrap_parameters)
end
