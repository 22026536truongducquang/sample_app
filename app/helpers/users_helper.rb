# app/helpers/users_helper.rb
module UsersHelper
  FOLLOWING = "following".freeze
  FOLLOWERS = "followers".freeze

  # Returns the Gravatar for the given user.
  def gravatar_for user, options = {size: Settings.sizes.size_80}
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def can_destroy_user? user
    current_user&.admin? && !current_user?(user)
  end

  def users_to_show user, action
    case action
    when FOLLOWING
      user.following
    when FOLLOWERS
      user.followers
    end
  end
end
