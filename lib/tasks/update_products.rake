namespace :update_products do
  desc "Actualizar productos desde server en node"
    task service_node: :environment do

    p response = HTTParty.get('https://deoferta-ws.herokuapp.com/')


    App::SITES.each do |site|
      response = ProductService.obtenerProductos(site)
      data = response.parsed_response["data"].to_json
      marketplace = response.parsed_response["marketplace"].to_s
      unless data == "null"
        Producto.guardarProductos(data, marketplace, nil)
        p marketplace
      else
        p '-----------------------------'
        p 'null'
        p site
        p '-----------------------------'
      end
    end

    Categoria::CATEGORIAS.each do |categoria|
      response = MercadoLibre.obtenerProductos(categoria)
      data = response.to_json
      Producto.guardarProductos(data, "MercadoLibre", categoria)
    end

    # p Producto.guardarProductos(response.parsed_response['data'].to_json)
    end
end
