require './lib/course_store'
require './lib/exchanger'
require './lib/fetch'
require 'date'

# 1.If you want to fetch all data from the site and save to db you should uncomment
# two strings below and type ruby lib/exchange_money.rb
# instance_fetch = Fetch.new
# instance_fetch.fetch()

# 2.If you want to exchange money you should uncomment two strings below and 
# type ruby lib/exchange_money.rb
# money = Exchanger.new
# money.exchange(10, '2002-03-02')
# Typed date should be string or created with Date class for example:
# (Date.today-1), '2000-06-22'
# If the course is absent in the db program will fetch it from the site.
# If the course is absent in the site you will see message.

# 3.If you want to exchange money you should uncomment two strings below and 
# type ruby lib/exchange_money.rb
# money = Exchanger.new
# money.exchange(100, ['2000-06-22', '2000-06-21', '2000-06-20'])


