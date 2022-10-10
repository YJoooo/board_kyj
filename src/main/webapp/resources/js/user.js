$(document).ready(function() {
	//alert("연결완료!");
	
	// 검색 button
	/*
	$("#sch_button").click(function(){
		$.ajax({
            url : './userList',
            data : $('#frm').serialize(),
            type : "POST",
            success : function(result) {     
                //alert(result.success);
                alert($("#userListSearchPeriod").val());
                //alert(result.userListSearchWord);
                //location.href = "./userList";
                location.reload;
            },
            error : function(error) {     
                alert(error);    
            }
        });
	});
	*/
	
    // 등록 button
	$("#userInsert").click(function() {
	
		var userId = $('.userId').val();
		var userPass = $('#userPass').val();
		var userPassCheack = $('#userPassCheack').val();
		var userName = $("#userName").val();
		var emailVal = $("#email").val();
		var telephone = $("#telephone").val();
		
		var gender = $('input[name=gender]:radio:checked');
		var address = $('input[name=address]');
		if(userId==""||userId==null){
			$("#checkId").html('아이디를 입력해주세요.');
			$("#checkId").attr('color','red');
			return false;
		}
		$.ajax({
			url : "./checkId",
			type : "post",
			data : $('#insertFrm').serialize(),
			success : function(data){
				if(data.result == 1){
					$("#checkId").html('이미 존재하는 아이디입니다.');
					$("#checkId").attr('color','red');
					return false;
				} else{
					$("#checkId").html('사용 가능한 아이디입니다.');
					$("#checkId").attr('color','green');
				} 

			},
			error : function(request, status, error){
				alert("서버요청실패");
				alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error);
			}
		})
		 
		// 비밀번호 유효성
	 	if(userPass==""||userPass==null){
			$("#checkPass").html('비밀번호를 입력해주세요.');
			$("#checkPass").attr('color','red');
			return false;
		}
   	    if(!/^[a-zA-Z0-9]{8,16}$/.test(userPass)){
			$("#checkPass").html('숫자와 영문자 조합으로 8~16자리를 사용해야 합니다.');
			$("#checkPass").attr('color','red');
	   	    return false;
	   	}

	   	  var checkNum = userPass.search(/[0-9]/g); // 숫자사용
	   	  var checkEng = userPass.search(/[a-z]/ig); // 영문사용
	
	   	  if(checkNum <0 || checkEng <0){
	  		$("#checkPass").html('숫자와 영문자 조합으로 사용해야 합니다.');
			$("#checkPass").attr('color','red');
	   	    return false;
	   	  }
			if(userPass!=userPassCheack){
				$("#checkPass").html('비밀번호가 일치하지 않습니다.');
				$("#checkPass").attr('color','red');
				return false;
			}else{
				$("#checkPass").html('비밀번호가 일치합니다.');
				$("#checkPass").attr('color','green');
			}

		// 이름 유효성검사
		if(userName==""||userName==null){
			$("#checkName").html('이름을 입력해주세요.');
			$("#checkName").attr('color','red');
			return false;
		}
		var n_RegExp = /^[가-힣]{2,15}$/;
		if(!n_RegExp.test(userName)){
			$("#checkName").html('한글만 입력 가능합니다.');
			$("#checkName").attr('color','red');
			return false;
		}else{
			$("#checkName").html('');
		}
		// 이메일 유효성검사
		if(emailVal==""||emailVal==null){
			$("#checkEmail").html('이메일을 입력해주세요.');
			$("#checkEmail").attr('color','red');
			return false;
		}
	  	var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
		  if (emailVal.match(regExp) != null) {
				$("#checkEmail").html('이메일 인증이 완료되었습니다.');
				$("#checkEmail").attr('color','green');
	
		  }
		  else {
			$("#checkEmail").html('이메일형식이 잘못되었습니다.');
			$("#checkEmail").attr('color','red');
			return false;
		  }
		// 휴대폰번호 유효성 검사
		if(telephone==""||telephone==null){
			$("#checkTel").html('전화번호를 입력해주세요.');
			$("#checkTel").attr('color','red');
			return false;
		}
		
		if(telephone.length==13||telephone.length==12||telephone.length==11){
			$("#checkTel").html('');
		}else{
			$("#checkTel").html('전화번호 형식이 잘못되었습니다.');
			$("#checkTel").attr('color','red');
			return false;
		}
		// 성별 유효성 검사
	 	if(gender.length<1){
			$("#checkGender").html('성별을 선택해주세요.');
			$("#checkGender").attr('color','red');
	 		return false;
	 	}else{
	 		$("#checkGender").html('');
	 	}
	 	// 주소 유효성 검사	
	 	if(address.val()==null||address.val()==""){
			$("#checkAddress").html('주소를 입력해주세요.');
			$("#checkAddress").attr('color','red');
	 		return false;
	 	}else{
	 		$("#checkAddress").html('');
	 	}
	 	if(!confirm("회원정보를 등록하시겠습니까?")) return;
	    var detailAddress = document.getElementById("detailAddress").value;
	    //alert("상세주소11 ==> " + detailAddress);
        document.getElementById("address").value += " " + detailAddress;
        //alert("상세주소22 ==> " + document.getElementById("address").value);
        //return;
        
	    $.ajax({
            url : './userInsert',
            data : $('#insertFrm').serialize(),
            type : "POST",
            success : function(result) {     
                //alert(result.success);
                alert(result.message);
                if(!confirm("로그인하시겠습니까?")){
                	location.href = "./";
                }else{
                	location.href = "./userLoginPage";
                }
            },
            error : function(error) {     
                alert(error);    
            }
        });
    })
    // 수정 button
    $("#userUpdate").click(function() {
	    if(!confirm("수정하시겠습니까?")) return;
	    // 상세주소 합치기
	   	var detailAddress = document.getElementById("detailAddress").value;
        document.getElementById("address").value += " " + detailAddress;
	    
	    var userId = $('#userId').val();
	    $.ajax({
            url : './userUpdate',
            data : $('#Frm').serialize(),
            type : "POST",
            success : function(result) {     
                //alert(result.success);
                alert(result.message);
                location.href = "./userDetail?userId="+userId;
            },
            error : function(error) {     
                alert(error);    
            }
        });
    })

    // 삭제 button
    $("#userDelete").click(function() {
	    if(!confirm("회원을 탈퇴하겠습니까?")) return;
	    $.ajax({
            url : './userDelete',
            data : $('#Frm').serialize(),
            type : "POST",
            success : function(result) {     
                //alert(result.success);
                alert(result.message);
                location.href = "./logout";
                location.href = "./";
            },
            error : function(error) {   
                alert(error);    
            }
        });
    })
    // 삭제 button
    $("#userMasterDelete").click(function() {
	    if(!confirm("회원정보를 삭제하겠습니까?")) return;
	    $.ajax({
            url : './userDelete',
            data : $('#Frm').serialize(),
            type : "POST",
            success : function(result) {     
                //alert(result.success);
                alert(result.message);
                location.href = "./userList";
            },
            error : function(error) {   
                alert(error);    
            }
        });
    })

});


function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('userZipcode').value = data.zonecode;
            document.getElementById("userAddress").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("detailAddress").focus();
            // 최종 주소 가져오기
            document.getElementById("address").value = addr+extraAddr;
            
        }
        
    }).open();
}
$(document).ready(function (e) {
	$("#userLogin").on('click', function() {
		// 입력 값 체크
			if($.trim($('#userId').val()) == ''){
				alert("아이디를 입력해 주세요.");
				$('#userId').focus();
				return;
			}else if($.trim($('#userPass').val()) == ''){
				alert("패스워드를 입력해 주세요.");
				$('#userPass').focus();
				return;
			}
			
			//전송
			$('#loginFrm').submit();
	});
});

// 리스트 선택박스 전체 선택
function selectAll(source) {
	var checkboxes = document.getElementsByName('check');
	for(var i=0; i<checkboxes.length; i++) {        
	checkboxes[i].checked = source.checked; // '모두 체크'에 체크가 되면 다 체크하고 아니면 다 해제하고! 
	}
}

// 리스트 삭제
function deleteUser(){
	var url = "./deleteUser";
	var valueArr = new Array();
    var list = $("input[name='check']");
    for(var i = 0; i < list.length; i++){
        if(list[i].checked){
            valueArr.push(list[i].value);
        }
    }
    //alert("valueArr ===>> " + valueArr);
    //return;
    
    if (valueArr.length == 0){
    	alert("선택된 리스트가 없습니다.");
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
                	location.reload();
        		},
	            error:function(request,status,error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});
		}	
	}
}

