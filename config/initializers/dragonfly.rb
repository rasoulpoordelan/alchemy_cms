require 'dragonfly_svg'

# Alchemy CMS Dragonfly configuration.

# Pictures
Dragonfly.app(:alchemy_pictures).configure do
  dragonfly_url nil
  plugin :imagemagick
  plugin :svg
  secret "e745bd621876cb2a5c00ebd61dd1da28afac30c6a57a95518b62243fd11bee7a"
  url_format "/pictures/:job/:sha/:basename.:ext"

  datastore :file,
    root_path:  Rails.root.join('uploads/pictures').to_s,
    server_root: Rails.root.join('public'),
    store_meta: false

  # If caching is enabled in host app, we store the rendered
  # image into `public/pictures`, so the webserver can pick it up
  # and serve it directly to the client.
  before_serve do |job, env|
    if Rails.application.config.action_controller.perform_caching
      path = env['PATH_INFO'].sub(/^\//, '')
      job.to_file(Rails.root.join('public', Alchemy::MountPoint.get, path))
    end
  end
end

# Attachments
Dragonfly.app(:alchemy_attachments).configure do
  datastore :file,
    root_path:  Rails.root.join('uploads/attachments').to_s,
    store_meta: false
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware, :alchemy_pictures

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
