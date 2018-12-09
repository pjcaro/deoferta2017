class App
  # {
  #   :url => "https://televisores.mercadolibre.com.ar/televisores/",
  #   :recipe => {"title":"span.main-title", "permalink":"h2.item__title a@href", "price":"span.price__fraction", "image":"a.item-image img@src", "seller_username":"a.item__brand"},
  #   :selector => "li.item.static-height",
  #   :marketplace => "MercadoLibre",
  #   :paginate => "li.pagination__next a@href",
  #   :limit => 1
  # },
  # {
  #   :url => "https://celulares.mercadolibre.com.ar/",
  #    :recipe => {"title":"span.main-title", "permalink":"h2.item__title a@href", "price":"span.price__fraction", "image":"a.item-image img@src", "seller_username":"a.item__brand"},
  #   :selector => "li.results-item",
  #   :marketplace => "MercadoLibre",
  #   :paginate => "li.pagination__next a@href",
  #   :limit => 1
  # },
  # {
  #   :url => "https://notebooks.mercadolibre.com.ar/",
  #    :recipe => {"title":"span.main-title", "permalink":"a.item__info-link@href", "price":"span.price__fraction", "image":"a.item-image img@src", "seller_username":"a.item__brand"},
  #   :selector => "li.results-item",
  #   :marketplace => "MercadoLibre",
  #   :paginate => "div.quantity-results",
  #   :limit => 1
  # },
  SITES = [
    {
      :url => "https://www.garbarino.com/productos/tv-led-y-smart-tv/4342",
      :recipe => {"title":"h3.itemBox--title", "permalink":"a.itemBox--info@href", "price":"span.value-item", "image":"div.itemBox--carousel img@src", "seller_username":""},
      :selector => "ul.gb-list-grid li",
      :marketplace => "Garbarino",
      :paginate => "h2.seo--title",
      :limit => 1,
      :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]"}
    },
    {
      :url => "https://www.garbarino.com/productos/notebooks/4363",
      :recipe => {"title":"h3.itemBox--title", "permalink":"a.itemBox--info@href", "price":"span.value-item", "image":"div.itemBox--carousel img@src", "seller_username":""},
      :selector => "ul.gb-list-grid li",
      :marketplace => "Garbarino",
      :paginate => "h2.seo--title",
      :limit => 1,
      :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]"}
    },
    {
      :url => "https://www.garbarino.com/productos/celulares-libres/4359",
      :recipe => {"title":"h3.itemBox--title", "permalink":"a.itemBox--info@href", "price":"span.value-item", "image":"div.itemBox--carousel img@src", "seller_username":""},
      :selector => "ul.gb-list-grid li",
      :marketplace => "Garbarino",
      :paginate => "h2.seo--title",
      :limit => 1,
      :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]"}
    },
    {
       :url => "https://www.linio.com.ar/c/celulares-y-tablets/celulares-y-smartphones",
       :recipe => {"title":"meta[itemprop=name]@content", "permalink":"a:first-child@href", "price":"meta[itemprop=price]@content", "image":"meta[itemprop=image]@content"},
       :selector => "div.catalogue-product.row",
       :marketplace => "Linio.com.ar",
       :paginate => "ul.pagination li:nth-last-child(2) a@href",
       :limit => 1,
       :regex => {"image":"//(.*)", "price": "^[^(.)]*"}
     },
     {
      :url => "https://www.linio.com.ar/c/pc-portatil/notebooks",
      :recipe => {"title":"meta[itemprop=name]@content", "permalink":"a:first-child@href", "price":"meta[itemprop=price]@content", "image":"meta[itemprop=image]@content"},
      :selector => "div.catalogue-product.row",
      :marketplace => "Linio.com.ar",
      :paginate => "ul.pagination li:nth-last-child(2) a@href",
      :limit => 1,
      :regex => {"image":"//(.*)", "price": "^[^(.)]*"}
    },
     {
      :url => "https://www.linio.com.ar/c/televisores/smart-tv",
      :recipe => {"title":"meta[itemprop=name]@content", "permalink":"a:first-child@href", "price":"meta[itemprop=price]@content", "image":"meta[itemprop=image]@content"},
      :selector => "div.catalogue-product.row",
      :marketplace => "Linio.com.ar",
      :paginate => "ul.pagination li:nth-last-child(2) a@href",
      :limit => 1,
      :regex => {"image":"//(.*)", "price": "^[^(.)]*"}
    },
     {
       :url => "https://www.musimundo.com/catalogo/1570~audio-tv-y-video/1589~televisores/1992~smart-tv/Listado?page=0&limitRows=36",
       :recipe => {"title":"a.name", "brand":"a.brand@href", "permalink":"a.name@href", "price":"span.price", "image":"a.img img@src"},
       :selector => "article.product",
       :marketplace => "Musimundo",
       :paginate => "a.after@href",
       :limit => 1,
       :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]", "brand":"search=(.*)", "price": "^[^(,)]*"}
     },
     {
      :url => "https://www.musimundo.com/catalogo/1615~telefonia/1616~telefonos-celulares/Listado?page=0&limitRows=36",
      :recipe => {"title":"a.name", "brand":"a.brand@href", "permalink":"a.name@href", "price":"span.price", "image":"a.img img@src"},
      :selector => "article.product",
      :marketplace => "Musimundo",
      :paginate => "a.after@href",
      :limit => 1,
      :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]", "brand":"search=(.*)", "price": "^[^(,)]*"}

    },
    {
      :url => "https://www.musimundo.com/catalogo/1625~informatica/1629~computadoras/1633~notebook/Listado?page=0&limitRows=36",
      :recipe => {"title":"a.name", "brand":"a.brand@href", "permalink":"a.name@href", "price":"span.price", "image":"a.img img@src"},
      :selector => "article.product",
      :marketplace => "Musimundo",
      :paginate => "a.after@href",
      :limit => 1,
      :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]", "brand":"search=(.*)", "price": "^[^(,)]*"}
    },
    {
      :url => "https://www.fravega.com/celulares",
      :recipe => {"title":"div.image a@title", "permalink":"div.image a@href", "price":"em.BestPrice", "image":"div.image > a > img@src"},
      :selector => "li[layout=54558ffb-f4ae-4c69-8670-750769e299a8]",
      :marketplace => "Fravega",
      :paginate => "h1.titulo-sessao",
      :limit => 1,
      :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]", "price": "^[^(.)]*"}
    },
    {
      :url => "http://www.fravega.com/tv-y-video/tv",
      :recipe => {"title":"div.image a@title", "permalink":"div.image a@href", "price":"em.BestPrice", "image":"div.image > a > img@src"},
      :selector => "li.tv-y-video-compra-al-mejor-precio-en-fravega-com",
      :marketplace => "Fravega",
      :paginate => "li.last",
      :limit => 1,
      :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]", "price": "^[^(.)]*"}
    },
    {
      :url => "https://www.fravega.com/informatica/notebooks",
      :recipe => {"title":"div.image a@title", "permalink":"div.image a@href", "price":"em.BestPrice", "image":"div.image > a > img@src"},
      :selector => "li.informatica-compra-al-mejor-precio-en-fravega-com",
      :marketplace => "Fravega",
      :paginate => "li.last",
      :limit => 1,
      :regex => {"title":"[^\\t\\n\\s].+[^\\t\\n\\s]", "price": "^[^(.)]*"}
    }
  ]
  
end
