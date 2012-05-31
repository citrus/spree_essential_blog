begin
  require "simplecov"
  SimpleCov.start "rails"
rescue LoadError => e
end

# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"
ENV["RAILS_ROOT"] = File.expand_path("../dummy",  __FILE__)

begin require "turn"; rescue LoadError => e; end

require "spree_essentials/testing/test_helper"
require "spree_essentials/testing/integration_case"

# Require Spree's product factory.. and it's dependencies...
require "spree/core/testing_support/factories/tax_category_factory"
require "spree/core/testing_support/factories/shipping_category_factory"
require "spree/core/testing_support/factories/product_factory"

# We'll use ActionConroller's xhr method for faking drag & drops
SpreeEssentials::IntegrationCase.send(:include, ActionController::TestCase::Behavior)

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
