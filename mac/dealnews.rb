#!/usr/bin/env ruby

require 'rss'
require 'date'
require 'time'
require 'colorize'
require 'optparse'

most_recent='http://s31.dlnws.com/dealnews/rss/todays-edition.xml'
most_popular='http://s31.dlnws.com/dealnews/rss/popular.xml'
editor_choice='http://s31.dlnws.com/dealnews/rss/editors-choice.xml'
config_file = 'dealnews.conf'

params = {}
opt_parser = OptionParser.new do |opt|
    opt.banner = "Usage:"
    opt.separator "     dealnews -s <rss selection> -t <minutes> -t"
    opt.separator  "Parameters"

    opt.on("-s","--selection <rss>","most_recent, editor_choice or default: most_popular") do |value|
        params[:rss] = value
    end

    opt.on("-t","--time <minute>",Integer, "display feed for the last n minutes") do |value|
        params[:time] = value
    end

    opt.on("-h","--help","help") do
        puts opt_parser
        exit 1
    end
end
opt_parser.parse!
if(params[:rss] == 'most_recent')
    params[:rss] = most_recent
elsif (params[:rss] == 'editor_choice')
    params[:rss] = editor_choice
else
    params[:rss] = most_popular
end
if(!params.key?(:time))
    params[:time] = 480
end
begin
    last_read = DateTime.strptime(File.read(config_file),'%FT%T%:z')
rescue
    last_read = DateTime.now - 1 # Yesterday
end
    puts 'last read: ' + last_read.to_s.blue
puts params
rss = RSS::Parser.parse(params[:rss], false)
range = DateTime.now - ((1.0/24/60)*params[:time])
File.open(config_file, 'w') {|f| f.write(DateTime.now)}
rss.items[0..50].each do |item|
    date = item.pubDate.to_datetime
    if(date > range)
        if(date > last_read)
            puts "#{date.strftime("%m/%d %I:%M%p")} - " + item.title.yellow
            puts ' - ' + item.link
        else
            puts "#{date.strftime("%m/%d %I:%M%p")} - " + item.title
        end
    end
end
