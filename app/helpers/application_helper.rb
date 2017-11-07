module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def favorito_link(resource)
    classes = 'no-fav'
    href    = favoritos_path(producto_id: resource.id)
    method  = :post
    counter = ''

    resource.reload

    if current_user && current_user.favorite?(resource)
      href = favorito_path(resource.id)
      classes << ' fav'
      method  = :delete
    end

    # if resource.favoritos.count > 0
    #   counter =
    #     if resource.favorites_count > 99
    #       "99+"
    #     else
    #       resource.favorites_count
    #     end
    # end

    link_to("<i class='material-icons'>favorite</i>".html_safe, href, method: method, remote: true, class: classes)
  end
end
