require "test_helper"
require "haml/layouts"
Haml::Options.defaults[:layout] = nil # turn off layouts so they don't affect other tests

class LayoutTest < Minitest::Unit::TestCase

  def render(file, options = {})
    base_dir = File.expand_path('../layouts', __FILE__)
    super File.read(File.expand_path(file, base_dir)), options.merge(:layout_base_dir => base_dir)
  end

  def test_basic_layout
    html = render('basic_content.haml', :layout => 'basic_layout.haml')
    
    assert_match /class='content'/, html  # content is rendered
    assert_match /class='layout'/, html   # layout is rendered
  end

  def test_content_for
    html = render('content_for_content.haml', :layout => 'content_for_layout.haml')

    assert_css('div.content_for > span.region', html)
    assert_css('p.content', html)
  end

end
