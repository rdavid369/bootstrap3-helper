module Bootstrap3Helper # :nodoc:
  # Used to rapidly generated Bootstrap Tabs Components.
  #
  # @note On menu items - you can pass in either symbol or string for the link. If
  #   you pass in a block, it will use the block for the title of the li.  If no
  #   block is present, then it will titleize the symbol or string.
  #
  #   Tabs::Menu will respond to <code>item</code> and <code>dropdown</code>
  #   Each method will yield the corresponding component, either a Tabs::Menu
  #   or a Tabs::Dropdown.
  #
  # @example Rendering out a Bootstrap Tab components in a view:
  #   <%= tabs_helper type: :pills do |menu, content| %>
  #     <%= menu.item(:testing1, class: 'active') { ' Testing 1' } %>
  #     <%= menu.item :testing2 %>
  #     <%= menu.item(:testing3) { ' Testing 3' } %>
  #     <%= menu.dropdown 'Testing Dropdown' do |dropdown| %>
  #         <%= dropdown.item(:testing5 ) { 'Testing 5' } %>
  #         <%= dropdown.item(:testing6 ) { 'Testing 6' } %>
  #         <%= dropdown.item(:testing7 ) { 'Testing 7' } %>
  #     <% end %>
  # 
  #     <%= content.item :testing1, class: 'active' do %>
  #         Testing 1 content
  #     <% end %>
  #     <%= content.item :testing2 do %>
  #         Testing 2 content
  #     <% end %>
  #     <%= content.item :testing3 do %>
  #         Testing 3 content
  #     <% end %>
  #     <%= content.item :testing5 do %>
  #         Testing 5 content
  #     <% end %>
  #     <%= content.item :testing6 do %>
  #         Testing 6 content
  #     <% end %>
  #     <%= content.item :testing7 do %>
  #         Testing 7 content
  #     <% end %>
  #   <% end %>
  #
  class Tabs < Component
    # Creates a new Tabs object.
    #
    # @param [ActionView] template - Template in which your are binding too.
    # @param [Hash]  args
    # @option args [String|Symbol] :type  Used to tell the helper which tab version - :tabs|:pills
    # @option args [String]        :id    The ID, if you want one, for the parent container
    # @option args [String]        :class Custom class for the parent container.
    #
    def initialize(template, args = {}, &block)
      super(template)

      @type    = args.fetch(:type,  :tabs)
      @id      = args.fetch(:id,    nil)
      @class   = args.fetch(:class, '')
      @content = block || proc { '' }
    end

    # Allows you access the Tabs::Menu object.
    #
    # @see Tabs::Menu
    # @return [Tabs::Menu]
    #
    def menu(args = {}, &block)
      Tabs::Menu.new(@template, args.merge(type: @type), &block)
    end

    # Allows you to access the Tabs::Content object
    #
    # @see Tabs::Content
    # @return [Tabs::Content]
    #
    def content(args = {}, &block)
      Tabs::Content.new(@template, args, &block)
    end

    # Used to render out the HTML of the Tabs Object
    #
    # @return [String]
    #
    def to_s
      content_tag :div, id: @id, class: @class do
        @content.call(self)
      end
    end
  end
end
