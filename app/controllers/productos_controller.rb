class ProductosController < ApplicationController
  respond_to :json, :html

  def index
    #@prods = Producto.all.where(title: /.*#{params[:query]}.*/i).order_by(:precio => 'asc')

    #@productos = Kaminari.paginate_array(@prods).page(params[:page]).per(20)


    @prods = Producto.search(params[:query]).records
    @productos = Kaminari.paginate_array(
      @prods.sort_by {|prod| prod.precio}
    ).page(params[:page]).per(20)
  end

  def search
    @productos = Producto.where(:image.ne => nil, :marketplace.ne => "Linio.com.ar").to_a.sample(20)
  end

  def historial
    @producto = Producto.find(params[:id])

    gon.precios = @producto.precios.order_by(:created_at => 'asc').pluck(:valor)

    # gon.precios = int_array.map { |i| i.gsub(/[$.]/, '').to_i }

    gon.fechas = @producto.precios.order_by(:created_at => 'asc').pluck(:created_at).map {|date| date.strftime('%d-%m-%Y') }.to_a
  end

  def filter
    menor = params[:rango_menor].to_i
    mayor = params[:rango_mayor].to_i
    array = [menor, mayor]
    # raise
    if mayor == 0 
      @prods = Producto.all.where(title: /.*#{params[:query]}.*/i)
              .any_of({marketplace: params[:marketplace][:marketplaces][0]},
                      {marketplace: params[:marketplace][:marketplaces][1]},
                      {marketplace: params[:marketplace][:marketplaces][2]},
                      {marketplace: params[:marketplace][:marketplaces][3]},
                      {marketplace: params[:marketplace][:marketplaces][4]})
              .order_by(:precio => 'asc')
    elsif params[:marketplace][:marketplaces] == [""] && mayor > 0
      #method in no funciona para el where. REVISAR :precio.in => array
      @prods = Producto.all.where(title: /.*#{params[:query]}.*/i, :precio.gte => menor, :precio.lte => mayor)
              .order_by(:precio => 'asc')

    else
      menor = params[:rango_menor].to_i
      mayor = params[:rango_mayor].to_i
      array = [menor, mayor]
      @prods = Producto.all.where(title: /.*#{params[:query]}.*/i, :precio.gte => menor, :precio.lte => mayor)
              .any_of({marketplace: params[:marketplace][:marketplaces][0]},
                      {marketplace: params[:marketplace][:marketplaces][1]},
                      {marketplace: params[:marketplace][:marketplaces][2]},
                      {marketplace: params[:marketplace][:marketplaces][3]},
                      {marketplace: params[:marketplace][:marketplaces][4]})
              .order_by(:precio => 'asc')

    end


    @productos = Kaminari.paginate_array(@prods).page(params[:page]).per(20)


    render :index
    #code
  end

  private
  def producto_params
    params.require(:producto).permit(:id, :title, :permalink, :image, :marketplace, :marketplaces)
  end
end
