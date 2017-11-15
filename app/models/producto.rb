class Producto
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :permalink, type: String
  field :image, type: String
  field :marketplace, type: String
  field :precio, type: Integer


  # field :price, type: String
  has_many :precios, autosave: true, dependent: :destroy
  has_many :favoritos, dependent: :destroy

  accepts_nested_attributes_for :precios


  def self.guardarProductos(response, marketplace)
    require 'json'
    data = JSON.parse(response)
    data.each do |d|
      unless d['price'].nil?
        prod = Producto.where(title: d['title'],
                              permalink: d['permalink'],
                              image: d['image'],
                              marketplace: marketplace).first_or_create
        prod.precios.where(valor: d['price'].gsub(/[$.]/, '').to_i).first_or_create

        prod.precio = prod.precios.last.valor

        prod.save

      end

    end

  end
end
