class Favorito
  include Mongoid::Document
  belongs_to :user
  belongs_to :producto
end
