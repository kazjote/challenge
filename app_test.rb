ROOT = File.dirname(__FILE__)

require File.join(ROOT, "app")
require 'test/unit'
require 'rack/test'

require 'fileutils'


class HelloWorldTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def teardown
    uploads = Dir.glob(File.join(ROOT, *%w{public uploads *}))
    FileUtils.rm uploads
  end

  def app
    Sinatra::Application
  end

  def test_display_homepage
    get '/'
    assert last_response.ok?
  end

  def test_upload_file
    file = File.join(ROOT, *%w{fixtures gravatar.png})
    post '/uploads', :file => Rack::Test::UploadedFile.new(file, 'image/png')
    assert last_response.ok?
    assert_equal 1, Dir.glob(File.join(ROOT, *%w{public uploads gravatar.png})).size
    assert_match /uploads\/gravatar.png/, last_response.body
  end
end

