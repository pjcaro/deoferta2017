class ProductosController < ApplicationController
  respond_to :json, :html
  before_action :productos, only: [:index]

  def index

  end

  def search
    @productos = Producto.where(:image.ne => nil, :marketplace.ne => "Linio.com.ar").to_a.sample(20)
  end

  private
  def productos
    @productos = Producto.where(:image.ne => nil, :marketplace.ne => "Linio.com.ar").to_a.sample(20)
  end
end
