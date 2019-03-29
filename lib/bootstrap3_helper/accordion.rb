# @root
#
#
module Bootstrap3Helper
  # @description
  # - Used to generate Bootstrap Accordion objects.
  #
  #  <code>
  #    <%= accordion_helper :primary do |accordion| %>
  #        <%= accordion.header do %>
  #            <span class="something">This is the heading....</span>
  #        <% end %>
  #        <%= accordion.body do %>
  #            <p>This is the body of the accordion....</p>
  #        <% end %>
  #    <% end %>
  #  </code>
  #
  class Accordion < Component
    # @description
    # - Initlize a new accordion object.  If this part of a parent element, i.e
    # AccordionGroup, we need to keep track of the parent element id, so we can
    # pass it down to the other components.
    #
    # @param [Class] template - Template in which your are binding too.
    # @param [NilClass|String|Symbol|Hash] - Bootstrap class context, or options hash.
    # @param [Hash] opts
    #   <code>
    #      args = {
    #        parent_id:   [String]
    #        id:          [String]
    #        class:       [String]
    #        collapse_id: [String]
    #        expanded:    Boolean
    #      }
    #   </code>
    # @return [Accordion]
    #
    def initialize(template, context_or_options = nil, opts = {})
      super(template)
      @context, args = parse_arguments(context_or_options, opts)

      @parent_id   = args.fetch(:parent_id, nil)
      @id          = args.fetch(:id, nil)
      @class       = args.fetch(:class, '')
      @collapse_id = args.fetch(:collapse_id, uuid)
      @expanded    = args.fetch(:expanded, false)
    end

    # @description
    # - Creates the header element for the accordion
    #
    # @note
    # - NilClass :to_s  returns an empty String
    #
    # @params [Hash] args
    #   <code>
    #      args = {
    #        id:      [String]
    #        class:   [String]
    #        data:    [Hash]
    #      }
    #   </code>
    #
    # @yields [Accordion] self
    # @return [NilClass]
    #
    # rubocop:disable Metrics/MethodLength
    def header(args = {})
      id    = args.fetch(:id, nil)
      klass = args.fetch(:class, '')
      data  = args.fetch(:data, {})

      data[:toggle] = 'collapse'
      data[:parent] = "##{@parent_id}"

      @header = content_tag :div, id: id, class: 'panel-heading ' + klass do
        content_tag :h3, class: 'panel-title' do
          content_tag :a, href: "##{@collapse_id}", data: data do
            content = yield if block_given?
            content.to_s.html_safe
          end
        end
      end
    end
    # rubocop:enable Metrics/MethodLength

    # @description
    # - Creates the body element for the accordion.
    #
    # @note
    # - NilClass :to_s  returns an empty String
    #
    # @params [Hash] args
    #   <code>
    #      args = {
    #        id:      [String]
    #        class:   [String]
    #        data:    [Hash]
    #      }
    #   </code>
    #
    # @yields [Accordion] self
    # @return [nilClass]
    #
    #
    def body(args = {})
      klass = 'panel-collapse collapse '
      data  = args.fetch(:data, {})
      klass += args.fetch(:class, '')
      klass += ' in' if @expanded

      @body = content_tag :div, id: @collapse_id, class: klass do
        content_tag :div, class: 'panel-body', data: data do
          content = yield if block_given?
          content.to_s.html_safe
        end
      end
    end

    # @description
    # - Creates the footer element for the accordion
    #
    # @params [Hash] args
    #   <code>
    #      args = {
    #        id:      [String]
    #        class:   [String]
    #        data:    [Hash]
    #      }
    #   </code>
    #
    # @yields [Accordion] self
    # @return [nilClass]
    #
    #
    def footer(args = {})
      id    = args.fetch(:id, nil)
      klass = args.fetch(:class, '')
      data  = args.fetch(:data, {})

      @footer = content_tag :div, id: id, class: 'panel-footer ' + klass, data: data do
        content = yield if block_given?
        content.to_s.html_safe
      end
    end

    # @description
    # - The to string method here is what is responsible for rendering out the
    # accordion element.  As long as the main method is rendered out in the
    # helper, you will get the entire accordion.
    #
    # @return [String]
    #
    def to_s
      content = content_tag :div, id: @id, class: container_classes do
        @header + @body + @footer
      end

      content
    end

    private

    # @description
    # - Used to get the container element classes
    #
    # @return [String]
    #
    def container_classes
      "panel panel-#{@context} #{@class}"
    end
  end
end
