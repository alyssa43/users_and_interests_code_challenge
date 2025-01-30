require "sinatra"
require "sinatra/reloader"
require "tilt/erubi"
require "yaml"

before do
  @parsed_data = YAML.load_file("users.yaml")
  @users = @parsed_data.keys.map(&:to_s)
end

helpers do
  def count_interests
    count = 0

    @parsed_data.values.each do |value|
      count += value[:interests].count
    end

    count
  end

  def count_users
    @users.count
  end
end

get "/" do
  redirect "/user"
end

get "/user" do
  erb :home
end

get "/user/:name" do
  user_name = params[:name]
  @user_data = @parsed_data[user_name.to_sym]
  erb :user
end