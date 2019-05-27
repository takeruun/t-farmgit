$(function(){

	setTimeout("$('#flash').fadeOut('slow')",1500);

	var post_array = [];
	var post_num   = [];
	
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
	function createSlidePost(){
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
		var recpost_id_now = $('.recpost').data('id');
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
			createSlidePost();
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