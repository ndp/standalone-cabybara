require "bundler/setup"
require "yaml"
require "ostruct"
require "rspec"
require "capybara/rspec"

require "capybara/poltergeist"
require "selenium-webdriver"
# require "capybara/webkit"

def camelize(str)
  str.split('_').map {|w| w.capitalize}.join
end

spec_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(spec_dir)


$data = {}
Dir[File.join(spec_dir, "fixtures/**/*.yml")].each {|f|
  title = File.basename(f, ".yml")
  $data[title] = OpenStruct.new( YAML::load( File.open( f ) ) )
}

$data = OpenStruct.new($data)
Dir[File.join(spec_dir, "support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|

  Capybara.register_driver :chrome do |app|
    profile = Selenium::WebDriver::Chrome::Profile.new
    profile['autologin.enabled'] = false
    profile['extensions.password_manager_enabled'] = false
    profile['download.prompt_for_download'] = false

    Capybara::Selenium::Driver.new(app, :browser => :chrome, profile: profile)
  end

  Capybara.register_driver :firefox do |app|
    profile = Selenium::WebDriver::Firefox::Profile.new
    profile['autologin.enabled'] = false
    profile['extensions.password_manager_enabled'] = false
    profile['download.prompt_for_download'] = false
    profile.native_events = true

    Capybara::Selenium::Driver.new(app, :browser => :firefox, profile: profile)
  end

  Capybara.register_driver :poltergeist_debug do |app|
    Capybara::Poltergeist::Driver.new(app, {:inspector => true, :js_errors => true})
  end

  Capybara.configure do |capybara|
    capybara.run_server = false
    capybara.default_wait_time = 5

    capybara.app_host = "http://www.google.com"
    capybara.default_driver = :chrome # :chrome :selenium :webkit :poltergeist, :poltergeist_debug
  end

  config.include Capybara::DSL
  Dir[File.join(spec_dir, "support/**/*.rb")].each {|f|
    base = File.basename( f , '.rb')
    klass = camelize(base)
    config.include Module.const_get(klass)
  }
end


