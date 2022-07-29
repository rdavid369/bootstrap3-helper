module Bootstrap3Helper # :nodoc:
  class Tabs
    # Used to rapidly build dropdown menus for Bootstrap tabs.
    #
    # @example Rendering a Dropdown menu component:
    #   <code>
    #     <%= menu.dropdown 'Testing Dropdown' do |dropdown| %>
    #         <%= dropdown.item(:testing5 ) { 'Testing 5' } %>
    #         <%= dropdown.item(:testing6 ) { 'Testing 6' } %>
    #         <%= dropdown.item(:testing7 ) { 'Testing 7' } %>
    #     <% end %>
    #   </code>
    #
    class Dropdown < Component
      # Creates a new Tabs::Dropdown object.
      #
      # @param [ActionView] template Template in which your are binding too.
      # @param [String]     name
      #
      def initialize(template, name = '', &block)
        super(template)

        @name    = name
        @content = block || proc { '' }
      end

      # rubocop:disable Metrics/MethodLength

      # Adds a new item to the dropdown object.
      #
      # @note You can opt out of passing in a block and the li will use the name attribute
      #   for the menu item.
      #
      # @param [String|Symbol] name - Used to link nav li to tab-content
      # @param [Hash]  args
      # @option args [String] :id The ID, if you want one, for the li element.
      # @option args [String] :class Custom class for the li element.
      # @option args [Hash]   :data Any data attributes you want on the li element.
      # @yieldreturn [String]
      #
      def item(name, args = {})
        id     = args.fetch(:id, nil)
        klass  = args.fetch(:class, '')
        data   = args.fetch(:data, nil)
        active = klass.include? 'active'

        content_tag(
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
      end
      # rubocop:enable Metrics/MethodLength

      # Used to render out the object and get the HTML representation.
      #
      # @return [String]
      #
      def to_s
        content = content_tag(
          :a,
          @name,
          href:  '#',
          class: 'dropdown-toggle',
          data: { toggle: 'dropdown' }, aria: { expanded: false }
        )

        content + content_tag(:ul, id: @id, class: 'dropdown-menu ') do
          @content.call(self)
        end
      end
    end
  end
end
