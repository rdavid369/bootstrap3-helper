# @description
# - Root Object
#
module Bootstrap3Helper
  class Tabs
    # @description
    #  - Used to rapidly build dropdown menus for Bootstrap tabs.
    #
    # <code>
    #   <% menu.dropdown 'Testing Dropdown' do |dropdown| %>
    #      <%= dropdown.item(:testing5 ) { 'Testing 5' } %>
    #      <%= dropdown.item(:testing6 ) { 'Testing 6' } %>
    #      <%= dropdown.item(:testing7 ) { 'Testing 7' } %>
    #   <% end %>
    # </code>
    #
    class Dropdown < Component
      # @description
      # - Creates a new Tabs::Dropdown object.
      #
      # @param [Class] template - Template in which your are binding too.
      #
      def initialize(template, name = '')
        super(template)

        @name  = name
        @items = []
      end

      # @description
      # - Adds a new item to the dropdown object.
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
      # rubocop:disable Metrics/MethodLength
      def item(name, args = {})
        id     = args.fetch(:id, nil)
        klass  = args.fetch(:class, '')
        data   = args.fetch(:data, nil)
        active = klass.include? 'active'

        li = content_tag(
          :li,
          id:    id,
          class: klass,
          data:  data
        ) do
          content_tag(
            :a,
            href: "##{name}",
            role: 'tab',
            data: { toggle: 'tab' },
            aria: { controls: name, expanded: active }
          ) do
            block_given? ? yield : name.to_s.titleize
          end
        end

        @items.push(li)
      end
      # rubocop:enable Metrics/MethodLength

      # @description
      # - Used to render out the object and get the HTML representation.
      #
      # @return [String]
      #
      def to_s
        content = content_tag :a, @name, href: '#', class: 'dropdown-toggle', data: { toggle: 'dropdown' }, aria: { expanded: false }

        content += content_tag :ul, id: @id, class: 'dropdown-menu ' do
          @items.collect(&:to_s).join.html_safe
        end

        content
      end
    end
  end
end
