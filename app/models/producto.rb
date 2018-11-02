class Producto
  include Mongoid::Document
  include Mongoid::Timestamps
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  index_name "productos-#{Rails.env}"

  field :title, type: String
  field :permalink, type: String
  field :image, type: String
  field :marketplace, type: String
  field :precio, type: Integer

  def as_indexed_json
    as_json(except: [:id, :_id])
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        sort: [
           { precio: {order: "desc"}},
        ],
        min_score: 0.8,
        query: {
          match: {
            title: query
          }
        },

      }
    )
  end


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
