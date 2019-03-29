# @root
#
#
module Bootstrap3Helper
  # @description
  # - Used to generate Bootstrap callout component quickly.
  #
  # @param [Class] template - Template in which your are binding too.
  # @param [NilClass|String|Symbol|Hash] - Bootstrap class context, or options hash.
  # @param [Hash]  opts
  #   <code>
  #     opts = {
  #       id:     [String] - ID of the alert box
  #       class:  [String] - Additional classes for the alert box
  #     }
  #   </code>
  # @param [Proc] &block
  # @return [Callout]
  #
  class Callout < Component
    def initialize(template, context_or_options = nil, opts = {}, &block)
      super(template)
      @context, args = parse_arguments(context_or_options, opts)

      @id = args.fetch(:id, nil)
      @class = args.fetch(:class, '')
      @content = block || proc { '' }
    end

    # @description
    # - Returns a string representation of the component.
    #
    # @return [String]
    #
    def to_s
      content_tag :div, id: @id, class: container_class do
        @content.call
      end
    end

    private

    # @description
    # - Used to get the container classes.
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
