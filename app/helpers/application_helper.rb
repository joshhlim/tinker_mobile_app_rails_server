module ApplicationHelper
  # def gravatar_for(user, opts = {})
  #   opts[:alt] = user.name
  #   image_tag Faker::Avatar.image("my-own-slug", "50x50"),
  #             opts
  # end
  include JsonWebToken
end
