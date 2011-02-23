module StoreInit
  @queue = "store_init"
  
  def self.perform(id)
    Store.find(id).init
  end
end
