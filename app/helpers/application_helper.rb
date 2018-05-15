module ApplicationHelper
  def gravatar_for user, options = {size: 80}
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def artist_collection
    Artist.select(:id, :name)
  end

  def category_collection
    Category.select(:id, :name)
  end

  def album_collection
    Album.select(:id, :name)
  end

  def song_collection
    Song.select(:id, :name)
  end
end
