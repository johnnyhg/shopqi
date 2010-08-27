// Container extension
Container = {
  add: function(parent_id, type){
    switch(type){
      case 'focuses':{
        $.post('/containers', { container: { parent_id: parent_id, type: type } }, null, 'script');
      }
    }
  };
};
