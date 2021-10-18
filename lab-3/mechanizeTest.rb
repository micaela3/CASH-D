# Mechanize Gem Source Code: https://github.com/sparklemotion/mechanize
# Example Code Source: https://readysteadycode.com/howto-scrape-websites-with-ruby-and-mechanize

# INSTALLATION COMMAND: gem install mechanize


# ***********************************************
# ***************** Begin Code ******************
# ***********************************************

require 'mechanize'

# -------------- Test with our webpage -------------

mechanize1 = Mechanize.new
page1 = mechanize1.get('https://courses.osu.edu/psp/csosuct/EMPLOYEE/PUB/c/COMMUNITY_ACCESS.CLASS_SEARCH.GBL')
puts "Title of First Web Page:\n"
puts page1.title


# -------------- Sleeping --------------
puts "\nSleeping for 5 seconds\n"
sleep 1
puts "1 second\n"
sleep 1
puts "2 seconds\n"
sleep 1
puts "3 seconds\n"
sleep 1
puts "4 seconds\n"
sleep 1
puts "5 seconds\n"


# -------------- Test with another webpage --------------
mechanize2 = Mechanize.new
page2 = mechanize2.get('http://weblog.rubyonrails.org/')
puts "\nArticle Header of Second Web Page:\n"
puts page2.at('article header h2').text.strip
