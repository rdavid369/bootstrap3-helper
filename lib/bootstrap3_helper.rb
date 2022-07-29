require 'bootstrap3_helper/version'
require 'bootstrap3_helper/configuration'
require 'bootstrap3_helper/initialize'

# Implementation files
require 'bootstrap3_helper/component'
require 'bootstrap3_helper/accordion'
require 'bootstrap3_helper/accordion_group'
require 'bootstrap3_helper/alert'
require 'bootstrap3_helper/callout'
require 'bootstrap3_helper/panel'
require 'bootstrap3_helper/tabs'
require 'bootstrap3_helper/tabs/content'
require 'bootstrap3_helper/tabs/dropdown'
require 'bootstrap3_helper/tabs/menu'
require 'bootstrap3_helper/railtie'

# This helper module includes UI helpers that will help generate
# common Bootstrap components.
#
module Bootstrap3Helper
  # Easily build a bootstrap accordion group component.
  #
  # @note All the element ids and data attributes needed to make the javascript
  #   function, are all synced up in the AccordionGroup and Accordion classes.
  #   You don't need to worry about them.
  #
  # @example Bootstrap Accordion Group Component:
  #   ```erb
  #   <%= accordion_group_helper do |group| %>
  #     <% group.accordion class: 'primary' do |accordion| %>
  #         <%= accordion.header { "accordion 1" } %>
  #         <%= accordion.body do %>
  #             <p>This is accordion 1</p>
  #         <% end %>
  #     <% end %>
  #     <% group.accordion class: 'info' do |accordion| %>
  #         <%= accordion.header { "accordion 2" } %>
  #         <%= accordion.body do %>
  #             <p>This is accordion 2</p>
  #         <% end %>
  #     <% end %>
  #     <% group.accordion class: 'danger' do |accordion| %>
  #         <%= accordion.header { "accordion 3" } %>
  #         <%= accordion.body do %>
  #             <p>This is accordion 3</p>
  #         <% end %>
  #     <% end %>
  #   <% end %>
  #   ```
  #
  # @param  [Hash] opts
  # @option opts [String] :id
  # @option opts [String] :class
  # @yieldparam [AccordionGroup] group
  # @return [String]
  #
  def accordion_group_helper(opts = {}, &block)
    AccordionGroup.new(self, opts, &block)
  end

  # Easily build a bootstrap accordion component
  #
  # @example Bootstrap Panel Component:
  #   ```erb
  #   <%= accordion_helper class: 'primary' do |accordion| %>
  #       <%= accordion.header do %>
  #           <span class="something">This is the heading....</span>
  #       <% end %>
  #       <%= accordion.body do %>
  #           <p>This is the body of the accordion....</p>
  #       <% end %>
  #   <% end %>
  #   ```
  #
  # @overload accordion_helper(context, opts)
  #   @param  [Symbol|String] context - :primary, :danger etc
  #   @param  [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #
  # @overload accordion_helper(opts)
  #   @param  [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #
  # @yieldparam [Accordion] accordion
  # @return [String]
  #
  def accordion_helper(*args, &block)
    Accordion.new(self, *args, &block)
  end

  # Creates an Alert component.
  #
  # @example Bootstrap Alert Component:
  #   ```erb
  #   <%= alert_helper :danger, dismissble: true do %>
  #     Something went wrong with your model data...
  #   <% end %>
  #   ```
  #
  # @overload alert_helper(context, opts)
  #   @param  [Symbol|String] context - :primary, :danger etc
  #   @param  [Hash] opts
  #   @option opts [String]  :id
  #   @option opts [String]  :class
  #   @option opts [Boolean] :dismissible
  #
  # @overload alert_helper(opts)
  #   @param  [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #
  # @return [String]
  #
  def alert_helper(*args, &block)
    Alert.new(self, *args, &block)
  end

  # Creates an Callout component.
  #
  # @example Bootstrap Callout Component:
  #   ```erb
  #   <%= callout_helper :danger %>
  #     Some information that needs your attention...
  #   <% end %>
  #   ```
  #
  # @overload callout_helper(context, opts)
  #   @param  [Symbol|String] context - :primary, :danger etc
  #   @param  [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #
  # @overload callout_helper(opts)
  #   @param  [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #
  # @return [String]
  #
  def callout_helper(*args, &block)
    Callout.new(self, *args, &block)
  end

  # Allows you to rapidly build bootstrap glyphs.
  #
  # @note Only supply the last part of the glyph makrup.
  #
  # @example Bootstrap Glyphicon Component:
  #   <%= icon_helper('pencil') %>
  #
  # @param [String|Symbol] name
  #
  def icon_helper(name)
    content_tag :span, '', class: "glyphicon glyphicon-#{name}"
  end

  # Allows you to rapidly build Panel components.
  #
  # @example Bootstrap Panel Component:
  #   ```erb
  #   <%= panel_helper :default do |p| %>
  #     <%= p.header do %>
  #       <%= p.title { 'Some random text here' } %>
  #     <% end %>
  #     <%= p.body do %>
  #       //HTML & Ruby
  #     <% end %>
  #   <% end %>
  #   ```
  #
  # @overload panel_helper(context, opts)
  #   @param  [String|Symbol] context - :primary, :danger etc
  #   @param  [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #   @option opts [Hash]   :data
  #   @option opts [Hash]   :aria
  #
  # @overload panel_helper(opts)
  #   @param  [Hash] opts
  #   @option opts [String] :id
  #   @option opts [String] :class
  #   @option opts [Hash]   :data
  #   @option opts [Hash]   :aria
  #
  # @yieldparam [Panel] panel
  # @return [String]
  #
  def panel_helper(*args, &block)
    Panel.new(self, *args, &block)
  end

  # Used to rapidly build Tabs.
  #
  # @note On menu items - you can pass in either symbol or string for the link. If
  #   you pass in a block, it will use the block for the title of the li.  If no
  #   block is present, then it will titleize the symbol or string.
  #   Tabs::Menu will respond to <code>item</code> and <code>dropdown</code>
  #   Each method will yield the corresponding component, either a Tabs::Menu
  #   or a Tabs::Dropdown.
  #
  # @example Bootstrap Tabs Component:
  #   <%= tabs_helper type: :pills do |tabs| %>
  #     <%= tabs.menu do |menu| %>
  #       <%= menu.item(:testing1, class: 'active') { ' Testing 1' } %>
  #       <%= menu.item :testing2 %>
  #       <%= menu.item(:testing3) { ' Testing 3' } %>
  #       <%= menu.dropdown 'Testing Dropdown' do |dropdown| %>
  #           <%= dropdown.item(:testing5 ) { 'Testing 5' } %>
  #           <%= dropdown.item(:testing6 ) { 'Testing 6' } %>
  #           <%= dropdown.item(:testing7 ) { 'Testing 7' } %>
  #       <% end %>
  #     <% end %>
  #
  #     <%= tabs.content do |content| %>
  #       <%= content.pane :testing1, class: 'active' do %>
  #           Testing 1 content
  #       <% end %>
  #       <%= content.pane :testing2 do %>
  #           Testing 2 content
  #       <% end %>
  #       <%= content.pane :testing3 do %>
  #           Testing 3 content
  #       <% end %>
  #       <%= content.pane :testing5 do %>
  #           Testing 5 content
  #       <% end %>
  #       <%= content.pane :testing6 do %>
  #           Testing 6 content
  #       <% end %>
  #       <%= content.pane :testing7 do %>
  #           Testing 7 content
  #       <% end %>
  #     <% end %>
  #   <% end %>
  #
  # @param  [Hash] opts
  # @option args [String|Symbol] :type
  # @option args [String]        :id
  # @option args [String]        :class
  # @yieldparam [Tabs] tabs
  # @return [String]
  #
  def tabs_helper(opts = {}, &block)
    Tabs.new(self, opts, &block)
  end
end
