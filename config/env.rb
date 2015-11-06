require 'bundler/setup'
Bundler.require :default

APP_ENV = ENV["RACK_ENV"] || "development"

path = File.expand_path "../../", __FILE__
APP_PATH = path

# RPC_HOST = 'localhost'
# RPC_HOST = '188.165.223.5' # sys.mkvd.net

# RPC_HOST = '212.47.233.106' # bchain  # scaleway
RPC_HOST = 'localhost'

# bchain2 # scalet
# bitcoin_conf = "sys.bitcoin.conf"
bitcoin_conf = "bitcoin.conf"


unless APP_ENV == "development"
  file = File.read File.expand_path( "~/.bitcoin/#{bitcoin_conf}" )
  password = file.strip.match(/rpcpassword=(.+)/)[1]
else
  password = File.read( File.expand_path "#{APP_PATH}/.bitcoin_rpc_password" ).strip
end

password = "antani" # temp dev pass lol

RPC_PASSWORD = password


# models
require_relative "../models/wallet"


# lib
require_relative "../lib/monkeypatches"
