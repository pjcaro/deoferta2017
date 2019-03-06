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

  def as_indexed_json(options={})
    as_json(except: [:id, :_id])
  end

  def self.search(query)
    __elasticsearch__.search(
      {
        size: 20,
        query: {
          match: {
            title: query
          }
        }
      }
    )
  end

  def self.filter(query, marketplaces, rango)
    if (marketplaces.size === 0)
      marketplaces = [
         "Fravega",
         "Garbarino",
         "Linio.com.ar",
         "MercadoLibre",
         "Musimundo",
      ]
    end
    if rango[1] === 0
      rango[1] = 50000
    end
    
    marketplaces = marketplaces.collect { |m| m.downcase } 

    __elasticsearch__.search(
      {
        size: 20,
        query: {
          bool: {
            must:{
              match: {
                title: query,
              },
            },
            filter: [
              {
                range: {
                  precio: {
                    gte:  rango[0],
                    lt:   rango[1],
                  }
                }
              },
              {
                terms: {
                  marketplace: marketplaces
                }
              }
            ]
          }
        }
      }
    )
  end

  # field :price, type: String
  has_many :precios, autosave: true, dependent: :destroy
  has_many :favoritos, dependent: :destroy

  accepts_nested_attributes_for :precios

  def self.guardarProductos(response, marketplace)

    if marketplace === "MercadoLibre"
      image = 'thumbnail'
      marketplace = 'MercadoLibre'
    else
      image = 'image'
      marketplace = marketplace
    end

    require 'json'
    data = JSON.parse(response)
    data.each do |d|
      unless d['price'].nil?
        if marketplace === "MercadoLibre"
          precio = d['price'].round.to_s.gsub(/[$.]/, '').to_i
        else
          precio = d['price'].to_s.gsub(/[$.]/, '').to_i
        end
        prod = Producto.where(title: d['title'],
                              permalink: d['permalink'],
                              image: d[image],
                              marketplace: marketplace).first_or_create
        prod.precios.where(valor: precio).first_or_create

        prod.precio = prod.precios.last.valor
        p "Se guardo o no"
        p prod.save
      end

    end

  end
end
