# @root
#
#
module Bootstrap3Helper
  # @description
  #
  #
  class Configuration
    DEFAULT_SETTINGS = {
      autoload_in_all_views: true,
      accodions:             {
        header: :div,
        body:   :div,
        footer: :div,
        title:  :h4
      },
      panels:                {
        header: :div,
        body:   :div,
        footer: :div,
        title:  :h3
      }
    }.freeze

    attr_accessor(*DEFAULT_SETTINGS.keys)

    # Class constructor
    #
    # @param  [Hash] _args
    # @return [ClassName]
    #
    def initialize(_args = {})
      @autoload_in_all_views = true
    end
  end
end
