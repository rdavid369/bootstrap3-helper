module Bootstrap3Helper
  # @description
  # - Used to tie into the ActionView
  #
  class Railtie < Rails::Railtie
    config.after_initialize do
      ActiveSupport.on_load(:action_view) do
        include Bootstrap3Helper if Bootstrap3Helper.config.autoload_in_views?
      end
    end
  end
end
