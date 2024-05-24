nokogiri = Nokogiri.HTML(content)
listings = nokogiri.css('.search-item-card-wrapper-gallery')
# listings = nokogiri.css('#card-list .search-item-card-wrapper-gallery')

listings.each do |listing|
    product = {}
    a_element = listing.at_css('.card--out-wrapper a').attr('href')
    if a_element

        product['url'] = URI.join('https:', a_element).to_s.split('?').first

        product['_collection'] = "listings"

        # save the product to the outputs.
        outputs << product

        if product['url'] =~ /\Ahttps?:\/\//i
            pages << {
                url: product['url'],
                page_type: 'products',
                fetch_type: 'browser',
                force_fetch: true,
                vars: {
                    # category: page['vars']['category'],
                    url: product['url']
                }
            }
        end
    end
end
