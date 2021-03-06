#!/usr/bin/env ruby

require "net/https"

if ARGV.size != 1
    puts "USAGE: ruby_pushover.rb <message>"
else
    
    message = ARGV[0].gsub("\\n","\n")
    #puts message.inspect
    #puts message
    message = message +  "\n ---- \n" +
        "Sent From: " + %x[hostname] +  
        Time.now.to_s + "\n"
    puts message 
    url = URI.parse("https://api.pushover.net/1/messages.json")
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data({
        :token => "aRspNBTNXPBJ88G5d8jac1y9TPt6Jb",
        :user => "fgMD9gob4JXhZZzSLTB9BOAF6kj2Fm",
        :message => message,
    })
    res = Net::HTTP.new(url.host, url.port)
    res.use_ssl = true
    res.verify_mode = OpenSSL::SSL::VERIFY_PEER
    res.start {|http| http.request(req) }
end
