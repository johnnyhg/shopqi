# encoding: utf-8
#http://www.engineyard.com/blog/2010/the-lowdown-on-routes-in-rails-3/
Shopqi::Application.routes.draw do |map|
  #首页热门分类
  resources :hots do
    collection do
      post :sort
    end
  end

  resources :categories

  #图片合成
  resources :images do
    collection do
      post :upload
    end
  end

  #菜单
  resources :menus do
    collection do
      post :sort
    end
  end

  #导航
  resources :navs do
    collection do
      post :sort
    end
  end

  resources :focuses do
    collection do
      post :sort
    end
  end

  #主页面
  resources :pages do
    collection do
      post :logo
    end
  end
  match 'page' => 'pages#show'

  resources :products

  ##### 官网 #####
  root :to => "home#index"
  match "why" => "home#why"
  match "features" => "home#features"
  match "questions" => "home#questions"
  match "contact" => "home#contact"

  devise_for :users
  #用户登录后的跳转页面(符合devise命名规范)
  match "user_root" => "home#show"
end
