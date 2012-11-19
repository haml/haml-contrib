require 'haml'
require 'haml/options_ext'

module Haml

  # @private
  class Options

    @defaults[:partial_base_dir] = Dir.getwd
    @buffer_option_keys << :partial_base_dir
    attr_accessor :partial_base_dir

  end

  module Helpers

    # A simple implementation of partials.
    #
    # Renders the named Haml file and returns the generated HTML.
    #
    # The directory to search for partials in can be set with the
    # +:partial_base_dir+ option, which defaults to the current working directory.
    #
    # If the named file is not found, the suffixes +.haml+ and +.html.haml+ are
    # added and looked for, and then the same names but with the prefix +_+. The
    # first file found will be used.
    #
    # +self+ is used as the context, so instance variables can be used in the
    # partial and will have the same value as the parent template.
    #
    # This method makes no effort to cache the generated Ruby code, it simply
    # uses +Haml::Engine.new().render+ each time. This implementation is intended
    # for static site generators or one off document generation, and not as a
    # base for a web framework.
    #
    # @param partial [#to_s] the filename of the partial to render
    # @param locals [Hash] a hash of local variables to use in the partial
    # @return [String] the HTML generated from the partial
    # @raise [StandardError] if the partial file cannot be found

    def render(partial, locals = {})
      Haml::Engine.new(File.read(find_file_for_partial(partial)), @_original_options.to_hash).render(self, locals)
    end
    
    private
    def find_file_for_partial(file)
      ['', '_'].each do |prefix|
        ['', '.haml', '.html.haml'].each do |suffix|
          candidate = File.expand_path "#{prefix}#{file}#{suffix}", haml_buffer.options[:partial_base_dir]
          return candidate if File.exist? candidate
        end
      end

      raise "Partial #{file} not found"
    end

  end

end