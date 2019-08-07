$(function(){

	setTimeout("$('#flash').fadeOut('slow')",1500);

	var post_array = [];
	var post_num   = [];
	
	//<li>作成
	function createFavPost(post,id_now,i){
		post_array.push(post);
		post_num.push(i);

		$('.favpost ul').append('<li value='+i+'><img></li>');
		$('.favpost').find('li').attr({
			class: 'slide'
		});

		if ($('.favpost').find('li').val() == 0){
			$('.favpost').find('li:eq(0)').addClass('active');
		}
		
	}

	//データ取得
	$(window).load(function(){
		var favpost_id_now = $('.favpost').data('id');
		$.ajax({
			url: '/posts',
			type: 'GET',
			data: {favpost: {id: favpost_id_now}},
			context: favpost_id_now,
			dataType: 'json'
		})
		.done(function(data){
			$.each(data, function(i,data){
				createFavPost(data,favpost_id_now,i);
				$('.favpost').find('img:eq('+i+')').attr({
					id: '注目投稿:id'+i,
					src: `${post_array[i].image.url}`
				});
			});

		})
		.fail(function(){
			alert('error');
		})
	});

	$('.change-btn').click(function(){
		var $changePost = $('.active');
		var slideIndex  = $('.slide').index($('.active'));
		$changePost.removeClass('active');
		
		if ($(this).hasClass('prev-btn')){
			if (slideIndex == 0){
				$('.slide').eq(post_num.length-1).addClass('active');
			}
			$changePost.prev().addClass('active');
		}else{
			if (slideIndex == post_num.length-1){
				$('.slide').eq(0).addClass('active');
			}
			$changePost.next().addClass('active');
		}
	});

	$('.form').on('change','input[type="file"]',function(e) {
		var file = e.target.files[0];
		var reader = new FileReader();

		if(file.type.indexOf("image")<0){
			return false;
		}

		reader.onload = (function(file){
			return function(e){
				$('.preview').empty();
				$('.preview').append($('<img>').attr({
					src: e.target.result,
					alt: ' '
				}));
			};
		})(file);

		reader.readAsDataURL(file);
	});

}); 