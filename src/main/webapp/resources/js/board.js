$(document).ready(function() {
	//alert("연결완료!");

    // 수정 button
    $("#boardUpdate").click(function() {
	    if(!confirm("수정하시겠습니까?")) return;
	    var boardno = $('#boardno').val();
	    $.ajax({
            url : './boardUpdate',
            data : $('#Frm').serialize(),
            type : "POST",
            success : function(result) {     
                //alert(result.success);
                alert(result.message);
                location.href = "./boardDetail?boardno="+boardno;
            },
            error : function(error) {     
                alert(error);    
            }
        });
    })

    // 삭제 button
    $("#boardDelete2").click(function() {
	    if(!confirm("삭제하시겠습니까?")) return;
	    $.ajax({
            url : './boardDelete',
            data : $('#Frm').serialize(),
            type : "POST",
            success : function(result) {     
                //alert(result.success);
                alert(result.message);
                location.href = "./";
            },
            error : function(error) {   
                alert(error);    
            }
        });
    })



    // 등록 button
	$("#boardInsert").click(function() {
	
		var notice_YN = $('input[name=notice_YN]:radio:checked');
		var writeDate = $('input[name=writeDate]');
		var boardTitle = $('input[name=boardTitle]');
		var boardContents = $('textarea[name=boardContents]');
		if(writeDate.val()==""||boardTitle.val()==""||boardContents.val()==""
			||notice_YN.length<1){
		 	if(notice_YN.length<1){
				alert("공지여부는 필수입력사항입니다.");
		 		return;
		 	}if(writeDate.val()==null||writeDate.val()==""){
				alert("등록일자는 필수입력사항입니다.");
				writeDate.focus();
		 		return;
		 	}if(boardTitle.val()==null||boardTitle.val()==""){
				alert("제목은 필수입력사항입니다.");
				boardTitle.focus();
		 		return;
		 	}if(boardContents.val()==null||boardContents.val()==""){
				alert("내용은 필수입력사항입니다.");
				boardContents.focus();
		 		return;	
			}
	 	}else{ 
		 	if(!confirm("게시물을 등록하시겠습니까?")) return;}
	    $.ajax({
            url : './boardInsert',
            data : $('#insertFrm').serialize(),
            type : "POST",
            success : function(result) {     
                //alert(result.success);
                alert(result.message);
                location.href = "./";
            },
            error : function(error) {     
                alert(error);    
            }
        });
    })
});

// 리스트 선택박스 전체 선택
function selectAll(source) {    
	var checkboxes = document.getElementsByName('check');    
	for(var i=0; i<checkboxes.length; i++) {        
	checkboxes[i].checked = source.checked; // '모두 체크'에 체크가 되면 다 체크하고 아니면 다 해제하고! 
	}
}

// 리스트 삭제
function deleteValue(){
	var MEMAUTHORITY = $("#MEMAUTHORITY").val()
	var url = "./deleteBoard";
	var valueArr = new Array();
    var list = $("input[name='check']");
    for(var i = 0; i < list.length; i++){
        if(list[i].checked){
            valueArr.push(list[i].value);
        }
    }
    //alert("valueArr ===>> " + valueArr);
    //return;
    if(MEMAUTHORITY=='관리자'){
	    if (valueArr.length == 0){
	    	alert("선택된 리스트가 없습니다.");
	    	return;
	    }
	    else{
			var chk = confirm("정말 삭제하시겠습니까?");
			if(chk){			 
				$.ajax({
				    url : url,
				    type : 'POST',
				    traditional : true,
				    data : {valueArr : valueArr},
		            success: function(data){
	                	alert("삭제 성공 : " + data.rtnCnt + "건이 정상삭제되었습니다.");
	                	//location.href="/prac/getUserList.do"
	                	location.reload();
	        		},
		            error:function(request,status,error){
						alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					}
				});
			}	
		}
	}else{
		alert("관리자만 삭제 가능합니다.");
	}
}
