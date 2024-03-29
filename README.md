# Bootstrap 3 Helper

This gem was designed to help you rapidly build common Bootstrap 3 Components. They where designed to very flexible and reduce a lot of boiler plate HTML.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bootstrap3_helper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bootstrap3_helper

## Panel Helper

Panels supper the following methods:

- body
- heaader
- footer
- title

```ruby
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
```

#### Example

```erb
<%= panel_helper :primary do |p| %>
  <%= p.header id: 'optional-id', class: 'any-optional-extra-classes' do %>
    <%= p.header { 'Optional header title' }  %>
    <p>Non styled content for header...</p>
  <% end %>
  <%= p.body id: 'optional-id', class: 'any-optional-extra-classes' do %>
     All your custom HTML or Ruby.  You can render blocks here, whatever
  <% end%>
  <% p.footer id: 'optional-id', class: 'any-optional-extra-classes' do %>
    You don't need to have a footer but if you do, you can put your
    HTML and Ruby in here as well.
  <% end %>
end
```

## Alert Helper

```ruby
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
```

### Example

```erb
<%= alert_helper :success { 'Some success message' } %>

<!-- or -->

<%= alert_helper :danger, dismissable: true do %>
    HTML and/or Ruby
<% end %>
```

## Acordion Helper

```ruby
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
```

### Example

```erb
<%= accordion_helper :primary, id: 'optional_id', expanded: true do |accordion| %>
    <%= accordion.header do %>
        <span class="something">This is the heading....</span>
    <% end %>
    <%= accordion.body do %>
        <p>This is the body of the accordion....</p>
    <% end %>
<% end %>
```

**Note:** the accordion helper handles all the attributes and data attributes needed to sync up the javascript in order to give the component its functionality. You just worry about about the class or state of the component. The helper does the rest. But if you do want to control the collapse ID and syncing, `collapse_id` is the parameter you are looking for.

## Accordion Group

```ruby
# @param  [Hash] opts
# @option opts [String] :id
# @option opts [String] :class
# @yieldparam [AccordionGroup] group
# @return [String]
```

### Example

```erb
<%= accordion_group_helper do |g| %>
    <% g.accordion :primary do |accordion| %>
        <%= accordion.header { "Accordion 1" } %>
        <%= accordion.body do %>
            <p>This is accordion 1</p>
        <% end %>
    <% end %>
    <% g.accordion :info do |accordion| %>
        <%= accordion.header { "Accordion 2" } %>
        <%= accordion.body do %>
            <p>This is accordion 2</p>
        <% end %>
    <% end %>
    <% g.accordion :danger do |accordion| %>
        <%= accordion.header { "Accordion 3" } %>
        <%= accordion.body do %>
            <p>This is accordion 3</p>
        <% end %>
    <% end %>
<% end %>
```

## Tab Helper

Tabs respond to the following methods:

- menu
  - item (Used for linking to tab content)
  - dropdown (Used for making dropdown menus)
- content

```ruby
# @param  [Hash] opts
# @option args [String|Symbol] :type - :tabs, :pills
# @option args [String]        :id
# @option args [String]        :class
# @yieldparam [Tabs] tabs
# @return [String]
```

### Example

```erb
<%= tabs_helper type: :pills do |tabs| %>
    <%= tabs.menu do |menu| %>
        <%= menu.item(:testing1, class: 'active') { ' Testing 1' } %>
        <%= menu.item :testing2 %>
        <%= menu.item(:testing3) { ' Testing 3' } %>
        <%= menu.dropdown 'Testing Dropdown' do |dropdown| %>
            <%= dropdown.item(:testing5 ) { 'Testing 5' } %>
            <%= dropdown.item(:testing6 ) { 'Testing 6' } %>
            <%= dropdown.item(:testing7 ) { 'Testing 7' } %>
        <% end %>
    <% end %>

    <%= tabs.content do |content| %>
        <% content.pane :testing1, class: 'active' do %>
            Testing 1 content
        <% end %>
        <% content.pane :testing2 do %>
            Testing 2 content
        <% end %>
        <% content.pane :testing3 do %>
            Testing 3 content
        <% end %>
        <% content.pane :testing5 do %>
            Testing 5 content
        <% end %>
        <% content.pane :testing6 do %>
            Testing 6 content
        <% end %>
        <% content.pane :testing7 do %>
            Testing 7 content
        <% end %>
    <% end %>
<% end %>
```

---

## Development

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rdavid369/bootstrap3-helper.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
