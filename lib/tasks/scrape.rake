namespace :scrape do
  desc "get the mens sandals"
  task rainbowmens: :environment do
    BASE_URL = 'http://rainbowsandals.com'
    Sandal.destroy_all
    p 'scraping now yay'
    doc = Nokogiri::HTML(open(BASE_URL + '/products-all/mens/sandals'))
    p "got base"
    doc.css('.itemListing').each do |item|

      title =  item.at_css('.itemPictureDescription').text.strip
      price = item.at_css('.yourPrice').text.strip[3...-3].to_i

      item_url = BASE_URL + item.at_css('.itemIdentification').attr('onclick')[17...-1]
      item_doc = Nokogiri::HTML(open(item_url))
      description = item_doc.css('.ExtendedDescription span')[1].text
      Sandal.create(title: title, price: price, description: description)
    end
  end

end
