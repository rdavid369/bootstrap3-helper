# @root
#
#
module Bootstrap3Helper
  # @description
  # - This class is used to general groups of accordions.
  #
  # <code>
  #   <%= accordion_group_helper do |group| %>
  #     <%= group.accordion :primary do |accordion| %>
  #         <%= accordion.header { "accordion 1" } %>
  #         <%= accordion.body do %>
  #             <p>This is accordion 1</p>
  #         <% end %>
  #     <% end %>
  #     <%= group.accordion :info do |accordion| %>
  #         <%= accordion.header { "accordion 2" } %>
  #         <%= accordion.body do %>
  #             <p>This is accordion 2</p>
  #         <% end %>
  #     <% end %>
  #     <%= group.accordion :danger do |accordion| %>
  #         <%= accordion.header { "accordion 3" } %>
  #         <%= accordion.body do %>
  #             <p>This is accordion 3</p>
  #         <% end %>
  #     <% end %>
  #   <% end %>
  # </code>
  #
  class AccordionGroup < Component
    # @description
    # - Used to initialize the main object.  This objects sole purpose is to
    # generate a wrapper element with a distinct id and pass that id down to
    # all the child elements.
    #
    def initialize(template, opts = {})
      super(template)
      @accordions = []
      @id = opts.fetch(:id, uuid)
      @class = opts.fetch(:class, '')
    end

    # @description
    # - This method is the main method for generating individual accordions.
    # This is where you would pass in the html attributes.
    #
    # @param [NilClass|String|Symbol|Hash] - Bootstrap class context, or options hash.
    # @param [Hash] opts
    # <code>
    #    args = {
    #      id:      [String]
    #      class:   [String]
    #    }
    # </code>
    #
    # @yields [Accordion] accordion
    # @return [nilClass]
    #
    def accordion(context_or_options = nil, opts = {})
      if context_or_options.is_a?(Hash)
        context_or_options[:parent_id] = @id
      else
        opts[:parent_id] = @id
      end

      accordion = Accordion.new(@template, context_or_options, opts)
      yield accordion if block_given?

      @accordions.push(accordion)
    end

    # @description
    # - The to string method here is what is responsible for rendering out the
    # entire accordion.  As long as the main method is rendered out in the helper,
    # you will get all the contents.
    #
    # @return [String]
    #
    def to_s
      content = content_tag :div, id: @id, class: "panel-group #{@class}" do
        @accordions.map(&:to_s).join.html_safe
      end

      content
    end
  end
end
