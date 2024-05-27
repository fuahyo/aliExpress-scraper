html = Nokogiri.HTML(content)

product = {}

url = page['url']

product['url'] = url

# # product['category'] = page['vars']['category']
puts html
product['title'] = html.at_css('[data-pl="product-title"] font font')&.text
# product['title'] = html.at_css('[data-pl="product-title"] font font')&.text
#root > div > div.pdp-body.pdp-wrap > div > div.pdp-body-top-left > div.pdp-info > div.pdp-info-right > div.title--wrap--Ms9Zv4A > h1 > font > font

image_url = html.at_css('div.image-view--previewBox--FyWaIlU div img')
product['image_url'] = image_url['src']
#root > div > div.pdp-body.pdp-wrap > div > div.pdp-body-top-left > div.pdp-info > div.pdp-info-left > div > div > div.image-view--previewWrap--kSHfegR > div.image-view--previewBox--FyWaIlU > div > img

discount_elem = html.css('div.product-price-current')
# discount_elem = html.css('span.uniform-banner-box-price') if discount_elem.empty?
#root > div > div.pdp-body.pdp-wrap > div > div.pdp-body-top-left > div.pdp-info > div.pdp-info-right > div.price--wrap--tA4MDk4.product-price.price--hasDiscount--LTvrFnq > div.price--original--qDQaH8V > span.price--discount--xET8qnP

if discount_elem
    pricestring = discount_elem.text
    price = pricestring.scan(/(\d+\.\d+)/)
    product['discount_low_price'] = price.first[0].to_f
    product['discount_high_price'] = price.last[0].to_f
end

# originalprice_elem = html.css('div.product-price-original')
# originalprice_elem = html.css('span.uniform-banner-box-discounts') if originalprice_elem.empty?
# originalprice_elem = html.css('div.product-price-current') if originalprice_elem.empty?


# if originalprice_elem
#     valueprice = originalprice_elem.css('div.product-price-del')
   
#     pricestring = valueprice.empty? || valueprice.nil? ? originalprice_elem.text : valueprice.text

#     price = pricestring.scan(/(\d+\.\d+)/)
#     product['original_low_price'] = price.first[0].to_f
#     product['original_high_price'] = price.last[0].to_f
# end

# sku = url.split('/')

# product['sku'] =  sku.last.split('.').first

# size_elem = html.css('div.product-sku div.sku-property[2] li.sku-property-item')

# if size_elem
#     size = size_elem.css('div.sku-property-text').collect{|s| s.text.strip}
#     product['size'] = size
# end

# rating = html.at_css('.overview-rating-average')&.text
# reviews_count = html.at_css('.product-reviewer-reviews')&.text

# product['rating'] = rating.to_f if rating
# product['reviews_count'] = reviews_count.to_f if reviews_count

# product['ship_info'] = html.at_css('.product-shipping-price')&.text

# return_policy = html.css('.buyer-pretection-info[2] .buyer-pretection-context')
# product['return_policy'] = return_policy.text.strip if return_policy

# product['guarantee'] = html.at_css('.buyer-pretection-context')&.text

product['_collection'] = "products"

outputs << product