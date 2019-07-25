require 'test_helper'
require 'haml/filters/asciidoc'

class AsciiDocFilterTest < MiniTest::Unit::TestCase
  def test_should_render_asciidoc_content
    haml = ":asciidoc\n  *hello*\n"
    html = "<div class=\"paragraph\">\n<p><strong>hello</strong></p>\n</div>"
    assert_equal(html, render(haml).rstrip.gsub(/^ *(\n|(?=[^ ]))/, ''))
  end

  def test_should_render_h1_header
    haml = ":asciidoc\n  = Title\n\n  content"
    html = "<h1>Title</h1>"
    assert render(haml).start_with?(html)
  end

  def test_should_render_inline_asciidoc_content
    haml = ":asciidoc\n  :doctype: inline\n  *hello*\n"
    html = "<strong>hello</strong>"
    assert_equal(html, render(haml).rstrip)
  end
end
