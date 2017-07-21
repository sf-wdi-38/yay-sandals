namespace :scrape do
  desc "get the mens sandals"
  task rainbowmens: :environment do
    BASE_URL = 'http://rainbowsandals.com'
    # Note: This is so I don't get the same sandal eight times. You could also
    # solve this problem by de-duping, by updating rows rather than adding a new
    # row to your database.
    Sandal.destroy_all
    p 'scraping now yay'
    doc = Nokogiri::HTML(open(BASE_URL + '/products-all/mens/sandals'))
    p "got base"
    doc.css('.itemListing').each do |item|
      # Pull out basic data from the basic page
      title =  item.at_css('.itemPictureDescription').text.strip
      price = item.at_css('.yourPrice').text.strip[3...-3].to_i

      # For the description, we have to fetch the sandal's show page.
      # Get the URL.
      item_url = BASE_URL + item.at_css('.itemIdentification').attr('onclick')[17...-1]
      # Open the item's show page and get the description.
      item_doc = Nokogiri::HTML(open(item_url))
      description = item_doc.css('.ExtendedDescription span')[1].text

      #Add sandal to db
      Sandal.create(title: title, price: price, description: description)
    end
  end

end
