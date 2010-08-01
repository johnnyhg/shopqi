# Switch the javascript_include_tag :defaults to use jQuery instead of
# the default prototype helpers.
# Credits: http://github.com/lleger/Rails-3-jQuery/

if ActionView::Helpers::AssetTagHelper.respond_to? :reset_javascript_include_default # rails3 beta
  if ActionView::Helpers::AssetTagHelper.const_defined?(:JAVASCRIPT_DEFAULT_SOURCES)
          ActionView::Helpers::AssetTagHelper.send(:remove_const, "JAVASCRIPT_DEFAULT_SOURCES")
  end
  ActionView::Helpers::AssetTagHelper::JAVASCRIPT_DEFAULT_SOURCES = ['jquery', 'rails']
  ActionView::Helpers::AssetTagHelper.reset_javascript_include_default
else #rails3 rc
  ActionView::Helpers::AssetTagHelper.register_javascript_expansion :defaults => ['jquery', 'rails']
end
