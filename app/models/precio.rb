class Precio
  include Mongoid::Document
  include Mongoid::Timestamps

  field :valor, type: Integer

  belongs_to :producto

end
