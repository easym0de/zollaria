// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .
$(function () {
  // Search form.
  $('#products_search').submit(function () {
    $.get(this.action, $(this).serialize(), null, 'script');
    return false;
  });
});

$(function () {
  $('#buy_check').live('click', function () {
	$.get('/buy_check', $(this).closest('form').serialize(), null, 'script');
	return false;
  });
});

$(function () {
  $('#buy_confirm').live('click', function () {
	$.get('/buy_confirm', $(this).closest('form').serialize(), null, 'script');
	return false;
  });
});

$(function () {
  $('#likeButton').live('click', function () {
  	var status_text = $(this).find('#status_text').text();
  	var path = '/like';
  	if(status_text == 'Liked'){
  		path = '/unlike'
  	}

  	var param = 'inventory_id=' + $(this).parent().attr('id')
    $.get(path, param, null, 'script');
    return false;
  });
})

$(function () {
  $('#nav_home').live('click', function () {
    $.get('/home_ajax', $(this).serialize(), null, 'script');
    return false;
  });
})

$(function () {
  $('#nav_friends').live('click', function () {
    $.get('/friends_main', $(this).serialize(), null, 'script');
    return false;
  });
})

$(function () {
  $('#nav_shop').live('click', function () {
    $.get('/shop', $(this).serialize(), null, 'script');
    return false;
  });
 }) 
$(function () {
  $('#viewProfile').live('click', function () {
    $.get('/view_friend_profile', $(this).closest('form').serialize(), null, 'script');
    return false;
  });
})
