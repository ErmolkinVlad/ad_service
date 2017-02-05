$(document).on('turbolinks:load', function() {
  $('#accept-button, #reject-button').click(function(e) {
    console.log("=========================")
    var controller = $('#control-hidden-status').attr('data-controller')
    console.log(controller)
    var data = {
      advert: {
        status: ''
      }
    }
    if($(e.target).attr('data-text') == 'accept') {
      console.log("!!!!!!!!!!!!!!!!!")
      data.advert.status = 'published'
      throughAjax(data, controller, 'PUT')
    } else if($(e.target).attr('data-text') == 'reject') {
      data.advert.status = 'canceled'
      throughAjax(data, controller, 'PUT')
    }
  })
  function throughAjax(sendable, controller, method) {
    console.log(sendable, controller)
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