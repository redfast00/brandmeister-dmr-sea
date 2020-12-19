require 'mumble-ruby'
require 'json'

json_from_file = File.read('config.json')
config = JSON.parse(json_from_file)['mumble']

Mumble.configure do |conf|
    # sample rate of sound (48 khz recommended)
    conf.sample_rate = 48000

    # bitrate of sound (32 kbit/s recommended)
    conf.bitrate = 32000

    # directory to store user's ssl certs
    conf.ssl_cert_opts[:cert_dir] = File.expand_path("./certs/")
end

# Create client instance for your server
cli = Mumble::Client.new(config['server']) do |conf|
    conf.username = config['username']
    conf.password = config['password']
end

cli.connect()
while cli.channels.empty? do
  sleep 1
  puts "waiting until fully connected"
end
cli.join_channel(config['channel'])
cli.player.stream_named_pipe(config['fifo'])

while true do
  sleep 5
end