module Bootstrap3Helper # :nodoc:
  # This class is used to general groups of accordions.
  #
  # @example Rendering out an Accordion Group in template:
  #   <code>
  #     <%= accordion_group_helper do |group| %>
  #       <%= group.accordion :primary do |accordion| %>
  #           <%= accordion.header { "accordion 1" } %>
  #           <%= accordion.body do %>
  #               <p>This is accordion 1</p>
  #           <% end %>
  #       <% end %>
  #       <%= group.accordion :info do |accordion| %>
  #           <%= accordion.header { "accordion 2" } %>
  #           <%= accordion.body do %>
  #               <p>This is accordion 2</p>
  #           <% end %>
  #       <% end %>
  #       <%= group.accordion :danger do |accordion| %>
  #           <%= accordion.header { "accordion 3" } %>
  #           <%= accordion.body do %>
  #               <p>This is accordion 3</p>
  #           <% end %>
  #       <% end %>
  #     <% end %>
  #   </code>
  #
  class AccordionGroup < Component
    # Used to initialize the main object.  This objects sole purpose is to
    # generate a wrapper element with a distinct id and pass that id down to
    # all the child elements.
    #
    # @param [ActionView] template
    # @param [Hash]       opts
    # @option opts [String] :id
    # @option opts [String] :class
    # @option opts [Hash]   :data
    #
    def initialize(template, opts = {}, &block)
      super(template)

      @id      = opts.fetch(:id,    uuid)
      @class   = opts.fetch(:class, '')
      @data    = opts.fetch(:data,  {})
      @content = block || proc { '' }
    end

    # This method is the main method for generating individual accordions.
    # This is where you would pass in the html attributes.
    #
    # @param [NilClass|String|Symbol|Hash] context_or_options Bootstrap class context, or options hash.
    # @param [Hash] opts
    # @option opts [String] id    The ID, if you want one, for the parent container
    # @option opts [String] class Custom class for the parent container
    # @yieldparam accordion [Accordion]
    #
    def accordion(context_or_options = nil, opts = {}, &block)
      if context_or_options.is_a?(Hash)
        context_or_options[:parent_id] = @id
      else
        opts[:parent_id] = @id
      end

      Accordion.new(@template, context_or_options, opts, &block)
    end

    # The to string method here is what is responsible for rendering out the
    # entire accordion.  As long as the main method is rendered out in the helper,
    # you will get all the contents.
    #
    # @return [String]
    #
    def to_s
      content = content_tag :div, id: @id, class: "panel-group #{@class}" do
        @content.call(self)
      end
    end
  end
end
