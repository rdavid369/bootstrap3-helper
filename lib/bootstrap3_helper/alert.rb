module Bootstrap3Helper # :nodoc:
  # The Alert helper is meant to help you rapidly build Bootstrap Alert
  # components quickly and easily. The dissmiss button is optional.
  #
  # @example Rendering a Bootstrap Alert Component in a view:
  #   <code>
  #     <%= alert_helper :warning, dismissable: true do %>
  #       <% if @model.errors.present? %>
  #         <p>Some kind of error</p>
  #       <% end %>
  #     <% end %>
  #
  #     <%= alert_helper(:success, dismissible: true) { "Successful save"}
  #   </code>
  #
  class Alert < Component
    # Used to generate Bootstrap alert components quickly.
    #
    # @param  [Class] template Template in which your are binding too.
    # @param  [NilClass|String|Symbol|Hash] Bootstrap class context, or options hash.
    # @param  [Hash]  opts
    # @option opts [String]  :id    The ID of the element
    # @option opts [String]  :class Custom class for the component.
    # @return [Alert]
    #
    def initialize(template, context_or_options = nil, opts = {}, &block)
      super(template)
      @context, args = parse_arguments(context_or_options, opts)

      @id          = args.fetch(:id, nil)
      @class       = args.fetch(:class, '')
      @dismissible = args.fetch(:dismissible, false)
      @content     = block || proc { '' }
    end

    # The dissmiss button, if the element has one.
    #
    # @return [String]
    #
    def close_button
      content_tag(:button, class: 'close', data: { dismiss: 'alert' }, aria: { label: 'Close' }) do
        content_tag(:span, aria: { hidden: true }) { '&times;'.html_safe }
      end
    end

    # Used to render out the Alert component.
    #
    # @note Concat needs to be used to add the content of the button to the output
    #   buffer.  For some reason, if though the block returns a String, trying to
    #   add that string to the dismiss button string, returns with the dismiss
    #   button missing.  Was forced to caoncat the button to the current output
    #   buffer in order to get it to persist after the block call.
    #
    # @return [String]
    #
    def to_s
      content_tag :div, id: @id, class: container_class do
        concat(@dismissible ? close_button : '')
        @content.call(self)
      end
    end

    private

    # Used to get the container classes.
    #
    # @return [String]
    #
    def container_class
      string = 'alert '
      string += @context == 'default' ? 'alert-info' : "alert-#{@context}"
      string += " #{@class}"
      string
    end
  end
end
