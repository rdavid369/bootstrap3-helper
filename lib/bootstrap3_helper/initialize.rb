module Bootstrap3Helper # :nodoc:
  # Naming convention used as to not pollute views where the module is
  # included.  @config is a common instance variable name.  We don't want
  # to risk overriding another developers variable.
  #
  @_bs3h_config = Configuration.new

  class << self
    # Simple interface for exposing the configuration object.
    #
    # @return [Bootstrap5Helper::Configuration]
    #
    def config
      yield @_bs3h_config if block_given?

      @_bs3h_config
    end
  end
end
