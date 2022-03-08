module CanvasCustomDataApi
  class Engine < Rails::Engine
    config.paths['app'].eager_load!

    config.to_prepare do
      Canvas::Plugin.register :canvas_custom_data_api, nil, {
        name: ->{ t :name, 'Bulk Custom User Data API' },
        author: 'Atomic Jolt',
        description: ->{ t :description, 'Bulk Custom User Data API' },
        version: '0.1.0',
        settings_partial: 'plugins/custom_data_api',
        settings: {
          enabled: false,
        },
      }
    end
  end

  def self.enabled?
    if plugin = Canvas::Plugin.find(:canvas_custom_data_api)
      return plugin.settings[:enabled].to_s == 'true'
    end
    false
  end
end
