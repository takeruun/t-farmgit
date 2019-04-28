$(function(){

	setTimeout("$('#flash').fadeOut('slow')",1500);

	var post_array = [];
	var post_num = [];
	var recpost_id_now = $('.recpost').data('id');

	//<li>作成
	function createRecPost(post,id_now,i){
		post_array.push(post);
		post_num.push(i);

		$('.recpost ul').append('<li value='+i+'><img></li>');
		$('.recpost').find('li').attr({
			class: 'slide'
		});
	}

	//<li>にオススメ画像登録
	function slidePost(){
		for(var i=0;i<post_num.length;i++){

			if ($('.recpost').find('li').val() == 0){
				$('.recpost').find('li:eq(0)').addClass('active');
			}
			var image_name = post_array[i].image_name;
			$('.recpost').find('img:eq('+i+')').attr({
				alt: ' ',
				src: '/post_images/'+image_name+''
			});
		}
	}

	//旬物(true)の分だけデータ取得
	$(window).load(function(){
		$.ajax({
			url: '/',
			type: 'GET',
			data: {recpost: {id: recpost_id_now, rec: true}},
			context: recpost_id_now,
			dataType: 'json'
		})
		.done(function(data){
			$.each(data, function(i,data){
				createRecPost(data,recpost_id_now,i);
			});
			slidePost();
		})
		.fail(function(){
			alert('error');
		})
	});



}); 