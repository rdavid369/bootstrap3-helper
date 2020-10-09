module Bootstrap3Helper # :nodoc:
  # Used to generate Bootstrap callout component quickly.
  #
  #
  class Callout < Component
    # @param  [ActionView] template Template in which your are binding too.
    # @param  [NilClass|String|Symbol|Hash] context_or_options Bootstrap class context, or options hash.
    # @param  [Hash]  opts
    # @option opts [String]  :id    The ID of the element
    # @option opts [String]  :class Custom class for the component.
    # @return [Callout]
    #
    def initialize(template, context_or_options = nil, opts = {}, &block)
      super(template)
      @context, args = parse_arguments(context_or_options, opts)

      @id      = args.fetch(:id, nil)
      @class   = args.fetch(:class, '')
      @content = block || proc { '' }
    end

    # Returns a string representation of the component.
    #
    # @return [String]
    #
    def to_s
      content_tag :div, id: @id, class: container_class do
        @content.call(self)
      end
    end

    private

    # Used to get the container classes.
    #
    # @return [String]
    #
    def container_class
      string = 'callout '
      string += "callout-#{@context}"
      string += " #{@class}"
      string
    end
  end
end
