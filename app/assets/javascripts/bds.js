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

$(document).on('turbolinks:load', setStatuses);


function setStatuses() {
  var list = $('#home-advert-list, #user-adverts-list').children('li');
  for(var i = 0; i < list.length; i++){
    if($(list[i]).find('#current_status').get(0)){
      var status = $(list[i]).find('#current_status').get(0).value;
      if(status == 'recent' || status == 'archived'){
        $(list[i]).find('#status_moderated').fadeIn();
      }
      if(status != 'archived'){
        $(list[i]).find('#status_archived').fadeIn();
      }
    }
  }
}

$(document).on('click', '.search-filter-link', function(e) {
  if (($(this).children().hasClass('selected')) && ($(e.target).hasClass('search-filter-link'))) {
    $(this).children().removeClass('selected');
  } else {
    $(this).children().addClass('selected');
  }
})


$(document).on('mouseenter', '.search-filter-link', function() {
    clearTimeout($(this).data('timeoutId'));
    $(this).find("#advert_search").fadeIn("fast");
});

$(document).on('mouseleave', '.search-filter-link', function() {
    var someElement = $(this),
        timeoutId = setTimeout(function(){
            $('.search-filter-link').children().removeClass('selected');
        }, 650);
    //set the timeoutId, allowing us to clear this trigger if the mouse comes back over
    someElement.data('timeoutId', timeoutId); 
});




function sendFilterThroughAjax(controller, method) {
  var sendable = {
    filter: {
      category: $('#q_category_id_eq').find(":selected").val(),
      ad_type: $('#q_ad_type_eq').find(":selected").val()
    }
  }
  $.ajax({
    type: method,
    url: controller,
    dataType: 'script',
    data: sendable
  })
}

function changeTags() {
  if ($('#q_category_id_eq').find(":selected").val() != '') {
    $('#category-tag').text('#' + $('#q_category_id_eq').find(":selected").text());
    $('#category-tag').fadeIn();
  } else {
    $('#category-tag').fadeOut();
  }
  if($('#q_ad_type_eq').find(":selected").val() != '') {
    $('#ad_type-tag').html('#' + $('#q_ad_type_eq').find(":selected").text());
    $('#ad_type-tag').fadeIn();
  } else {
    $('#ad_type-tag').fadeOut();
  }
}

$(document).on('click', '#user-show-block #q_category_id_eq, #user-show-block #q_ad_type_eq', function(e) {
  changeTags();
  sendFilterThroughAjax($(this).parent().attr('action'), 'get');
})

$(document).on('click', '#home-index-block #q_category_id_eq, #home-index-block #q_ad_type_eq', function(e) {
  changeTags();
  sendFilterThroughAjax($(this).parent().attr('action'), 'get');
})