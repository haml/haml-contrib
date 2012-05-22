# A PHP Filter for Haml. This simple wraps code inside <?php ?> tags. While this
# may seem like a strange idea, some people use Haml to generate mostly static
# HTML documents that then include small amounts of PHP.
#
# This filter also serves as an example of how to implement a simple filter for
# Haml.
module Haml
  module Filters
    module PHP
      include Base

      def render(text)
        "<?php\n  %s\n?>" % text.rstrip.gsub("\n", "\n  ")
      end

    end
  end
end