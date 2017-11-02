class Precio
  include Mongoid::Document
  include Mongoid::Timestamps

  field :valor, type: String

  belongs_to :producto

end
