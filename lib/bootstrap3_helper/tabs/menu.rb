module Bootstrap3Helper # :nodoc:
  class Tabs
    # Used to rapidly generated Bootstrap Tabs Menu Components.
    #
    # @example Rendering out a Tabs::Menu component:
    #   <code>
    #     <% menu.item(:testing3) { ' Testing 3' } %>
    #   </code>
    #
    class Menu < Component
      # Creates a new Tabs::Menu object.
      #
      # @param [ActionView] template - Template in which your are binding too.
      # @param [Hash]  args
      # @option args [Symbol] type  Used to tell the helper which tab version :tabs|:pills
      # @option args [String] id    The ID, if you want one, for the parent container
      # @option args [String] class Custom class for the parent container
      #
      def initialize(template, args = {}, &block)
        super(template)

        @id      = args.fetch(:id, nil)
        @class   = args.fetch(:class, '')
        @type    = args.fetch(:type, :tabs)
        @content = block || proc { '' }
      end

      # rubocop:disable Metrics/MethodLength

      # Adds a new menu item to the object.
      #
      # @note You can opt out of passing in a block and the li will use
      #   the name attribute for the menu item.
      #
      # @param [String|Symbol] name Used to link nav li to tab-content
      # @param [Hash]  args
      # @option args [String] :id
      # @option args [String] :class
      # @option args [Hash]   :data
      # @yieldreturn [String]
      #
      def item(name, args = {})
        id     = args.fetch(:id, nil)
        data   = args.fetch(:data, nil)
        klass  = args.fetch(:class, '')
        active = klass.include? 'active'

        li = content_tag(
          :li,
          id:    id,
          class: klass,
          data:  data,
          role:  'presentation'
        ) do
          content_tag(
            :a,
            href:     "##{name}",
            role:     'tab',
            tabindex: -1,
            data:     { toggle: 'tab' },
            aria:     { controls: "##{name}", expanded: active, selected: active }
          ) do
            block_given? ? yield : name.to_s.titleize
          end
        end
      end
      # rubocop:enable Metrics/MethodLength

      # Used to create menu items that are Dropdowns
      #
      # @param [String|Symbol] name
      # @param [Hash] args
      # @option args [String] :id
      # @option args [String] :class
      # @option args [Hash]   :data
      # @yieldparam dropdown [Tabs::Dropdown]
      #
      def dropdown(name, args = {}, &block)
        id       = args.fetch(:id, nil)
        data     = args.fetch(:data, nil)
        klass    = args.fetch(:class, '')
        dropdown = Tabs::Dropdown.new(@template, name, &block)

        content = content_tag :li, id: id, class: 'dropdown' + klass, data: data do
          dropdown.to_s.html_safe
        end
      end

      # Used to render out the contents of the menu.
      #
      # @return [String]
      #
      def to_s
        content_tag :ul, id: @id, class: "nav nav-#{@type} " + @class, role: 'tablist' do
          @content.call(self)
        end
      end
    end
  end
end
