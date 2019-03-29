require 'dnr_bootstrap_helper/version'

# Implementation files
require 'dnr_bootstrap_helper/component'
require 'dnr_bootstrap_helper/accordion'
require 'dnr_bootstrap_helper/accordion_group'
require 'dnr_bootstrap_helper/alert'
require 'dnr_bootstrap_helper/callout'
require 'dnr_bootstrap_helper/panel'
require 'dnr_bootstrap_helper/tabs'
require 'dnr_bootstrap_helper/tabs/content'
require 'dnr_bootstrap_helper/tabs/dropdown'
require 'dnr_bootstrap_helper/tabs/menu'
require 'dnr_bootstrap_helper/railtie'

# @description
# - This helper module includes UI helpers that will help generate
# common Bootstrap components.
#
module Bootstrap3Helper
  # @description
  # - Allows you to rapidly build Panel components.
  #
  # <code>
  #   <%= panel_helper :primary do |p| %>
  #     <%= p.header { "Some Title" }
  #     <%= p.body class: 'custom-class', id: 'custom-id' do %>
  #       //HTML or Ruby code here...
  #     <% end %>
  #     <%= p.footer do %>
  #       //HTML or Ruby
  #     <% end %>
  #   <% end %>
  # </code>
  #
  # @params [Symbol|String|Hash|NilClass] *args
  # @return [String]
  #
  def panel_helper(*args)
    panel = Panel.new(self, *args)
    capture { yield(panel) if block_given? }
    panel
  end

  # @description
  # - Creates an Alert component.
  #
  # <code>
  #   <%= alert_helper :danger, dismissble: true do %>
  #     Something went wrong with your model data...
  #   <% end %>
  # </code>
  #
  # @params [Symbol|String|Hash|NilClass] *args
  # @return [String]
  #
  def alert_helper(*args, &block)
    alert = Alert.new(self, *args, &block)
    alert
  end

  # @description
  # - Creates an Callout component.
  #
  # <code>
  #   <%= callout_helper :danger %>
  #     Some information that needs your attention...
  #   <% end %>
  # </code>
  #
  # @params [Symbol|String|Hash|NilClass] *args
  # @return [String]
  #
  def callout_helper(*args, &block)
    callout = Callout.new(self, *args, &block)
    callout
  end

  # @description
  # - Allows you to set a breadcrumbs class variable.  It will use that variable
  # to render out the contents of your breadcrumbs.
  #
  # <code>
  #   @breadcrumbs = [
  #     {
  #       name: 'Home',
  #       href: root_path
  #     },
  #     {
  #       name: 'Category',
  #       href: category_path
  #     },
  #     {
  #       name: 'Sub Category',
  #       href: sub_category_path
  #     },
  #   ]
  # </code>
  #
  # @return [String]
  #
  def breadcrumbs
    content_tag :ul, class: 'breadcrumbs' do
      if @breadcrumbs.nil?
        link_to 'Home', defined?(root_path) ? root_path : '/'
      else
        @breadcrumbs.collect do |item|
          content_tag(:li) { item[:href].nil? ? item[:name] : link_to(item[:name], item[:href]) }
        end.join.html_safe
      end
    end
  end

  # @description
  # - Just a easy way of checking if the environment is a devbox
  # or a server.
  #
  # @return [Boolean]
  #
  def host_is_dev_pc?
    Rails.root.to_s.include?('home')
  end

  # @description
  # - Easily build a bootstrap accordion group component.
  #
  # @note
  # - All the element ids and data attributes needed to make the javascript
  # function, are all synced up in the AccordionGroup and Accordion classes.
  # You don't need to worry about them :)
  #
  # <code>
  #   <%= accordion_group_helper do |group| %>
  #     <% group.accordion class: 'primary' do |accordion| %>
  #         <%= accordion.header { "accordion 1" } %>
  #         <%= accordion.body do %>
  #             <p>This is accordion 1</p>
  #         <% end %>
  #     <%end %>
  #     <% group.accordion class: 'info' do |accordion| %>
  #         <%= accordion.header { "accordion 2" } %>
  #         <%= accordion.body do %>
  #             <p>This is accordion 2</p>
  #         <% end %>
  #     <%end %>
  #     <% group.accordion class: 'danger' do |accordion| %>
  #         <%= accordion.header { "accordion 3" } %>
  #         <%= accordion.body do %>
  #             <p>This is accordion 3</p>
  #         <% end %>
  #     <%end %>
  #   <% end %>
  # </code>
  #
  # @yields [AccordionGroup] group
  # @return [String]
  #
  def accordion_group_helper(*args)
    group = AccordionGroup.new(self, *args)
    capture { yield group if block_given? }
    group
  end

  # @description
  # - Easily build a bootstrap accordion component
  #
  #   <code>
  #     <%= accordion_helper class: 'primary' do |accordion| %>
  #         <%= accordion.header do %>
  #             <span class="something">This is the heading....</span>
  #         <% end %>
  #         <%= accordion.body do %>
  #             <p>This is the body of the accordion....</p>
  #         <% end %>
  #     <% end %>
  #   </code>
  #
  # @params [Symbol|String|Hash|NilClass] *args
  # @return [String]
  #
  def accordion_helper(*args)
    accordion = Accordion.new(self, *args)
    capture { yield accordion if block_given? }
    accordion
  end

  # @description
  # - Allows you to rapidly build bootstrap glyphs.
  #
  # @note
  # - Only supply the last part of the glyph makrup.
  #
  # <code>
  #   <span class"glyphicon glyphicon-pencil"></span>
  #   <%= icon_helper('pencil') %>
  # </code>
  #
  # @param [String|Symbol] name
  #
  def icon_helper(name = '')
    content_tag :span, '', class: 'glyphicon glyphicon-' + name.to_s
  end

  # @description
  # - Used to rapidly build Tabs.
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
  #
  def tabs_helper(args = {})
    tabs = Tabs.new(self, args)
    capture { yield(tabs.menu, tabs.content) if block_given? }
    tabs
  end
end
