# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :container do |f|
  f.after_create do |container|
    page = User.current.store.pages.homepage
    root_container = page.containers.roots.first
    parent_container = Container.create
    root_container.children << parent_container
    container.update_attributes :parent_id => parent_container.id
  end
end
