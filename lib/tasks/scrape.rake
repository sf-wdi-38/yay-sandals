namespace :scrape do
  desc "get the mens sandals"
  task rainbowmens: :environment do
    p 'scraping now yay'
    doc = Nokogiri::HTML(open('http://rainbowsandals.com/products-all/mens/sandals'))
    doc.css('.itemListing').each do |item|
      p item.at_css('.itemPictureDescription').text.strip
      p item.at_css('.yourPrice').text.strip[3..-1]
    end
  end

end
