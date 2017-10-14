module ActionView
  module Helpers
    def stylesheet_link_tag(name, _options = {})
      %(<link href="/assets/#{name}.css" media="all" rel="stylesheet" />)
    end

    def javascript_include_tag(name, _options = {})
      %(<script src="/assets/#{name}.js"></script>)
    end

    def csrf_meta_tags
      # Not implemented
    end

    def h(text)
      ERB::Util.h text
    end

    def link_to(title, url)
      %(<a href="#{url}">#{h title}</a>)
    end
  end
end
