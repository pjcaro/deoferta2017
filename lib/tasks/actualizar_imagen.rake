namespace :actualizar_imagen do
  desc "Actualizar imagenes de productos ML"
    task link_imagen: :environment do
      Producto.where(marketplace: 'MercadoLibre').each do |prod|
        prod.update(image: prod.image.gsub('-I.', '-O.'))
      end
    end
end
