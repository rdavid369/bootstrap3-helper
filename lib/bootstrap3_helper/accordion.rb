module Bootstrap3Helper # :nodoc:
  # Used to generate Bootstrap Accordion objects.
  #
  # @example Render out an Accordion component in a template:
  #   <code>
  #     <%= accordion_helper :primary do |accordion| %>
  #         <%= accordion.header do %>
  #             <span class="something">This is the heading....</span>
  #         <% end %>
  #         <%= accordion.body do %>
  #             <p>This is the body of the accordion....</p>
  #         <% end %>
  #     <% end %>
  #   </code>
  #
  class Accordion < Component
    # Initlize a new accordion object.  If this part of a parent element, i.e
    # AccordionGroup, we need to keep track of the parent element id, so we can
    # pass it down to the other components.
    #
    # @param [Class] template - Template in which your are binding too.
    # @param [NilClass|String|Symbol|Hash] - Bootstrap class context, or options hash.
    # @param [Hash] opts
    # @option opts [String]  :parent_id   The parent element ID if this accordion is part of a group.
    # @option opts [String]  :id          The ID of the element
    # @option opts [String]  :class       Custom class for the component.
    # @option opts [String]  :collapse_id The ID of the element to collapse when clicked.
    # @option opts [Boolean] :expanded    Initial state of the accordion.
    # @return [Accordion]
    #
    def initialize(template, context_or_options = nil, opts = {}, &block)
      super(template)
      @context, args = parse_arguments(context_or_options, opts)

      @parent_id   = args.fetch(:parent_id, nil)
      @id          = args.fetch(:id, nil)
      @class       = args.fetch(:class, '')
      @collapse_id = args.fetch(:collapse_id, uuid)
      @expanded    = args.fetch(:expanded, false)
      @content     = block || proc { '' }
      @panel       = Panel.new(@template, context_or_options, opts)
    end

    # rubocop:disable Metrics/MethodLength

    # Creates the header element for the accordion
    #
    # @note NilClass :to_s  returns an empty String
    #
    # @params [Hash] args
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @yieldreturn [String]
    #
    def header(args = {}, &block)
      data          = args.fetch(:data, {})
      data[:toggle] = 'collapse'
      data[:parent] = "##{@parent_id}" if @parent_id.present?

      @panel.header(args) do
        content_tag(
          :a,
          href: "##{@collapse_id}",
          role: 'button',
          data: data,
          aria: { expanded: @expanded, controls: "##{@collapse_id}" },
          &block
        )
      end
    end
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength

    # Creates the body element for the accordion.
    #
    # @note NilClass :to_s  returns an empty String
    #
    # @params [Hash] args
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @yieldreturn [String]
    #
    def body(args = {}, &block)
      klass = 'panel-collapse collapse '
      klass += ' in' if @expanded

      content_tag(
        :div,
        id:    @collapse_id,
        role:  'tabpanel',
        class: klass,
        aria:  { labelledby: "##{@collapse_id}" }
      ) do
        @panel.body(args, &block)
      end
    end
    # rubocop:enable Metrics/MethodLength

    # Creates the footer element for the accordion
    #
    # @params [Hash] args
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    # @yieldreturn [String]
    #
    def footer(args = {}, &block)
      @panel.footer(args, &block)
    end

    # The to string method here is what is responsible for rendering out the
    # accordion element.  As long as the main method is rendered out in the
    # helper, you will get the entire accordion.
    #
    # @return [String]
    #
    def to_s
      content = content_tag :div, id: @id, class: container_classes do
        @content.call(self)
      end
    end

    private

    # Used to get the container element classes
    #
    # @return [String]
    #
    def container_classes
      "panel panel-#{@context} #{@class}"
    end
  end
end
