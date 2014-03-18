#---
# Excerpted from "Programming Ruby 1.9 and 2.0",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby4 for more book information.
#---
def show_regexp(string, pattern)
    match = pattern.match(string)
    puts "#{string}|#{pattern}"
    puts match
    if match
        "#{match.pre_match}->#{match[0]}<-#{match.post_match}"
    else
        "no match"
    end
end

puts show_regexp('very interesting', /t/)
puts show_regexp('Fats Waller', /lle/)


