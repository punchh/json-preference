$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'active_support/all'
require 'active_record'
require 'yaml'
require 'rspec'
require 'shoulda'
require 'json-preference/version'
require 'json-preference/serializer'
require 'json-preference/preference_definition'
require 'json-preference/preferenzer'
require 'json-preference/has_preference_map'

FIXTURES_DIR = File.join(File.dirname(__FILE__), "fixtures")
config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))
ActiveRecord::Base.logger = ActiveSupport::Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Base.establish_connection(config['test'])

RSpec.configure do |config|
end

def rebuild_model options = {}
  ActiveRecord::Base.connection.create_table :dummy_classes, :force => true do |table|
    table.column :json_preferences, :json
  end
end
