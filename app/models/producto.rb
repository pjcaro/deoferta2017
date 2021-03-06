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
  field :brand, type: String
  field :category, type: String

    # field :price, type: String
  has_many :precios, autosave: true, dependent: :destroy
  has_many :favoritos, dependent: :destroy

  accepts_nested_attributes_for :precios

  def as_indexed_json(options={})
    as_json(except: [:id, :_id])
  end

  def self.search(query)
    words = query.split(/\W+/)
    matches = []
    words.each do |word| 
      match = {
        match: {
          title: word
        }
      }
      matches.push(match)
    end

    __elasticsearch__.search(
      {
        size: 20,
        query: {
          bool: {
            must: matches,
          }
        }
      }
    )
  end

  def self.filter(query, marketplaces)

    words = query.split(/\W+/)
    matches = []
    words.each do |word| 
      match = {
        match: {
          title: word
        }
      }
      matches.push(match)
    end

    if (marketplaces.size === 0)
      marketplaces = [
         "Fravega",
         "Garbarino",
         "Linio.com.ar",
         "MercadoLibre",
         "Musimundo",
      ]
    end
    
    marketplaces = marketplaces.collect { |m| m.downcase } 

    __elasticsearch__.search(
      {
        size: 20,
        query: {
          bool: {
            must: matches,
            filter: {
              terms: {
                marketplace: marketplaces
              }
            }
          }
        }
      }
    )
  end

  def self.guardarProductos(response, marketplace, categoria)

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
      p '--------------------------------------------------------'
      p 'producto en data'
      p d
      p '--------------------------------------------------------'
      unless d.nil? 
        unless d['price'].nil?
          if marketplace === "MercadoLibre"
            category = categoria
            precio = d['price'].round.to_s.gsub(/[$.]/, '').to_i
            if d[:attributes] === nil
              brand = 'Otros'
            else
              brand = d[:attributes].find{|s| s[:id] === 'BRAND'}[:value_name]
            end
          else
            category = d['category']
            precio = d['price'].to_s.gsub(/[$.]/, '').to_i
            brand = d['brand']
          end
          prod = Producto.where(title: d['title'],
                                permalink: d['permalink'],
                                marketplace: marketplace).first_or_create
          prod.precios.where(valor: precio).first_or_create
          prod.category = category.capitalize
          prod.brand = brand.capitalize
          prod.image = d[image]
          prod.precio = prod.precios.last.valor
          p "Se guardo o no"
          p prod.save
        end
      end
    end

  end
end
