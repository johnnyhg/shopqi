# Switch the javascript_include_tag :defaults to use jQuery instead of
# the default prototype helpers.
# Credits: http://github.com/lleger/Rails-3-jQuery/

ActionView::Helpers::AssetTagHelper.register_javascript_expansion :defaults => ['jquery', 'rails']
