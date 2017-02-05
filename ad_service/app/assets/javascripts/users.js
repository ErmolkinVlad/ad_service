$(document).on('turbolinks:load', function() {
  $('#accept-button, #reject-button').click(function(e) {
    var controller = $('#control-hidden-status').attr('data-controller')
    var data = {
      advert: {
        status: ''
      }
    }
    if($(e.target).attr('data-text') == 'accept') {
      data.advert.status = 'published'
      throughAjax(data, controller, 'PUT')
    } else if($(e.target).attr('data-text') == 'reject') {
      data.advert.status = 'canceled'
      throughAjax(data, controller, 'PUT')
    }
  })
  function throughAjax(sendable, controller, method) {
    $.ajax({
      type:method, 
      data:sendable, 
      url:controller,
      dataType:'json'
    }).done(function(){
      window.location.reload();
    })
  }


})




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