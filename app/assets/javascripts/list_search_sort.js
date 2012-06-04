$(document).ready(function() {
  $('.search input[type="submit"]').addClass('invisible');
  $('.search').live('submit', function (){
    $.get($(this).attr('action'), $(this).serialize(), null, "script");
    return false;
  });
  $('.search input[type="text"]').keyup(function (){
    $(this).parent().submit();
    return false;
  });
  $('.search input[type="radio"]').change(function (){
    $(this).parent().submit();
    return false;
  });
  $('.search input[type="checkbox"]').change(function (){
    $(this).parent().submit();
    return false;
  });
  $('.search select').live('change', function(event) {
    $(this).parent().submit();
    return false;
  });
  $('.sort th a').live("click", function() {
    $.get(this.href, null, null, 'script');
    return false;
  });
});