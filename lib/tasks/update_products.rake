namespace :update_products do
  desc "Actualizar productos desde server en node"
    task service_node: :environment do

    App::SITES.each do |site|
      response = ProductService.obtenerProductos(site)
      data = response.parsed_response["data"].to_json
      marketplace = response.parsed_response["marketplace"].to_s
      unless data == "null"
        Producto.guardarProductos(data, marketplace)
        p marketplace
      else
        p 'null'
        p site

      end
    end

    # p Producto.guardarProductos(response.parsed_response['data'].to_json)
    end
end
