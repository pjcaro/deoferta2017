json.array!(@productos) do |producto|
  json.title producto.title
  json.price producto.price
end