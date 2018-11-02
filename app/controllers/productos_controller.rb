class ProductosController < ApplicationController
  respond_to :json, :html

  def index
    #@prods = Producto.all.where(title: /.*#{params[:query]}.*/i).order_by(:precio => 'asc')

    #@productos = Kaminari.paginate_array(@prods).page(params[:page]).per(20)


    @productos = Producto.search(params[:query]).page(params[:page]).per(20).records;
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
    # raise
    if params[:rango].nil?
      @prods = Producto.all.where(title: /.*#{params[:query]}.*/i)
              .any_of({marketplace: params[:marketplace][:marketplaces][0]},
                      {marketplace: params[:marketplace][:marketplaces][1]},
                      {marketplace: params[:marketplace][:marketplaces][2]})
              .order_by(:precio => 'asc')
    elsif params[:marketplace][:marketplaces] == [""] && !params[:rango].nil?
      @prods = Producto.all.where(title: /.*#{params[:query]}.*/i, :precio.lte => params[:rango].to_i)
              .order_by(:precio => 'asc')

    else
      @prods = Producto.all.where(title: /.*#{params[:query]}.*/i, :precio.lte => params[:rango].to_i)
              .any_of({marketplace: params[:marketplace][:marketplaces][0]},
                      {marketplace: params[:marketplace][:marketplaces][1]},
                      {marketplace: params[:marketplace][:marketplaces][2]})
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
