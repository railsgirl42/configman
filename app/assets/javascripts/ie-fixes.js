$('form').live('ajax:aborted:required', function(event, elements){
  elements.each(function(){
    $(this).addClass('blank-required');
  });
});