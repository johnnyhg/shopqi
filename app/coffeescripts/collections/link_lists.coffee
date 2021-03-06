App.Collections.LinkLists = Backbone.Collection.extend
  model: LinkList
  url: '/admin/link_lists'

  initialize: ->
    _.bindAll this, 'addOne'
    this.bind 'add', this.addOne

  addOne: (model, collection) ->
    model.with_links()
    #新增成功!
    msg '\u65B0\u589E\u6210\u529F\u0021'
    $('#add-menu').hide()
    $('#link_list_title').val ''
    new App.Views.LinkList.Show model: model
    Backbone.history.saveLocation "link_lists/#{model.id}"
