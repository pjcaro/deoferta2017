class ProductosController < ApplicationController
  respond_to :json, :html

  def index
    #@prods = Producto.all.where(title: /.*#{params[:query]}.*/i).order_by(:precio => 'asc')

    #@productos = Kaminari.paginate_array(@prods).page(params[:page]).per(20)


    @prods = Producto.search(params[:query]).records
    p @prods
    @brands = @prods.pluck(:brand).uniq.sort
    @categories = @prods.pluck(:category).uniq.sort
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

    if params[:rango_mayor] != ''
      mayor = params[:rango_mayor].to_i
    else
      mayor = 50000 
    end

    menor = params[:rango_menor].to_i

    rango = [menor, mayor]
    marketplaces = params[:marketplace][:marketplaces].reject { |m| m.empty? }
    brands = params[:brands]
    categories = params[:categories]
    
    if brands === nil && categories === nil
      @prods = Producto.filter(params[:query], marketplaces).records.where(:precio.gte => menor, :precio.lte => mayor)
    elsif brands != nil && categories === nil
      @prods = Producto.filter(params[:query], marketplaces).records.where(:precio.gte => menor, :precio.lte => mayor).in(brand: brands)
    elsif brands === nil && categories != nil
      @prods = Producto.filter(params[:query], marketplaces).records.where(:precio.gte => menor, :precio.lte => mayor).in(category: categories)
    else
      @prods = Producto.filter(params[:query], marketplaces).records.where(:precio.gte => menor, :precio.lte => mayor).in(brand: brands).in(category: categories)
    end
    @brands = @prods.pluck(:brand).uniq.sort
    @categories = @prods.pluck(:category).uniq.sort
    p @prods
    @productos = Kaminari.paginate_array(
      @prods.sort_by {|prod| prod.precio}
    ).page(params[:page]).per(20)

    # raise
    # if mayor == 0 
    #   @prods = Producto.all.where(title: /.*#{params[:query]}.*/i)
    #           .any_of({marketplace: params[:marketplace][:marketplaces][0]},
    #                   {marketplace: params[:marketplace][:marketplaces][1]},
    #                   {marketplace: params[:marketplace][:marketplaces][2]},
    #                   {marketplace: params[:marketplace][:marketplaces][3]},
    #                   {marketplace: params[:marketplace][:marketplaces][4]})
    #           .order_by(:precio => 'asc')
    # elsif params[:marketplace][:marketplaces] == [""] && mayor > 0
    #   #method in no funciona para el where. REVISAR :precio.in => rango
    #   @prods = Producto.all.where(title: /.*#{params[:query]}.*/i, :precio.gte => menor, :precio.lte => mayor)
    #           .order_by(:precio => 'asc')

    # else
    #   menor = params[:rango_menor].to_i
    #   mayor = params[:rango_mayor].to_i
    #   rango = [menor, mayor]
    #   @prods = Producto.all.where(title: /.*#{params[:query]}.*/i, :precio.gte => menor, :precio.lte => mayor)
    #           .any_of({marketplace: params[:marketplace][:marketplaces][0]},
    #                   {marketplace: params[:marketplace][:marketplaces][1]},
    #                   {marketplace: params[:marketplace][:marketplaces][2]},
    #                   {marketplace: params[:marketplace][:marketplaces][3]},
    #                   {marketplace: params[:marketplace][:marketplaces][4]})
    #           .order_by(:precio => 'asc')

    # end


    # @productos = Kaminari.paginate_array(@prods).page(params[:page]).per(20)


    render :index
  end

  private
  def producto_params
    params.require(:producto).permit(:id, :title, :permalink, :image, :marketplace, :marketplaces)
  end
end
