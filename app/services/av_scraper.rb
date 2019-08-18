class AvScraper

  attr_reader :url, :objects, :product_links

  def initialize(url)
    @url = url
  end

  def scrap
    time = Time.now
    links_collector(url)
    data_collector(product_links)
    time = Time.now - time
    puts "Done. #{objects.count} different products found in #{time.to_i} seconds."
    create_data(objects)
  end

  def parse(url)
    http = Curl.get(url) do |http|
      http.headers["User-Agent"] = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36"
    end
    @doc = Nokogiri::HTML(http.body_str).remove_namespaces!
  end

  def links_collector(url)
    @product_links = []
    parse(url)
    links_nodes = @doc.xpath(Selectors::LINK)
    links_nodes.each do |link|
      @product_links << [link[:href], link.text]
    end
    page = 2
    per_page = links_nodes.count
    total = @doc.xpath(Selectors::SUB_COUNTER).text.gsub(/[^0-9]/, '').to_i
    last_page = (total.to_f / per_page.to_f).ceil
    progressbar = ProgressBar.create(:starting_at => 1, :total => last_page, :format => '%a |%b> %p%% %t', :length => 100)
    while page <= last_page
        paginator_url = "#{url}/page/#{page}"
        parse(paginator_url)
        links_nodes = @doc.xpath(Selectors::LINK)
        links_nodes.each do |link|
          @product_links << [link[:href], link.text]
        end
        page += 1
        progressbar.increment
    end

  end

  def data_collector(product_links)
    @product_links = product_links.uniq
    progressbar = ProgressBar.create(:total => @product_links.size, :format => '%a |%b> %p%% %t', :length => 100)
    @objects = []
    @product_links.each do |link, name|
        parse(link)
        @objects << {:name    => name.strip,
                     :brand   => @doc.xpath(Selectors::BRAND)[1].text.strip,
                     :model   => @doc.xpath(Selectors::MODEL).children[2].text.strip,
                     :year    => @doc.xpath(Selectors::YEAR).text.to_i,
                     :mileage => @doc.xpath(Selectors::MILEAGE).text,
                     :price   => @doc.xpath(Selectors::PRICE).text.strip.gsub(/[^0-9]/, '').to_i,
                     :place   => @doc.xpath(Selectors::PLACE).text.strip,
                     :contact => @doc.xpath(Selectors::CONTACT).text.strip,
                     :phone   => @doc.xpath(Selectors::PHONE).text.strip.delete("\s"),
                     :date    => @doc.xpath(Selectors::DATE).first.text,
                     :views   => @doc.xpath(Selectors::VIEWS).children.first.text.strip,
                     :link    => link}
        progressbar.increment
    end
    return @objects
  end

  def create_data(objects)
    objects.each do |object|

      seller = Seller.find_or_create_by!(
        {
          name: object[:contact],
          phone_number: object[:phone]
        }
      )

      place = Place.find_or_create_by!(
        {
          place: object[:place]
        }
      )

      ad = Ad.create!(
        {
          seller_id: seller.id,
          place_id: place.id,
          link: object[:link],
          price: object[:price],
          ad_date: object[:date],
          views: object[:views]
        }
      )

      brand = Brand.find_or_create_by!(
        {
          brand: object[:brand]
        }
      )

      model = Model.find_or_create_by!(
        {
          brand_id: brand.id,
          model: object[:model]
        }
      )

      Auto.create!(
        {
          ad_id: ad.id,
          model_id: model.id,
          full_name: object[:name],
          year: object[:year],
          mileage: object[:mileage]
        }
      )

    end
  end
end