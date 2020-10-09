module Bootstrap3Helper # :nodoc:
  # Used to rapidly build Bootstrap Panel Components.
  #
  # @example Rendering a Bootstrap Panel Component in a view:
  #   <%= panel_helper class: 'panel-primary' do |p| %>
  #     <%= p.header { "Some Title" }
  #     <%= p.body class: 'custom-class', id: 'custom-id' do %>
  #       //HTML or Ruby code here...
  #     <% end %>
  #     <%= p.footer do %>
  #       //HTML or Ruby
  #     <% end %>
  #   <% end %>
  #
  class Panel < Component
    # Creates a new Panel object.
    #
    # @param [ActionView] template Template in which your are binding too.
    # @param [NilClass|String|Symbol|Hash] context_or_options Bootstrap class context, or options hash.
    # @param [Hash]  opts
    # @option opts [String]  :id    The ID of the element
    # @option opts [String]  :class Custom class for the component.
    # @option opts [Hash]    :data  Any data attributes for the element.
    # @return [Panel]
    #
    def initialize(template, context_or_options = nil, opts = {}, &block)
      super(template)
      @context, args = parse_arguments(context_or_options, opts)

      @id      = args.fetch(:id, '')
      @class   = args.fetch(:class, '')
      @data    = args.fetch(:data, nil)
      @content = block || proc { '' }
    end

    # Used to generate the header component for the panel.
    #
    # @param [Hash] args
    # @option args [String]  :id    The ID of the element
    # @option args [String]  :class Custom class for the component.
    # @yieldreturn [String]
    #
    def header(args = {}, &block)
      id    = args.fetch(:id, '')
      klass = args.fetch(:class, '')

      content_tag(:div, id: id, class: 'panel-heading ' + klass) do
        content_tag(:h3, class: 'panel-title', &block)
      end
    end

    # Used to generate the body component for the panel.
    #
    # @param [Hash] args
    # @option args [String]  :id    The ID of the element
    # @option args [String]  :class Custom class for the component.
    # @yieldreturn [String]
    #
    def body(args = {}, &block)
      id    = args.fetch(:id, '')
      klass = args.fetch(:class, '')

      content_tag(:div, id: id, class: 'panel-body ' + klass, &block)
    end

    # Used to generate the footer component for the panel.
    #
    # @param [Hash] args
    # @option args [String]  :id    The ID of the element
    # @option args [String]  :class Custom class for the component.
    # @yieldreturn [String]
    #
    def footer(args = {}, &block)
      id    = args.fetch(:id, '')
      klass = args.fetch(:class, '')

      content_tag(:div, id: id, class: 'panel-footer ' + klass, &block)
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
