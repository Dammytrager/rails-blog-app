module UsersHelper

  GRAVATR_URL = 'https://www.gravatar.com/avatar'

  def gravatar_for(user, **args)
    defaults = { size: 80 }

    options = defaults.merge(args)

    hash = Digest::MD5.hexdigest(user.email)
    gravatar_url = "#{GRAVATR_URL}/#{hash}?s=#{options[:size]}"

    image_tag(gravatar_url, alt: user.username, class: 'rounded mx-auto d-block mb-3')
  end

end