class ProductService

  def self.obtenerProductos
    server = "http://localhost:8888"
    url = "https://www.garbarino.com/productos/tv-led-y-smart-tv/4342"+"?page=1"

    products = HTTParty.post(server,
      :body => { :url => url,
               :recipe => {"title":"h3.gb-list-cluster-title", "permalink":"a@href", "price":"span.gb-list-cluster-prices-current", "image":"div.gb-list-cluster-picture-inner img@src"},
               :selector => "ul.gb-list-grid li",
               :paginate => "div.gb-list-breadcrumb > div",
               :limit => 1,
               :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]"}
             }.to_json,
      :headers => { 'Content-Type' => 'application/json' },
      :query => query
      )
      
  end  
  
end