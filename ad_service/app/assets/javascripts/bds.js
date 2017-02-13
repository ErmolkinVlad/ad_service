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

$(document).on('click', '.search-filter-link', function(e) {
  if (($(this).children().hasClass('selected')) && ($(e.target).hasClass('search-filter-link'))) {
    $(this).children().removeClass('selected');
  } else {
    $(this).children().addClass('selected');
  }
})

$(document).on('click', '#q_category_id_eq, #q_status_eq', function(e) {
  if($('#q_category_id_eq').find(":selected").val() != '') {
    $('#category-tag').text('#' + $('#q_category_id_eq').find(":selected").text());
    $('#category-tag').fadeIn();
  } else {
    $('#category-tag').fadeOut();
  }
  if($('#q_status_eq').find(":selected").val() != '') {
    $('#status-tag').html('#' + $('#q_status_eq').find(":selected").text());
    $('#status-tag').fadeIn();
  } else {
    $('#status-tag').fadeOut();
  }
  var sendable = {
    filter: {
      category: $('#q_category_id_eq').find(":selected").val(),
      status: $('#q_status_eq').find(":selected").val()
    }
  }
  $.ajax({
    type: 'post',
    url: $(this).parent().attr('action'),
    dataType: 'script',
    data: sendable
  })
})

$(document).on('click', '#category-tag, #status-tag', function(e) {

})