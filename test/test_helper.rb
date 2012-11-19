require "bundler/setup"
require "haml"
require "minitest/autorun"
require "nokogiri"

MiniTest::Unit::TestCase.send :include, Module.new {
  def render(text, options = {}, &block)
    scope  = options.delete(:scope)  || Object.new
    locals = options.delete(:locals) || {}
    Haml::Engine.new(text, options).to_html(scope, locals, &block)
  end

  def assert_css(css, html, msg=nil)
    msg = message(msg) {"Expected #{mu_pp html} to match css selector #{mu_pp css}"}
    fragment = Nokogiri::HTML.fragment(html)
    assert fragment.at_css(css), msg
  end

  def refute_css(css, html, msg=nil)
    msg = message(msg) {"Expected #{mu_pp html} to not match css selector #{mu_pp css}"}
    fragment = Nokogiri::HTML.fragment(html)
    refute fragment.at_css(css), msg
  end
}
