require "test_helper"
require "haml/partials"

class PartialsTest < Minitest::Unit::TestCase

  def render(file, options = {})
    super File.read(File.expand_path(file, 'test/partials')), options.merge(:partial_base_dir => 'test/partials')
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

end