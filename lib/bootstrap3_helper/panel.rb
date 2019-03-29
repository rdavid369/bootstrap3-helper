# @root
#
#
module Bootstrap3Helper
  # @description
  # - Used to rapidly build Bootstrap Panel Components.
  #
  # <code>
  #   <%= panel_helper class: 'panel-primary' do |p| %>
  #     <%= p.header { "Some Title" }
  #     <%= p.body class: 'custom-class', id: 'custom-id' do %>
  #       //HTML or Ruby code here...
  #     <% end %>
  #     <%= p.footer do %>
  #       //HTML or Ruby
  #     <% end %>
  #   <% end %>
  # </code>
  #
  class Panel < Component
    # @description
    # - Creates a new Panel object.
    #
    # @param [Class] template - Template in which your are binding too.
    # @param [NilClass|String|Symbol|Hash] - Bootstrap class context, or options hash.
    # @param [Hash]  opts
    #   <code>
    #     opts = {
    #       id:     [String|NilClass] - The ID, if you want one, for the element.
    #       class:  [String|NilClass] - Custom class for the element.
    #     }
    #   </code>
    # @return [Panel]
    #
    def initialize(template, context_or_options = nil, opts = {})
      super(template)
      @context, args = parse_arguments(context_or_options, opts)

      @id      = args.fetch(:id, '')
      @class   = args.fetch(:class, '')
      @data    = args.fetch(:data, nil)
    end

    # @description
    # - Used to generate the header component for the panel.
    #
    # @param [Hash] args
    #
    def header(args = {})
      id = args.fetch(:id, '')
      klass = args.fetch(:class, '')
      @header = content_tag(:div, id: id, class: 'panel-heading ' + klass) do
        content_tag(:h3, class: 'panel-title') { yield if block_given? }
      end
    end

    # @description
    # - Used to generate the body component for the panel.
    #
    # @param [Hash] args
    #
    def body(args = {})
      id = args.fetch(:id, '')
      klass = args.fetch(:class, '')
      @body = content_tag(:div, id: id, class: 'panel-body ' + klass) do
        yield if block_given?
      end
    end

    # @description
    # - Used to generate the footer component for the panel.
    #
    # @param [Hash] args
    #
    def footer(args = {})
      id = args.fetch(:id, '')
      klass = args.fetch(:class, '')
      @footer = content_tag(:div, id: id, class: 'panel-footer ' + klass) do
        yield if block_given?
      end
    end

    # @description
    # - Used to render the html for the entire panel object.
    #
    # @return [String]
    #
    def to_s
      content = content_tag :div, id: @id, class: container_classes, data: @data do
        @header + @body + @footer
      end

      content
    end

    private

    # @description
    # - Used to get the container css classes.
    #
    # @return [String]
    #
    def container_classes
      "panel panel-#{@context} #{@class}"
    end
  end
end
