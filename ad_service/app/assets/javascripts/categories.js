$(function() {
  $(document).on('turbolinks:load', function() {
  $('#new-category-button').click(function() {
    $(this).fadeOut();
    $('#new-category-form').fadeIn();
  })
})
});


$(document).on('click', '.edit-category-button',function() {
    var id = $(this).parent().attr("data-check-id");
    console.log($("#edit_category_" + id));
    $("#edit_category_" + id).fadeIn();
  });

$(document).on('click', '.category-list-item', function() {
  $(this).addClass('active-category-item').siblings().removeClass('active-category-item');
  var sendable = {
    filter: {
      category: $('.active-category-item').attr('data-id'),
    }
  }
  $.ajax({
    type: 'post',
    url: '/home_filter',
    dataType: 'script',
    data: sendable
  })
})

