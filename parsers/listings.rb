nokogiri = Nokogiri.HTML(content)
products = nokogiri.css('.search-item-card-wrapper-gallery')
products.each do |product|
  a_element = product.at_css('.card--out-wrapper a')
  if a_element
    url = URI.join('https:', a_element['href']).to_s.split('?').first
    if url =~ /\Ahttps?:\/\//i
      pages << {
          url: url,
          page_type: 'products',
          fetch_type: 'browser',
          force_fetch: true,
          vars: {
            category: page['vars'],
            url: url
          }
        }
    end
  end
end

total_page_summary = nokogiri.css("li.comet-pagination-item.comet-pagination-item-60 > a").text
total_page = total_page_summary.scan(/\d+/).first.to_i
2.upto(total_page) do |i|
    if i < 11
        pageUrl = "https://www.aliexpress.com/category/204000220/women-clothing.html?CatId=204000220&page=#{i}"
        
        
        pages << {
            fetch_type: "browser",
            page_type: "listings",
            url:pageUrl,        
            # headers: {"User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
            vars: {
                category: "Women's clothing"
            },
        }
    end
end

# listings = nokogiri.css('.search-item-card-wrapper-gallery')
# # listings = nokogiri.css('#card-list .search-item-card-wrapper-gallery')

# listings.each do |listing|
#     product = {}
#     a_element = listing.at_css('.card--out-wrapper a').attr('href')
#     if a_element

#         product['url'] = URI.join('https:', a_element).to_s.split('?').first

#         product['_collection'] = "listings"

#         # save the product to the outputs.
#         outputs << product

#         # if product['url'] =~ /\Ahttps?:\/\//i
#             pages << {
#                 url: product['url'],
#                 page_type: 'products',
#                 fetch_type: 'browser',
#                 force_fetch: true,
#                 vars: {
#                     # category: page['vars']['category'],
#                     category: page['vars'],
#                     url: product['url']
#                 }
#             }
#         # end
#     end
# end
