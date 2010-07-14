# encoding:utf-8
class ApplicationController < ActionController::Base
  include InheritedResources::DSL

  protect_from_forgery
  layout 'application'
end
