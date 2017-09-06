class ProductosController < ApplicationController
  respond_to :json, :html
  before_action :productos, only: [:index]

  def index

  end

  def search
    #code
  end

  private
  def productos
    @productos = Producto.all
  end
end
