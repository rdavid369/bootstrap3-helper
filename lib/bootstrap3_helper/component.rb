module Bootstrap3Helper # :nodoc
  # This super class is meant to contain commonly used methods that
  # all sub classes can leverage.
  #
  # @note Every component that inherits from this class, needs to call the parent
  #   initialization method! In order to properly render erb blocks within the
  #   proper context, we need the template. The only way to get this, is to pass
  #   in the template.
  #
  # @note The `context` mentioned above, refers to the context of `@template` and
  #   not to be confused with `@context` that can be found in the sub classes.
  #   `@context` refers to the Bootstrap class context of the component.
  #
  class Component
    # Used to ensure that the helpers always have the propert context for
    # rendering and bindings.
    #
    # @param [ActionView] template the context of the bindings
    #
    def initialize(template)
      @template = template
    end

    # Used to pass all context of content_tag to the template.  This ensures
    # proper template binding of variables and methods!
    #
    # @return [String]
    #
    def content_tag(
      name,
      content_or_options_with_block = nil,
      options = nil,
      escape = true,
      &block
    )
      @template.content_tag(
        name,
        content_or_options_with_block,
        options,
        escape,
        &block
      )
    end

    # Used to pass all concat references to the template.  This ensures proper
    # binding. Concat adds a String to the template Output buffer.  Useful when
    # trying to add a String with no block.
    #
    # @param [String] text
    #
    def concat(text)
      @template.concat(text)
    end

    # Used to parse method arguments.  If the first argument is
    # a Hash, then it is assumed that the user left off the bootstrap
    # contectual class.  So we will assign it to `default` and
    # return the Hash to be used as options.
    #
    # @param  [Hash|NilClass|String|Symbol] args
    # @return [Array]
    #
    def parse_context_or_options(*args)
      parse_arguments(*args, 'default')
    end

    # Used to parse method arguments.  If the first argument is
    # a Hash, then it is assumed that the user left off the tag
    # element.  So we will assign it to <tt>NilClass</tt> and
    # return the Hash to be used as options.
    #
    # @param  [Hash|NilClass|String|Symbol] args
    # @return [Array]
    #
    def parse_tag_or_options(*args)
      parse_arguments(*args, nil)
    end

    # Used to parse method arguments.  If the first argument is
    # a Hash, then it is assumed that the user left off the bootstrap
    # contectual class.  So we will assign it to `default` and
    # return the Hash to be used as options.
    #
    # @overload parse_arguments(param_or_options, options, default)
    #   @param [NilClass|Hash|Symbol|String] param_or_options
    #   @param [Hash] options
    #   @param [NilClass|String|Symbol] default
    #
    # @overload parse_arguments(options, default)
    #   @param [Hash] options
    #   @param [NilClass|String|Symbol] default
    #
    # @return [Array]
    #
    def parse_arguments(*args, default)
      first, second = *args
      case first
      when Hash, NilClass
        [default, first || second]
      when Symbol, String
        [first, second]
      end
    end

    # Used to generate a (hopefully) unique ID for DOM elements.  Used as a
    # fallback if the user doesn't specify one.
    #
    # @return [String]
    #
    def uuid
      (0...10).map { rand(65..90).chr }.join
    end

    # Used to get config settings inside of components quicker.
    #
    # @param  [Symbol|String|Hash] setting
    # @return [Mixed]
    #
    def config(setting, fallback)
      object = Bootstrap3Helper.config

      value  = (
        case setting
        when Hash
          object.send(setting.keys[0])[setting.values[0]] if object.send(setting.keys[0])
        when Symbol, String
          object.send(setting) if object.respond_to?(setting)
        end
      )

      value || fallback
    end
  end
end
