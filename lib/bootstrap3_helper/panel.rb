module Bootstrap3Helper # :nodoc:
  # Used to rapidly build Bootstrap Panel Components.
  #
  #
  class Panel < Component
    # Creates a new Panel object.
    #
    # @param [ActionView] template - Template in which your are binding too.
    # @param [NilClass|String|Symbol|Hash] context_or_options - Bootstrap class context, or options hash.
    # @param [Hash]  opts
    # @option opts [String]  :id    - The ID of the element
    # @option opts [String]  :class - Custom class for the component.
    # @option opts [Hash]    :data  - Any data attributes for the element.
    # @option opts [Symbol]  :config_type - Used to change config from Panel to Accordion.
    # @return [Panel]
    #
    def initialize(template, context_or_options = nil, opts = {}, &block)
      super(template)
      @context, args = parse_context_or_options(context_or_options, opts)

      @id          = args.fetch(:id,          '')
      @class       = args.fetch(:class,       '')
      @data        = args.fetch(:data,        nil)
      @config_type = args.fetch(:config_type, :panels)
      @content     = block || proc { '' }
    end

    # Used to generate the header component for the panel.
    #
    # @param  [Symbol|String|Hash|NilClass] tag_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @option opts [Hash]   :aria
    # @return [String]
    #
    def header(tag_or_options = nil, opts = {}, &block)
      tag, args = parse_tag_or_options(tag_or_options, opts)

      id    = args.fetch(:id,    nil)
      klass = args.fetch(:class, '')
      data  = args.fetch(:data,  {})
      aria  = args.fetch(:aria,  {})

      content_tag(
        tag || config({ @config_type => :header }, :div),
        id:    id,
        class: "panel-heading #{klass}",
        data:  data,
        aria:  aria,
        &block
      )
    end

    # Builds a title component for the panel.
    #
    # @param  [Symbol|String|Hash|NilClass] tag_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @option opts [Hash]   :aria
    # @return [String]
    #
    def title(tag_or_options = nil, opts = {}, &block)
      tag, args = parse_tag_or_options(tag_or_options, opts)

      id    = args.fetch(:id,    nil)
      klass = args.fetch(:class, '')
      data  = args.fetch(:data,  {})
      aria  = args.fetch(:aria,  {})

      content_tag(
        tag || config({ @config_type => :title }, :h3),
        id:    id,
        class: "panel-title #{klass}",
        data:  data,
        aria:  aria,
        &block
      )
    end

    # Used to generate the body component for the panel.
    #
    # @param  [Symbol|String|Hash|NilClass] tag_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @option opts [Hash]   :aria
    # @return [String]
    #
    def body(tag_or_options = nil, opts = {}, &block)
      tag, args = parse_tag_or_options(tag_or_options, opts)

      id    = args.fetch(:id,    nil)
      klass = args.fetch(:class, '')
      data  = args.fetch(:data,  {})
      aria  = args.fetch(:aria,  {})

      content_tag(
        tag || config({ @config_type => :body }, :div),
        id:    id,
        class: "panel-body #{klass}",
        data:  data,
        aria:  aria,
        &block
      )
    end

    # Used to generate the footer component for the panel.
    #
    # @param  [Symbol|String|Hash|NilClass] tag_or_options
    # @param  [Hash] opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @option opts [Hash]   :aria
    # @return [String]
    #
    def footer(tag_or_options = nil, opts = {}, &block)
      tag, args = parse_tag_or_options(tag_or_options, opts)

      id    = args.fetch(:id,    nil)
      klass = args.fetch(:class, '')
      data  = args.fetch(:data,  {})
      aria  = args.fetch(:aria,  {})

      content_tag(
        tag || config({ @config_type => :footer }, :div),
        id:    id,
        class: "panel-footer #{klass}",
        data:  data,
        aria:  aria,
        &block
      )
    end

    # Used to render the html for the entire panel object.
    #
    # @return [String]
    #
    def to_s
      content_tag :div, id: @id, class: container_classes, data: @data do
        @content.call(self)
      end
    end

    private

    # Used to get the container css classes.
    #
    # @return [String]
    #
    def container_classes
      "panel panel-#{@context} #{@class}"
    end
  end
end
