class Producto
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :permalink, type: String
  field :image, type: String
  field :marketplace, type: String

  # field :price, type: String
  has_many :precios, autosave: true, dependent: :destroy


  def self.guardarProductos(response, marketplace)
    require 'json'
    data = JSON.parse(response)
    data.each do |d|
      prod = Producto.where(title: d['title'],
                            permalink: d['permalink'],
                            image: d['image'],
                            marketplace: marketplace).first_or_create
      prod.precios.where(valor: d['price']).first_or_create

      prod.save
    end

  end
end
