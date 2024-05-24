# # require 'json'
# require 'selenium-webdriver'

# options = Selenium::WebDriver::Chrome::Options.new
# options.add_argument('--headless') # Uncomment this line to run Chrome in headless mode
# driver = Selenium::WebDriver.for :chrome, options: options

# # Navigate to the webpage
# driver.navigate.to 'https://www.aliexpress.com/w/wholesale-Shirts-%26-Blouses.html?spm=a2g0o.categorymp.0.0.1c766uTG6uTGa5&categoryUrlParams=%7B%22q%22%3A%22Shirts%20%26%20Blouses%22%2C%22s%22%3A%22qp_nw%22%2C%22osf%22%3A%22category_navigate%22%2C%22sg_search_params%22%3A%22%22%2C%22guide_trace%22%3A%223a603c67-843f-4bdf-b52c-189363d46edd%22%2C%22scene_id%22%3A%2237749%22%2C%22searchBizScene%22%3A%22openSearch%22%2C%22recog_lang%22%3A%22en%22%2C%22bizScene%22%3A%22category_navigate%22%2C%22guideModule%22%3A%22category_navigate_vertical%22%2C%22postCatIds%22%3A%22200000345%2C320%2C301%2C200000532%2C200001894%22%2C%22scene%22%3A%22category_navigate%22%7D&isFromCategory=y'

# # Inject and execute the JavaScript scrolling script
# scroll_script = <<~JS
#   return new Promise((resolve) => {
#     var totalHeight = 0;
#     var distance = 100;

#     function scroll() {
#       var scrollHeight = document.body.scrollHeight;
#       window.scrollBy(0, distance);
#       totalHeight += distance;

#       if (totalHeight < scrollHeight - window.innerHeight) {
#         setTimeout(scroll, 100);
#       } else {
#         resolve();
#       }
#     }

#     scroll();
#   });
# JS

# driver.execute_async_script(scroll_script)

# # Wait a bit to ensure all content is loaded
# sleep(5)

# # Fetch the HTML content after scrolling
# content = driver.page_source


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

total_page_summary = nokogiri.css("li.comet-pagination-item.comet-pagination-item-60 > a").text
total_page = total_page_summary.scan(/\d+/).first.to_i
2.upto(total_page) do |i|
    if i < 11
        url = "https://www.aliexpress.com/category/100003109/women-clothing.html?page=#{i}"
        pages << {
            # method: "GET",
            fetch_type: "browser",
            # headers: {"User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36"},
            # vars: {
            #     category: "Women's clothing"
            # },
            url:url,

            page_type: 'products',
            page_type: "listings",
            # display: {
            #     "width": 1920,
            #     "height": 3300
            # }
        }
    end
end


#root > div.root--container--2gVZ5S0.root--newRoot--2-6FirH.search-root-cls > div > div.rightContent2023--rightContainer--2abV4r5 > div.cards2023--pagination--1-0Grbh > ul > li.comet-pagination-item.comet-pagination-item-60 > a
# js_script = <<~JS
#   var totalHeight = 0;
#   var distance = 100;
#   var timer = setInterval(() => {
#     var scrollHeight = document.body.scrollHeight;
#     window.scrollBy(0, distance);
#     totalHeight += distance;

#     if (totalHeight >= scrollHeight - window.innerHeight) {
#       clearInterval(timer);
#       resolve();
#     }
#   }, 100);
# JS