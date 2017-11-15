class App
  SITES = [
    {
      :url => "https://televisores.mercadolibre.com.ar/televisores/",
      :recipe => {"title":"h2.item__title a", "permalink":"h2.item__title a@href", "price":"span.price-fraction", "image":"a.item-image img@src", "seller_username":"a.item__brand"},
      :selector => "li.results-item",
      :marketplace => "MercadoLibre",
      :paginate => "li.pagination__next a@href",
      :limit => 1,
      :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]"}
    },
    {
      :url => "https://www.garbarino.com/productos/tv-led-y-smart-tv/4342",
      :recipe => {"title":"h3.gb-list-cluster-title", "permalink":"a@href", "price":"span.gb-list-cluster-prices-current", "image":"div.gb-list-cluster-picture-inner img@src", "seller_username":"div.store_info span.seller a"},
      :selector => "ul.gb-list-grid li",
      :marketplace => "Garbarino",
      :paginate => "div.gb-list-breadcrumb > div",
      :limit => 1,
      :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]"}
    },
    # {
    #   :url => "https://www.linio.com.ar/c/tv-y-video/televisores",
    #   :recipe => {"title":"a.title-section@title", "permalink":"a.title-section@href", "price":"div.price-section meta[itemprop=price]@content", "image":"div.image-container > a > figure > picture > img@src"},
    #   :selector => "div.catalogue-product",
    #   :marketplace => "Linio.com.ar",
    #   :paginate => "a.page-link-icon@href",
    #   :limit => 1,
    #   :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]"}
    # },
    # {
    #   :url => "https://www.musimundo.com/catalogo/1570~audiotvvideo/1589~televisores/1992~smart-tv/Listado",
    #   :recipe => {"title":"a.name", "brand":"a.brand@href", "permalink":"a.name@href", "price":"span.value", "image":"a.img img@src"},
    #   :selector => "article.product",
    #   :marketplace => "Musimundo",
    #   :paginate => "div.gb-list-breadcrumb > div",
    #   :limit => 1,
    #   :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]", "brand":"search=(.*)"}
    # },
    {
      :url => "http://www.fravega.com/tv-y-video/tv",
      :recipe => {"title":"h3 > a@title", "permalink":"h3 > a@href", "price":"em.BestPrice", "image":"div.image > a > img@src"},
      :selector => "li.tv-y-video-compra-al-mejor-precio-en-fravega-com",
      :marketplace => "Fravega",
      :paginate => "li.page-number",
      :siguiente => "http://www.fravega.com/tv-y-video/tv#2",
      :limit => 1,
      :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]"}
    }
  ]

end
