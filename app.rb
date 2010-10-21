require "sinatra"
require "logger"
require "haml"

set :port, ENV["PORT"] || 23000

configure do
  LOGGER = Logger.new("sinatra.log")
  DOMAIN = "localhost"
end

helpers do
  def logger
    LOGGER
  end

  def domain
    DOMAIN
  end
end

get "/" do
  haml :index
end

post "/uploads" do
  filename = File.join(Sinatra::Application.root, "public", "uploads", params[:file][:filename])
  File.open(filename, "w") do |file|
    file.write(params[:file][:tempfile].read)
  end
  "http://" + DOMAIN + "/uploads/#{params[:file][:filename]}"
end

