$(document).on('turbolinks:load', function() {
  $('#switch-to-adverts-button, #switch-to-users-button').click(function() {
    $(this).addClass('button-active').siblings().removeClass('button-active');
    if($(this).attr('id') == 'switch-to-adverts-button') {
      $('#admin-adverts-list').show();
      $('#admin-users-list').hide();
    } else if($(this).attr('id') == 'switch-to-users-button') {
      $('#admin-adverts-list').hide();
      $('#admin-users-list').show();
    }
  })
})

