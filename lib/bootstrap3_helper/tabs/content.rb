# @description
# - Root Object
#
module Bootstrap3Helper
  class Tabs
    # @description
    # - Used to rapidly generated Bootstrap Tabs Content Components.
    #
    class Content < Component
      # @description
      # - Creates a new Tabs::Menu object.
      #
      # @param [Class] template - Template in which your are binding too.
      # @param [Hash]  args
      #   <code>
      #     args = {
      #       id:     [String|nilClass] - The ID, if you want one, for the parent container
      #       class:  [String|nilClass] - Custom class for the parent container
      #     }
      #   </code>
      #
      def initialize(template, args = {})
        super(template)

        @id    = args.fetch(:id, nil)
        @class = args.fetch(:class, '')
        @items = []
      end

      # @description
      # - Adds a new tabe-pane item to the object.
      #
      # @param [String|Symbol] name - Used to link to  the nav menu item.
      # @param [Hash]  args
      #   <code>
      #     args = {
      #       class:  [String|nilClass] - Custom class for the div element
      #       data:   [Hash] - Any data attributes you wish to assign to div element.
      #     }
      #   </code>
      #
      def item(name, args = {})
        data   = args.fetch(:data, nil)
        klass  = args.fetch(:class, '')
        active = klass.include? 'active'

        content = content_tag(
          :div,
          id:       name,
          class:    "tab-pane fade #{active ? 'in' : ''} #{klass}",
          aria:     { hidden: active },
          data:     data,
          role:     'tabpanel',
          tabindex: -1
        ) do
          yield if block_given?
        end

        @items.push(content)
      end

      # @description
      # - Used to render out the object as HTML
      #
      # @return [String]
      #
      def to_s
        html = content_tag :div, id: @id, class: 'tab-content' + @class do
          @items.collect(&:to_s).join.html_safe
        end

        html
      end
    end
  end
end
