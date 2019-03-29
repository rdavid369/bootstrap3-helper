# @root
#
#
module Bootstrap3Helper
  # @description
  # - Used to rapidly generated Bootstrap Tabs Components.
  #
  # @note
  # - On menu items - you can pass in either symbol or string for the link. If
  # you pass in a block, it will use the block for the title of the li.  If no
  # block is present, then it will titleize the symbol or string.
  #
  # Tabs::Menu will respond to <code>item</code> and <code>dropdown</code>
  # Each method will yield the corresponding component, either a Tabs::Menu
  # or a Tabs::Dropdown.
  #
  # <code>
  #  <%= tabs_helper type: :pills do |menu, content| %>
  #    <% menu.item(:testing1, class: 'active') { ' Testing 1' } %>
  #    <% menu.item :testing2 %>
  #    <% menu.item(:testing3) { ' Testing 3' } %>
  #    <% menu.dropdown 'Testing Dropdown' do |dropdown| %>
  #        <%= dropdown.item(:testing5 ) { 'Testing 5' } %>
  #        <%= dropdown.item(:testing6 ) { 'Testing 6' } %>
  #        <%= dropdown.item(:testing7 ) { 'Testing 7' } %>
  #    <% end %>
  #
  #    <% content.item :testing1, class: 'active' do %>
  #        Testing 1 content
  #    <% end %>
  #    <% content.item :testing2 do %>
  #        Testing 2 content
  #    <% end %>
  #    <% content.item :testing3 do %>
  #        Testing 3 content
  #    <% end %>
  #    <% content.item :testing5 do %>
  #        Testing 5 content
  #    <% end %>
  #    <% content.item :testing6 do %>
  #        Testing 6 content
  #    <% end %>
  #    <% content.item :testing7 do %>
  #        Testing 7 content
  #    <% end %>
  #  <% end %>
  # </code>
  class Tabs < Component
    # @description
    # - Creates a new Tabs object.
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
      @type  = args.fetch(:type, :tabs)
      @id    = args.fetch(:id, nil)
      @class = args.fetch(:class, '')

      @tab_menu = Tabs::Menu.new(@template, type: @type)
      @tab_content = Tabs::Content.new(@template)
    end

    # @description
    # - Allows you access the Tabs::Menu object.
    #
    # @return [Tabs::Menu]
    #
    def menu
      @tab_menu
    end

    # @description
    # - Allows you to access the Tabs::Content object
    #
    # @return [Tabs::Content]
    #
    def content
      @tab_content
    end

    # @description
    # - Used to render out the HTML of the Tabs Object
    #
    # @return [String]
    #
    def to_s
      html = content_tag :div, id: @id, class: @class do
        menu.to_s + content.to_s
      end

      html
    end
  end
end
