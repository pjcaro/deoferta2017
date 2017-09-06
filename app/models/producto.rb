class Producto
  include Mongoid::Document
  field :title, type: String
  field :permalink, type: String
  field :image, type: String
  field :price, type: String


  def self.guardarProductos(response)
    require 'json'
    data = JSON.parse(response)
    data.each do |d|
      prod = Producto.where(title: d['title'], 
                              permalink: d['permalink'], 
                              image: d['image'], 
                              price: d['price']).first_or_create
      prod.save 
    end
      
  end
end
