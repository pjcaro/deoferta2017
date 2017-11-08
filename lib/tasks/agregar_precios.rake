namespace :agregar_precios do
  desc "Agregar Precios a productos"
    task nuevos_precios: :environment do
      Producto.all.each do |producto|
        if producto.precios.first.valor.nil?
          producto.precios.first.update(valor: "$5900")
        end
      end
    end
end
