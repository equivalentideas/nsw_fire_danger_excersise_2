require 'scraperwiki'
require 'mechanize'

agent = Mechanize.new

# Read in a page
page = agent.get("http://www.rfs.nsw.gov.au/fire-information/fdr-and-tobans")

# Locate our table
table = page.at('table.danger-ratings-table')

# Look at the first row
table.search('tbody tr').each do |table_row|
  # Create an object with the bits we want
  fire_area = {
    area_name: table_row.search('td')[0].text,
    fire_danger_today: table_row.search('td')[1].text,
    councils_effected: table_row.search('td')[-1].text
  }

  # print out the object for debugging perposes
  puts fire_area

  # Save it to the database
  ScraperWiki.save_sqlite([:area_name], fire_area)
end