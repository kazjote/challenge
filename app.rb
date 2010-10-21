require "sinatra"
require "logger"
require "haml"

set :port, ENV["PORT"] || 23000

configure do
  DOMAIN = "localhost"
end

helpers do
  def domain
    DOMAIN
  end
end

get "/" do
  haml :index, :locals => {:uuid => rand(10**7)}
end

post "/uploads" do
  filename = File.join(Sinatra::Application.root, "public", "uploads", params[:file][:filename])
  File.open(filename, "w") do |file|
    file.write(params[:file][:tempfile].read)
  end
  "http://" + DOMAIN + "/uploads/#{params[:file][:filename]}"
end

post "/titles" do
  [params[:title], params[:filepath]].join("\n")
end

