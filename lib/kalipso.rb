# system deps
require "rubygems"

# gem deps
require 'jaysus'
require 'thor'

# lib deps
require 'kalipso/cli'
require 'highline/import'
require 'rest_client'
require 'pathname'

# models
require 'kalipso/site'

# app
Dir['app/*/*.rb'].each do |file|
  require file
end

Jaysus::Local.store_dir = "#{ENV['HOME']}/.kalipso"


token_path = Pathname.new(Jaysus::Local.store_dir + '/token')

if token_path.exist?
  token = token_path.read
else
  email = ask("Enter your email:  ") { |q| q.echo = true }
  password = ask("Enter your password:  ") { |q| q.echo = "*" }
  token = ActiveSupport::JSON.decode(RestClient.get("http://#{CGI.escape(email)}:#{CGI.escape(password)}@oncalypso.com/api/v1/users.json"))['token']
  token_path.open('w') do |file|
    file.write token
  end
end

Jaysus::Remote.base_url = "http://#{token}:x@oncalypso.com/api/v1"