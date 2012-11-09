require "rubygems"
require "bundler/setup"
require "haml"
require "minitest/autorun"

MiniTest::Unit::TestCase.send :include, Module.new {
  def render(text, options = {}, &block)
    scope  = options.delete(:scope)  || Object.new
    locals = options.delete(:locals) || {}
    Haml::Engine.new(text, options).to_html(scope, locals, &block)
  end
}