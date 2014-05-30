module Styled::GuidesHelper
  def source(path)
    content_tag :pre, class: "styled-source prettyprint linenums" do
      escape_once render(path)
    end
  end
end
