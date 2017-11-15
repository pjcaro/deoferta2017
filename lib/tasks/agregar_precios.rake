namespace :agregar_precios do
  desc "Agregar Precios a productos"
    task nuevos_precios: :environment do
      Producto.all.each do |producto|
        producto.precios.create(valor: producto.precios.first.valor + 500, created_at: DateTime.now - 50.days)
        producto.precios.create(valor: producto.precios.first.valor - 500, created_at: DateTime.now - 40.days)
        producto.precios.create(valor: producto.precios.first.valor + 500, created_at: DateTime.now - 30.days)
        producto.precios.create(valor: producto.precios.first.valor - 500, created_at: DateTime.now - 20.days)
      end
    end
end
