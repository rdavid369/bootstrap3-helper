# @root
#
#
module Bootstrap3Helper
  # @description
  #
  #
  class Configuration
    SETTINGS = %i[
      autoload_in_all_views
    ].freeze

    attr_accessor(*SETTINGS)

    # @description
    # -
    #
    # @params [Hash] args
    # @return [ClassName]
    #
    def initialize(args = {})
      @autoload_in_all_views = true
    end
  end
end
