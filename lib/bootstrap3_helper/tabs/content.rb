module Bootstrap3Helper # :nodoc:
  class Tabs
    # Used to rapidly generated Bootstrap Tabs Content Components.
    #
    #
    class Content < Component
      # Creates a new Tabs::Menu object.
      #
      # @param [ActionView] template Template in which your are binding too.
      # @param [Hash]  args
      # @option args [String] :id The ID, if you want one, for the parent container.
      # @option args [String] :class Custom class for the parent container.
      # @option args [Hash]   :data Any data attributes you want on the parent element.
      #
      def initialize(template, args = {}, &block)
        super(template)

        @id      = args.fetch(:id,    nil)
        @class   = args.fetch(:class, '')
        @data    = args.fetch(:data,  {})
        @content = block || proc { '' }
      end

      # Adds a new tabe pane item to the object.
      #
      # @param [String|Symbol] name - Used to link to  the nav menu item.
      # @param [Hash]  args
      # @option args [String] :class Custom class for the pane.
      # @option args [Hash]   :data Any data attributes you want on the pane element.
      # @yieldreturn [String]
      #
      def pane(name, args = {})
        data   = args.fetch(:data, nil)
        klass  = args.fetch(:class, '')
        active = klass.include? 'active'

        content = content_tag(
          :div,
          id:       name,
          class:    "tab-pane fade #{active ? 'in' : ''} #{klass}",
          aria:     { hidden: active },
          data:     data,
          role:     'tabpanel',
          tabindex: -1
        ) do
          yield if block_given?
        end
      end

      # Used to render out the object as HTML
      #
      # @return [String]
      #
      def to_s
        content_tag :div, id: @id, class: 'tab-content' + @class do
          @content.call(self)
        end
      end
    end
  end
end
