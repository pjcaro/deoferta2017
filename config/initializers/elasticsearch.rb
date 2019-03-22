Kaminari::Hooks.init if defined?(Kaminari::Hooks)
Elasticsearch::Model::Response::Response.__send__ :include, Elasticsearch::Model::Response::Pagination::Kaminari


Elasticsearch::Model.client = Elasticsearch::Client.new url: "https://j9h7bp9f7h:dwdqwi0b0b@rowan-5612310.us-east-1.bonsaisearch.net"
unless Producto.__elasticsearch__.index_exists?
  Producto.__elasticsearch__.create_index! force: true
  Producto.import
end
