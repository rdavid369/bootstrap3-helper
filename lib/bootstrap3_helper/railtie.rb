require 'bootstrap3_helper'

module Bootstrap3Helper
  # @description
  # - Used to tie into the ActionView
  #
  class Railtie < Rails::Railtie
    initializer 'bootsrap3_helper' do
      ActiveSupport.on_load(:action_view) { include Bootstrap3Helper }
    end
  end
end
