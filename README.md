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

## Usage

`Panel Helper`

```erb
<%= panel_helper :primary do |p| %>
  <%= p.header id: 'optional-id', class: 'any-optional-extra-classes' do %>
    Some Header for your panel
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

---

`Alert Helper`

```erb
<%= alert_helper :success { 'Some success message' } %>

<!-- or -->

<%= alert_helper :danger, dismissable: true do %>
    HTML and/or Ruby
<% end %>
```

---

`Accordion Helper`

```erb
<%= accordion_helper :primary, { class: 'optional-class', id: 'optional_id', collapse_id: 'optional_collapse_id', expanded: true } do |accordion| %>
    <%= accordion.header do %>
        <span class="something">This is the heading....</span>
    <% end %>
    <%= accordion.body do %>
        <p>This is the body of the accordion....</p>
    <% end %>
<% end %>
```

**Note:** the accordion helper handles all the attributes and data attributes needed to sync up the javascript in order to give the component its functionality. You just worry about about the class or state of the component. The helper does the rest. But if you do want to control the collapse ID and syncing, `collapse_id` is the attribute you are looking for.

---

`AccordionGroup Helper`

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

**Note:** the accordion_group helper handles all the attributes and data attributes needed to sync up the javascript in order to give the component its functionality. You just worry about about the class or state of the individual accordions. The helper does the rest.

---

`Tab Helper`

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
