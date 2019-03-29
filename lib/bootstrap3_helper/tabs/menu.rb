# @description
# - Root Object
#
module Bootstrap3Helper
  class Tabs
    # @description
    # - Used to rapidly generated Bootstrap Tabs Menu Components.
    #
    # <code>
    #   <% menu.item(:testing3) { ' Testing 3' } %>
    # </code>
    #
    class Menu < Component
      # @description
      # - Creates a new Tabs::Menu object.
      #
      # @param [Class] template - Template in which your are binding too.
      # @param [Hash]  args
      #   <code>
      #     args = {
      #       type:   [String|Symbol] - Used to tell the helper which tab version - :tabs|:pills
      #       id:     [String|nilClass] - The ID, if you want one, for the parent container
      #       class:  [String|nilClass] - Custom class for the parent container
      #     }
      #   </code>
      #
      def initialize(template, args = {})
        super(template)

        @id    = args.fetch(:id, nil)
        @class = args.fetch(:class, '')
        @type  = args.fetch(:type, :tabs)
        @items = []
      end

      # @description
      # - Adds a new menu item to the object.
      #
      # @note
      # - You can opt out of passing in a block and the li will use the name attribute
      # for the menu item.
      #
      # @param [String|Symbol] name - Used to link nav li to tab-content
      # @param [Hash]  args
      #   <code>
      #     args = {
      #       id:     [String|Symbol] - Custom ID for li element.
      #       class:  [String|nilClass] - Custom class for the li element
      #       data:   [Hash] - Any data attributes you wish to assign to li element.
      #     }
      #   </code>
      #
      def item(name, args = {})
        id    = args.fetch(:id, nil)
        data  = args.fetch(:data, nil)
        klass = args.fetch(:class, '')

        li = content_tag :li, id: id, class: klass, data: data, role: 'presentation' do
          content_tag :a, href: "##{name}", data: { toggle: 'tab' }, aria: { controls: '' } do
            block_given? ? yield : name.to_s.titleize
          end
        end

        @items.push(li)
      end

      # @description
      # - Used to create menu items that are Dropdowns
      #
      # @param [String|Symbol] name - 
      #
      def dropdown(name, args = {})
        id    = args.fetch(:id, nil)
        data  = args.fetch(:data, nil)
        klass = args.fetch(:class, '')

        dropdown = Tabs::Dropdown.new(@template, name)
        yield dropdown if block_given?

        content = content_tag :li, id: id, class: 'dropdown' + klass, data: data do
          dropdown.to_s
        end

        @items.push(content)
      end

      # @description
      # - Used to render out the contents of the menu.
      #
      # @return [String]
      #
      def to_s
        html = content_tag :ul, id: @id, class: "nav nav-#{@type} " + @class, role: 'tablist' do
          @items.collect(&:to_s).join.html_safe
        end

        html
      end
    end
  end
end
