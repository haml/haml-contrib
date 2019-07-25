require "test_helper"
require "haml/partials"

class PartialsTest < Minitest::Unit::TestCase

  def render(file, options = {})
    base_dir = File.expand_path('../partials', __FILE__)
    super File.read(File.expand_path(file, base_dir)), options.merge(:partial_base_dir => base_dir)
  end

  def test_basic_partial
    assert_equal "<p></p>\n", render('basic.haml')
  end

  def test_locals
    assert_equal "42\n", render('locals.haml')
  end

  def test_instance_vars
    assert_equal "42\n", render('instance_vars.haml')
  end

  def test_options
    html = render('options.haml', :attr_wrapper => '"', :remove_whitespace => true)

    assert_match /"foo"/, html # :attr_wrapper is in options_for_buffer
    assert_match />Text</, html # :remove_whitespace isn't in options_for_buffer
  end
end
