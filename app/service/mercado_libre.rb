class MercadoLibre

  def self.obtenerProductos(categoria)
    max = 1001
    offset = 0
    limit = 50
    products = []
    while offset < max  do
       url = build_url(categoria, offset, limit)
       require 'json'
       res = send_request(url)
       p products.concat(res.parsed_response["results"].to_a)
       offset += 50
    end

  end

  private
  def self.build_url(category, offset, limit)
    return "https://api.mercadolibre.com/sites/MLA/search?category=#{category}&offset=#{offset}&limit=#{limit}"
  end

  def self.send_request(url)
    return HTTParty.get(url)
  end

end
