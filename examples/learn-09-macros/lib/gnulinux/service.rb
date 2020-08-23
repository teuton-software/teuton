define_macro 'service_is_running', :service do
  target "Service #{get(:service)} is running"
  run "systemctl status #{get(:service)}"
  expect_one [ 'Active:', 'active', '(running)' ]
end

define_macro 'service_is_not_running', :service do
  target "Service #{get(:service)} is not running"
  run "systemctl status #{get(:service)}"
  expect_none [ 'Active:', 'active', '(running)' ]
end

define_macro 'service_is_enabled', :service do
  target "Service #{get(:service)} is enabled"
  run "systemctl status #{get(:service)}"
  expect_one [ 'Loaded:', get(:service), ' enabled;' ]
end

define_macro 'service_is_disabled', :service do
  target "Service #{get(:service)} is disabled"
  run "systemctl status #{get(:service)}"
  expect_one [ 'Loaded:', get(:service), ' disabled;' ]
end
