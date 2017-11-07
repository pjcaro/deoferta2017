class ProductosController < ApplicationController
  respond_to :json, :html

  def index
    @prods = Producto.where(title: /.*#{params[:query]}.*/i)

    @productos = Kaminari.paginate_array(@prods).page(params[:page]).per(10)
  end

  def search
    @productos = Producto.where(:image.ne => nil, :marketplace.ne => "Linio.com.ar").to_a.sample(20)
  end

  def historial
    @producto = Producto.find(params[:id])

    int_array = @producto.precios.pluck(:valor).to_a

    gon.precios = int_array.map { |i| i.gsub(/[$.]/, '').to_i }

    gon.fechas = @producto.precios.pluck(:created_at).map {|date| date.strftime('%d-%m-%Y') }.to_a
  end

  private
  def producto_params
    params.require(:producto).permit(:id, :title, :permalink, :image, :marketplace)
  end
end
