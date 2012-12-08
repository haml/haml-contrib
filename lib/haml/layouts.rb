require 'haml'
require 'haml/options_ext'

module Haml

  Options.add_option :layout_base_dir, Dir.getwd
  Options.add_option :layout, 'layout.haml'

  class Engine

    # TODO: work out the best place to put this documentation.

    # A simple layouts implementation.
    #
    # Renders the Haml template as normal, then renders the file specified
    # by +options.layout+ (defaults to +layout.haml+) and inserts the original
    # rendered file where +yield+ is called in the layout.
    #
    # Can also handle +content_for :sym+ blocks which will be inserted in the
    # layout when +yield :sym+ is called, similar to Rails.
    #
    # To specify a different directory to look for layout files use the
    # +layout_base_dir+ option, the default is the current working directory.
    def render_with_layout(scope = Object.new, locals = {}, &block)
      return render_without_layout(scope, locals, &block) unless options[:layout]

      regions = {}
      scope.instance_variable_set '@layout_regions', regions

      layout_file = File.expand_path(options.layout, options.layout_base_dir)
      options.layout = nil

      unnamed = render_without_layout(scope, locals)
      
      Haml::Engine.new(File.read(layout_file), options.to_hash).render_without_layout(scope, locals) do |*region|
        region[0] ? regions[region[0]] : unnamed
      end
    end
    alias :render_without_layout :render
    alias :render :render_with_layout
    alias :to_html :render_with_layout

  end

  module Helpers

    def content_for(region, &blk)
      @layout_regions[region] = capture_haml(&blk)
    end

  end

end