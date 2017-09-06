namespace :update_products do
  desc "Actualizar productos desde server en node"
  task service_node: :environment do
    
    response = ProductService.obtenerProductos
    p Producto.guardarProductos(response.parsed_response['data'].to_json)
    

    end
end
