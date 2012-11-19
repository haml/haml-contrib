require 'haml/options'

module Haml

  # @private
  class Options

    def to_hash
      self.class.defaults.keys.inject({}) do |hash, key|
        hash[key] = send(key)
        hash
      end
    end

    def self.add_option(name, default, for_buffer=false)
      @defaults[name] = default
      attr_accessor name
      @buffer_option_keys << name if for_buffer
    end

  end

  class Engine

    def render_with_options(scope = Object.new, locals = {}, &block)
      # We sometimes need to be able to get the original options when making later
      # calls to render (e.g. when rendering partials) so we "hide" them in the scope
      # object. (We can't just use the buffer options as we may need _all_ the options.)
      scope.instance_variable_set '@_original_options', options unless scope.instance_variable_get '@_original_options'
      render_without_options(scope, locals, &block)
    end
    alias :render_without_options :render
    alias :render :render_with_options
    alias :to_html :render_with_options
  end

end