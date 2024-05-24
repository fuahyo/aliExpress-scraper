nokogiri = Nokogiri.HTML(content)
products = nokogiri.css('.search-item-card-wrapper-gallery')
# products = nokogiri.css('#card-list .search-item-card-wrapper-gallery')

products.each do |product|
    a_element = product.at_css('.card--out-wrapper a').attr('href')
    if a_element
        url = URI.join('https:', a_element).to_s.split('?').first
        if url =~ /\Ahttps?:\/\//i
            pages << {
                url: url,
                page_type: 'products',
                fetch_type: 'browser',
                force_fetch: true,
                vars: {
                    # category: page['vars']['category'],
                    url: url
                }
            }
        end
    end
end
