$(function(){

	setTimeout("$('#flash').fadeOut('slow')",1500);
	

	$('.prev-btn').click(function(){
		var recpost_id_now = $('.recpost').data('id');
		$.ajax({
			url: '/',
			type: 'GET',
			data: {recpost: {id: recpost_id_now, rec: true}},
			dataType: 'json'
		})
		.done(function(data){
			$('.recpost > img').attr('src','post_images/'+data[0].image_name+'');

			var recpost_id_next = data[0].id;

		})
		.fail(function(){
			alert('エラー');
		})
	});

}); 