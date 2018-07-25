	function del(id, type){
		if(confirm("정말로 삭제하시겠습니까?")){
			$.ajax({
				"url" : "/board/del",
				"type" : "post",
				"data" : {"id" : id},
				"success" : function(data){
					alert("삭제가 완료됐습니다. 리스트로 이동합니다.");
					location.href = '/board/list/'+type;
				}
			})
		}
	}
	
	function delComment(id, boardId){
		if(confirm("정말로 삭제하시겠습니까?")){
			$.ajax({
				"url" : "/comment/del",
				"type" : "post",
				"data" : {"id" : id},
				"success" : function(data){
					alert("삭제가 완료됐습니다.");
					location.href = '/board/view?id='+boardId;
				}
			})
		}
	}
	
	function mod(id){
		if(confirm("수정하시겠습니까?")){
			location.href = '/board/update?id='+id;
		}
	}
	
	function notice(id){
		if(confirm("이 글을 공지로 등록하시겠습니까?")){
			$.ajax({
				url : '/board/notice',
				type : 'post',
				data : {id : id},
				success : function(data){
					if(data == 'notAdmin'){
						alert("비정상적 접근입니다.");
						return;
					}else if(data == 'error'){
						alert("에러가 발생했습니다. 잠시 후 다시 시도해주세요.");
						return;
					}else if(data == 'success'){
						alert("공지로 등록했습니다.");
						location.href='/board/view?id='+id;
					}
				}
			});
		}
	}
	
	function delNotice(id){
		if(confirm("공지에서 해제하시겠습니까?")){
			$.ajax({
				url : '/board/delNotice',
				type : 'post',
				data : {id : id},
				success : function(data){
					if(data == 'notAdmin'){
						alert("비정상적 접근입니다.");
						return;
					}else if(data == 'error'){
						alert("에러가 발생했습니다. 잠시 후 다시 시도해주세요.");
						return;
					}else if(data == 'success'){
						alert("일반글로 전환하였습니다.");
						location.href='/board/view?id='+id;
					}
				}
			});
		}
	}
	
	function love(id){
		$.ajax({
			url : "/comment/love",
			type : 'post',
			data : {id : id},
			success : function(data){
				if(data == 'dual'){
					alert("이미 추천/비추천한 댓글입니다.");
					return;
				}else if (data == 'error'){
					alert("서버 에러입니다. 잠시 후 다시 시도하세요.");
					return;
				}
				location.reload();
			}
		})
	}
	
	function hate(id){
		$.ajax({
			url : "/comment/hate",
			type : 'post',
			data : {id : id},
			success : function(data){
				if(data == 'dual'){
					alert("이미 추천/비추천한 댓글입니다.");
					return;
				}else if (data == 'error'){
					alert("서버 에러입니다. 잠시 후 다시 시도하세요.");
				}
				location.reload();
				
			}
		})
	}
	
	function favorite(id){
		$.ajax({
			url : "/board/favorite",
			type : "post",
			data : {id : id},
			success : function(data){
				if(data == 'dual'){
					alert("이미 추천한 게시글입니다.");
					return;
				}else if (data == 'error'){
					alert("서버 에러입니다. 잠시 후 다시 시도하세요.");
					return;
				}
				alert("게시글을 추천했습니다.");
				location.reload();
			}
		});
	}