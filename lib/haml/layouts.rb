module Haml

  class Options
    @defaults[:layout_base_dir] = Dir.getwd
    attr_accessor :layout_base_dir

    @defaults[:layout] = 'layout.haml'
    attr_accessor :layout
  end

  class Engine

    def render_with_layout(scope = Object.new, locals = {}, &block)
      return render_without_layout(scope, locals, &block) unless options[:layout]

      regions = {}
      scope.instance_variable_set '@layout_regions', regions

      layout_file = File.expand_path(options.layout, options.layout_base_dir)
      options.layout = nil

      unnamed = render_without_layout(scope, locals)
      
      Haml::Engine.new(File.read(layout_file)).render_without_layout(scope, locals) do |region|
        region ? regions[region] : unnamed
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