require "test_helper"
require "haml/layouts"
Haml::Options.defaults[:layout] = nil # turn off layouts so they don't affect other tests
require "haml/partials"

class LayoutsPartialsTest < Minitest::Unit::TestCase

  def render(file, options = {})
    base_dir = File.expand_path('../layouts_and_partials', __FILE__)
    super File.read(File.expand_path(file, base_dir)), options.merge(:layout_base_dir => base_dir, :partial_base_dir => base_dir)
  end

  def test_basic_partial_and_layout
    html = render('basic_layout_with_partial_content.haml', :layout => 'basic_layout_with_partial_layout.haml')

    assert_css '.layout > .content > .partial', html
    refute_css '.layout > .content > .layout > .partial', html  # partial should not have the layout
  end

  def test_layout_can_have_partial
    html = render('layout_has_partial_content.haml', :layout => 'layout_has_partial_layout.haml')

    assert_css '.layout_partial_container > .partial', html
    assert_css '.layout > .content', html
  end

end