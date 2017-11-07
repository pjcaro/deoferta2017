class FavoritosController < ApplicationController
  respond_to :json, :html
  before_action :find_producto, only: [:create]
  before_action :authenticate_user!, only: [:index, :destroy]

  def index
    @favoritos = current_user.favoritos
  end

  def create
    if current_user
      current_user.favoritos.create(
      producto: @producto
      )
    end
  end

  def destroy
    @producto = Producto.find(params[:id])
    current_user.favoritos.where(
      producto: @producto
    ).destroy_all
  end

  private

  def favorito_params
    params.require(:favorito).permit(:id, :user_id, :producto_id)
  end
  def find_producto
    @producto = Producto.find(params[:producto_id])
  end
end
