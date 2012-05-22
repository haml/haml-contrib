require "test_helper"
require "haml/filters/php"

class PHPFilterTest < Minitest::Unit::TestCase
  def test_should_render
    haml = ":php\n  foo\n  bar"
    html = "<?php\n  foo\n  bar\n?>\n"
    assert_equal html, render(haml)
  end

  def test_should_interpolate
    scope = Object.new.instance_eval {foo = "bar"; binding}
    haml = ":php\n  \#{foo}"
    html = "<?php\n  bar\n?>\n"
    assert_equal html, render(haml, :scope => scope)
  end
end