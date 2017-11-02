class ProductService

  def self.obtenerProductos(site)
    server = "https://deoferta-ws.herokuapp.com/"
    # url = "https://www.garbarino.com/productos/tv-led-y-smart-tv/4342"+"?page=1"

    products = HTTParty.post(server,
      :body => site.to_json,
      :headers => { 'Content-Type' => 'application/json' }
    )

  end

end
