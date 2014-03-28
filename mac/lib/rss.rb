#!/usr/bin/env ruby

require 'rss'
require 'date'
require 'time'
require 'colorize'
require 'optparse'

class Rss

    def initialize(feeds, params, config_file)
        @feeds = feeds
        @params = params
        @config_file = config_file
    end
    def read
        begin
            last_read = DateTime.strptime(File.read(@config_file),'%FT%T%:z')
        rescue
            last_read = DateTime.now - 1 # Yesterday
        end
        puts 'last read: ' + last_read.to_s.blue
        puts @params
        range = last_read
        if(@params.key?(:time))
            range = DateTime.now - ((1.0/24/60)*@params[:time])
        end

        File.open(@config_file, 'w') {|f| f.write(DateTime.now)}
        @params[:rss].each do |rss_url|
            rss = RSS::Parser.parse(rss_url, false)
            puts "\n<-- #{rss_url} -->"
            rss.items[0..50].each do |item|
                date = item.pubDate.to_datetime
                if(date > range)
                    if(date > last_read)
                        puts "#{date.strftime("%m/%d %I:%M%p")} - " + item.title.yellow
                        puts ' - ' + item.link
                    else
                        puts "#{date.strftime("%m/%d %I:%M%p")} - " + item.title
                        if(@params[:url] =~ (/(true|t|yes|y|1)$/i))
                            puts ' - ' + item.link
                        end
                    end
                end
            end
        end
    end
end
