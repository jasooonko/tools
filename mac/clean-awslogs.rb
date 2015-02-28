#!/usr/bin/env ruby
require 'json'

groups = JSON.parse( `aws logs describe-log-groups --log-group-name-prefix mongo` )
groups['logGroups'].each do |g|
  #puts g['logGroupName']
  cmd = "aws logs delete-log-group --log-group-name #{g['logGroupName']}"
  puts cmd
  `#{cmd}`
end

#aws logs delete-log-group --log-group-name wowzamilb08.strm.am1.prd.bamgrid.com
