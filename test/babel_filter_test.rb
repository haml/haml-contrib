require "test_helper"
require "haml/filters/babel"

class BabelFilterTest < Minitest::Unit::TestCase
  def test_should_compile_babel_filter
    html = %Q[<script>\n  "use strict";\n  \n  var foo = 1;\n</script>\n]
    haml = ":babel\n  const foo = 1;"
    assert_equal(html, render(haml, format: :html5))
  end

  def test_should_compile_es6_filter
    html = %Q[<script>\n  "use strict";\n  \n  var foo = 1;\n</script>\n]
    haml = ":es6\n  const foo = 1;"
    assert_equal(html, render(haml, format: :html5))
  end
end
