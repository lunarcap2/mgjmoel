<%@codepage="949" language="VBScript"%>

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<%
'--------------------------------------------------------------------
'   Comment		: 개인회원 가입
' 	History		:
'---------------------------------------------------------------------
Session.CodePage  = 949			'한글
Response.CharSet  = "euc-kr"	'한글
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "cache-control", "no-staff"
Response.Expires  = -1

If Request.ServerVariables("HTTPS") = "off" Then
	Response.redirect "https://"& Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("URL")
End If

If request.Cookies(site_code & "WKP_F")("id") <>"" Then
	Response.Write "<script language=javascript>"&_
		"alert('로그인 상태에서는 해당 페이지에 접근할 수 없습니다.\n로그아웃 후 이용 바랍니다.');"&_
		"location.href='/';"&_
		"</script>"
	response.End
End If
%>
<script type="text/javascript">
	// SMS 인증 번호 전송
	/* start */
	function fnAuthSms() {
		if ($("#mobileAuthNumChk").val() == "4") {
			alert("인증이 완료되었습니다.");
			return;
		}

		$("#hd_idx").val("");

		var strEmail;
		var contact = $("#txtPhone").val();

		if (Authchk_ing) {
			alert("처리중 입니다. 잠시만 기다려 주세요.");
		} else {
			if(contact=="“-” 생략하고 숫자만 입력해 주세요."){
				contact="";
			}

			if(contact==""){
				alert("연락처를 입력해 주세요.");
				$("#txtPhone").focus();
				return;
			}

			if(contact.length<10){
				alert("정확한 연락처를 입력해 주세요.");
				$("#txtPhone").focus();
				return;
			}
			else {
				Authchk_ing = true;

				var strUrl = "https://app.career.co.kr/sms/career/Authentication";

				var parm = {};

				parm.authCode	= "1";		// sms:1 | email:2
				parm.authvalue	= $("#txtPhone").val();		// 핸드폰 no( - 는 입력 해도 되고 안해도 됩니다.)
				parm.sitename	= "<%=site_short_name%>";	// sms 발송시 해당 내용으로 입력 됩니다.
				parm.sitecode	= "37";		// sitecode(꼭 해당 사이트 코드를 입력하세요) 발송 log 및 email 발송시 구분합니다. => 코드 정의(커리어 : 2, 박람회 : 37)
				parm.memkind	= "개인";
				parm.ip			= "";		// 개인 IP
				parm.callback	= "jsonp_sms_callback";

				$("#aMobile").text("인증번호 재전송");
				$.ajax({
					url: strUrl
					, dataType: "jsonp"
					, type: "post"
					, data: parm
					, success: function (data) {
						//alert("sccess : " + data.length);
					}
					, error: function (jqXHR, textStatus, errorThrown) {
						//alert(textStatus + ", " + errorThrown);
					}
				});
			}
		}
	}

	// Result 처리는 이곳에서 합니다.
	function jsonp_sms_callback(data) {
		Authchk_ing = false;
		if ($.trim(data.result) == "true") {
			$("#mobileAuthNumChk").val("1");

			$("#phone_box").hide();
			$("#timeCntdown").show();
			fnDpFirst();
			fncDpTm(); //카운트

			$("#hd_idx").val(data.result_idx);
			alert("인증번호가 발송되었습니다.");
			$("#rsltAuthArea").show();
			$("#mobileAuthNumber").val("");
			$("#mobileAuthNumber").focus();
			$("#hd_kind").val("1");
		} else {
			$("#timeCntdown").hide();
			$("#rsltAuthArea").hide();
			$("#emailAuthNumChk").val("0");
			alert("인증번호 발송이 실패하였습니다.");
		}
	}
	/* end */

	// 인증번호 확인
	/* start */
	function fnAuth() {
		if ($("#hd_kind").val() == "1" && $("#mobileAuthNumChk").val() == "4") {
			alert("인증이 완료되었습니다.");
			return;

		} else if ($.trim($("#hd_idx").val()) == "") {
			alert("인증번호가 맞지 않습니다. 인증번호를 확인해 주세요.");
			return;
		}

		$("#mobileAuthNumber").val($.trim($("#mobileAuthNumber").val()));
		if  ($("#hd_kind").val() == "1") {
			if ($.trim($("#mobileAuthNumber").val()) == "") {
				alert("인증번호를 입력해 주세요.");
				$("#mobileAuthNumber").focus();
				return;
			}
		}

		var strUrl	= "https://app.career.co.kr/sms/career/AuthenticationResult";
		var parms	= {};

		var strAuthKey = "";
		if ($("#hd_kind").val() == "2") {
			strAuthKey = $("#emailAuthNumber").val();
		} else if ($("#hd_kind").val() == "1") {
			strAuthKey = $("#mobileAuthNumber").val();
		} else {
			return;
		}

		if ($.trim($("#hd_idx").val()) == "" || ($.trim($("#emailAuthNumber").val()) == "" && $.trim($("#mobileAuthNumber").val()) == "")) {
			return;
		}

		parms.authCode	= $("#hd_kind").val();	// sms:1 | email:2

		parms.authvalue	= strAuthKey;			// 발송된 인증 KEY Value

		parms.idx		= $("#hd_idx").val();	// 발송된 인증 번호
		parms.callback	= "jsonp_result_callback";
		$.ajax({
			url: strUrl
				, dataType: "jsonp"
				, type: "post"
				, data: parms
				, success: function (data) {
					//alert("sccess : " + data.length);
				}
				, error: function (jqXHR, textStatus, errorThrown) {
					//alert(textStatus + ", " + errorThrown);
				}
		});
	}

	//Result 처리는 이곳에서 합니다.
	function jsonp_result_callback(data) {
		if ($("#hd_kind").val() == "1") {
			if ($.trim(data.result_idx) == "Y") {
				$("#mobileAuthNumChk").val("4");
				$("#rsltMsg1").show();
				$("#authproc").val("1");
				$("#timeCntdown").hide();
				$("#rsltMsg2").hide();
			} else {
				$("#mobileAuthNumChk").val("3");
				$("#rsltMsg1").hide();
				$("#timeCntdown").show();
				$("#rsltMsg2").show();
			}
		}
	}
	/* end */

	var emailchk_ing	= false;
	var Authchk_ing		= false;

	var min = 60;
	var sec = 60;
	var ctm;			// 표시 시간
	var inputtime = 3;	// 입력분
	var tstop;			// 타이머 정지

	Number.prototype.dptm = function () { return this < 10 ? '0' + this : this; } //분에 "0" 넣기

	function fnDpFirst() {
		clearTimeout(tstop);
		ctm = sec * inputtime;
	}

	function fncDpTm() {
		var cmi = Math.floor((ctm % (min * sec)) / sec).dptm();
		var csc = Math.floor(ctm % sec).dptm();

		//document.getElementById("ctm1").innerText = cmi + ' : ' + csc; //값 보여줌
		//document.getElementById("").innerText = '남은시간 ' + cmi + ' : ' + csc; //값 보여줌
		$("#timeCntdown").text('(' + cmi + ' : ' + csc + ")");
		if ((ctm--) <= 0) {
			ctm = sec * inputtime;
			clearTimeout(tstop);
			//재전송버튼
			//인증시간 초과 meassage
		}
		else {
			tstop = setTimeout("fncDpTm()", 1000);
		}
	}

	// 인증번호 검증 함수 호출
	function fnAuthNoChk(){
		fnAuth();
	}

	// 휴대폰번호 중복 가입 검증
	function fn_chkJoin(){
		if($("#txtPhone").val()=="“-” 생략하고 숫자만 입력해 주세요."){
			$("#txtPhone").val("");
		}

		if($("#txtPhone").val()==""){
			alert("연락처를 입력해 주세요.");
			$("#txtPhone").focus();
			return;
		}

		if($("#txtPhone").val().length<10){
			alert("정확한 연락처를 입력해 주세요.");
			$("#txtPhone").focus();
			return;
		} else {
			$.ajax({
				type: "POST"
				, url: "phone_CheckAll.asp"
				, data: { user_phone: $("#txtPhone").val() }
				, dataType: "text"
				, async: true
				, success: function (data) {
					// 기존 등록된 휴대폰번호가 존재하면 X, 없으면 O
					if (data.trim() == "X") {
						alert("입력하신 휴대폰번호로 회원 가입된 내역이 존재합니다.\n아이디 찾기를 이용하여 기존 가입하신 계정을 확인해 주세요.");
						return;
					} else {
						fnAuthSms();
					}
				}
				, error: function (XMLHttpRequest, textStatus, errorThrown) {
					alert(XMLHttpRequest.responseText);
				}

			});
		}
	}

	// 입력 값 체크
	function fn_sumbit(){
		var txtId					= $("#txtId").val();								// 아이디
		var txtPass					= $("#txtPass").val();								// 비번
		var txtPassChk				= $("#txtPassChk").val();							// 비번확인
		var	txtName					= $("#txtName").val();								// 이름
		var txtBirth				= $('#txtBirth').val();								// 생년월일
		var gender					= $('input[name="gender"]:checked').val();			// 성별(1:남자, 2:여자)
		var selFinalSchType			= $('#sel_finalSchType option:selected').val();		// 최종학력(1:고졸, 2:초대졸, 3:대졸, 4:대재, 5:대학원졸) 
		var txtEmail				= $("#txtEmail").val();								// 이메일
		var txtPhone				= $("#txtPhone").val();								// 휴대폰
		var chkMilitaryPersonnel	= $('#chk_military_personnel').is(':checked');		//true: 군무원, false: 군무원아님

		/*군무원일때 입력한 값-S*/
		var militaryPersonnelCorps	= $('#military_personnel_corps').val();		//소속부대명
		var militaryPersonnelNumber	= $('#military_personnel_number').val();	//순번
		/*군무원일때 입력한 값-E*/

		/*군무원이 아닐때 입력한 값-S*/
		var militaryGroup	= $('#military_group option:selected').val();		//군별(1:육군, 2:해군, 3:공군, 4:해병대)
		var militaryCorps	= $('#military_corps').val();						//소속부대명
		var militaryRank	= $('input[name="military_rank"]:checked').val();	//계급및 직책(1:이병, 2:일병, 3:상병, 4:병장, 5:하사, 6:중사, 7:상사, 8:원사, 9:준위, 10:소위, 11:중위, 12:대위, 13:소령, 14:중령, 15:대령)
		var militaryNumber	= $('#military_number').val();						//군번
		var militaryEndDT	= $('#military_end_date').val();					//전역일
		/*군무원이 아닐때 입력한 값-E*/

		var agreeCheck	= $('input[name="agreeCheck"]:checked').val();	// 이용약관 및 개인정보 수집 동의


		if(txtId==""){
			alert("아이디를 입력해 주세요.");
			$("#txtId").focus();
			return;
		}

		if($("#id_box").text()!="사용 가능한 아이디입니다."){
			alert("아이디를 다시 확인해 주세요.");
			$("#txtId").focus();
			return;
		}

		if(txtPass==""){
			alert("비밀번호를 입력해 주세요.");
			$("#txtPass").focus();
			return;
		}

		if($("#pw_box").text()!=""){
			alert("입력하신 비밀번호가 보안상 매우 취약합니다.\n8~32자까지 영문, 숫자, 특수문자 등의 조합으로\n아이디와 무관한 문자열을 입력해 주세요.");
			$("#txtPass").focus();
			return;
		}

		if(txtPassChk==""){
			alert("비밀번호 확인란을 입력해 주세요.");
			$("#txtPassChk").focus();
			return;
		}

		if(txtPassChk!=txtPass){
			alert("비밀번호와 비밀번호 확인란에 입력한 정보가\n일치하지 않습니다. 다시 확인해 주세요.");
			$("#txtPassChk").focus();
			return;
		}

		if(txtName==""){
			alert("이름을 입력해 주세요.");
			$("#txtName").focus();
			return;
		}

		if(txtBirth == '') {
			alert('생년월일을 입력해주세요.');
			$('#txtBirth').focus();
			return;
		}

		if(typeof gender == 'undefined' || gender == '' || gender == null) {
			alert('성별을 선택해주세요.');
			$('[name="gender"]').focus();
			return;
		}

		if(selFinalSchType == '') {
			alert('최종학력을 선택해주세요.');
			$('#sel_finalSchType').focus();
			return;
		}

		if($("#txtEmail").val() == "") {
			alert("이메일을 입력해 주세요.");
			$("#txtEmail").focus();
			return;
		}

		if($("#mail_box").text()=="잘못된 이메일 형식입니다."){
			alert("이메일을 다시 확인해 주세요.");
			$("#mail_box").focus();
			return;
		}

		if(txtPhone==""){
			alert("휴대폰번호를 입력해 주세요.");
			$("#txtPhone").focus();
			return;
		}
		
		if ($("#mobileAuthNumChk").val() != "4") {
			alert("본인 확인을 위해 휴대폰번호를 인증해 주세요.");
			$("#txtPhone").focus();
			return;
		}

		//군무원 선택시
		if(chkMilitaryPersonnel) {
			if(militaryPersonnelCorps == '') {
				alert('소속부대명을 입력해 주세요.');
				$('#military_personnel_corps').focus();
				return;
			}

			if(militaryPersonnelNumber == '') {
				alert('순번을 입력해 주세요.');
				$('#military_personnel_number').focus();
				return;
			}

			//군무원 입력값 체크(0: 잘못입력된값, 1: 정상입력)
			var chk_val = 0;

			$.ajax({
				type: "POST"
				, url: "militaryPersonnel_chk.asp"
				, data: { txtPhone: txtPhone, militaryPersonnelCorps: escape(militaryPersonnelCorps), militaryPersonnelNumber: militaryPersonnelNumber }
				, dataType: "text"
				, async: false
				, success: function (data) {
					chk_val = data;
				}
				, error: function (XMLHttpRequest, textStatus, errorThrown) {
					//alert(XMLHttpRequest.responseText);
				}
			});

			if(chk_val == 0) {
				alert('잘못된 값을 입력하였습니다.\n휴대폰 번호, 소속부대명, 순번을 확인해 주세요.');
				return false;
			}
		}
		//군무원 선택아닐때
		else {
			if(militaryGroup == '') {
				alert('군별을 선택해 주세요.');
				$('#military_group').focus();
				return;
			}

			if(militaryCorps == '') {
				alert('소속부대명을 입력해 주세요.');
				$('#military_corps').focus();
				return;
			}

			if(typeof militaryRank == 'undefined' || militaryRank == '' || militaryRank == null) {
				alert('계급 및 직책을 선택해 주세요.');
				$('#military_rank').focus();
				return;
			}

			if(militaryNumber == '') {
				alert('군번을 입력해 주세요.');
				$('#military_number').focus();
				return;
			}

			if(militaryEndDT == '') {
				alert('전역일을 입력해 주세요.');
				$('#military_end_date').focus();
				return;
			}
		}

		if (agreeCheck != "1"){
			alert('동의하지 않으시면 박람회 사이트 이용이 불가합니다.');
			$('[name=agreeCheck]').focus();
			return;
		}

		var obj=document.frm1;
		if(confirm('입력하신 정보로 회원 가입 하시겠습니까?')) {
			obj.method = "post";
			obj.action = "join_individual_proc.asp";
			obj.submit();
		}
	}

	function onlyNumber(event){
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
			return;
		else
			return false;
	}

	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}

	/*아이디 중복 체크 시작*/
	function fn_checkID() {
		$("#txtId").val($("#txtId").val().toLowerCase());

		$("#id_box").text("");
		$("#id_check").val("0");

		var checkNumber		= $("#txtId").val().search(/[0-9]/g);	// 숫자 입력 체크
		var checkEnglish	= $("#txtId").val().search(/[a-z]/ig);	// 영문 입력 체크

		if($("#txtId").val() == ""){
			$("#id_box").text("아이디를 입력해 주세요.");
			$("#txtId").focus();
			return;
		}else if(!Validchar($("#txtId").val(), num + alpha)){
			$("#id_box").text("아이디는 한글 및 특수문자를 지원하지 않습니다. 다시 입력해 주세요.");
			$("#txtId").focus();
			return;
		}else if($("#txtId").val().length < 5){
			$("#id_box").text("아이디는 최소 5자 이상이어야 합니다.");
			return;
		}else if(checkNumber <0 || checkEnglish <0){
			$("#id_box").text("영문과 숫자를 혼용하여 입력해 주세요.");
			return;
		}else{
			if (/(\w)\1\1\1/.test($("#txtId").val())){	// 같은형식 문자 4글자 이상 사용 금지
				$("#id_box").text("동일한 문자 연속 4글자 이상은 사용 금지합니다.");
				return;
			} else {
				$.ajax({
					type: "POST"
					, url: "Id_CheckAll.asp"
					, data: { user_id: $("#txtId").val() }
					, dataType: "text"
					, async: true
					, success: function (data) {
						// 기존 등록된 아이디가 존재하면 X, 없으면 O
						if (data.trim() == "X") {
							$("#id_box").addClass('bad').removeClass('good');
							$("#id_box").text("탈퇴한 아이디 또는 이미 사용중인 아이디로, 이용하실 수 없습니다.");
							return;
						} else {
							$("#id_check").val("1");
							$("#chk_id").val($("#txtId").val());
							$("#id_box").addClass('good').removeClass('bad');
							$("#id_box").text("사용 가능한 아이디입니다.");
							return;
						}
					}
					, error: function (XMLHttpRequest, textStatus, errorThrown) {
						alert(XMLHttpRequest.responseText);
					}

				});
			}
		}
	}
	/*아이디 중복 체크 끝*/

	/*비밀번호 체크 시작*/
	function fn_checkPW() {
		var chk = false;
		var id	= $("#txtId").val();

		if ($('#txtPass').val().length == 0 ) {
			return;
		} else {
			if ($('#txtPass').val().length < 8 || $('#txtPass').val().length > 32) {
				$("#pw_box").text("비밀번호는 8~32자 까지만 허용됩니다.");
				return false;
			}

			/*if (id != "" && $('#txtPass').val().search(id) > -1) {
				$("#pw_box").text("비밀번호에 아이디가 포함되어 있습니다.");
				return false;
			}*/

			var pattern1 = /[0-9]/;		// 숫자
			var pattern2 = /[a-zA-Z]/;	// 문자
			var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자

			//if (!$('#txtPass').val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)) {
			//if (!$('#txtPass').val().match(/^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/)) {
			//if (!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test($('#txtPass').val())) {
			if(!pattern1.test($('#txtPass').val()) || !pattern2.test($('#txtPass').val()) || !pattern3.test($('#txtPass').val())) {
				$("#pw_box").text("비밀번호는 영문, 숫자 및 특수문자의 조합으로 생성해야 합니다");
				return;
			}else{
				if($('#txtPass').val().search(id) > -1) {
					$("#pw_box").text("비밀번호에 아이디가 포함되어 있습니다.");
					return false;
				}else{
					$("#pw_box").text("");
				}
			}
		}

		if ($('#txtPassChk').val().split(" ").join("") == "") {
			$("#pw_box2").text("비밀번호 확인을 입력해 주세요.");
			return;
		}

		if ($('#txtPass').val() != $('#txtPassChk').val()) {
			$("#pw_box2").text("비밀번호가 일치하지 않습니다.");
			return;
		} else {
			$("#pw_box").text("");
			$("#pw_box2").text("");
		}
		return chk;
	}
	/*비밀번호 체크 끝*/

	/*이메일 체크 시작*/
	function email_check( email ) {
		var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		return (email != '' && email != 'undefined' && regex.test(email));
	}

	// check when email input lost foucus
	function fn_checkMail() {
	  var email = $("#txtEmail").val();

	  // if value is empty then exit
	  if( email == '' || email == 'undefined') return;

	  // valid check
	  if(! email_check(email) ) {
		$("#mail_box").text("잘못된 이메일 형식입니다.");
		return false;
	  }
	  else {
		$("#mail_box").text("");
		return false;
	  }
	}
	/*이메일 체크 끝*/

	// 입력값 체크
	$(document).ready(function () {
		//$("#txtPass").val("");
		//$("#frm1")[0].reset();

		//아이디 중복 체크
		$("#txtId").bind("keyup keydown", function () {
			fn_checkID();
		});

		// 비번 유효성 체크
		$("#txtPass").bind("keyup keydown", function () {
			$(this).attr('type', 'password');
			fn_checkPW();
		});

		// 비번 재확인 유효성 체크
		$("#txtPassChk").bind("keyup keydown", function () {
			fn_checkPW();
		});

		// 이메일 주소 유효성 체크
		$("#txtEmail").bind("keyup keydown", function () {
			fn_checkMail();
		});
	});


	//군무원인 경우 선택시 입력폼 셋팅
	function FN_chk_military_personnel(obj) {
		var v_bool = $(obj).is(':checked');

		/*입력값 초기화-S*/
		$('#contents').find('input[id^="military"]').val('');
		$('#military_group option:eq(0)').attr('selected',true);
		$('[name="military_rank"]').attr('checked',false);

		selectboxFnc();
		radioboxFnc();
		/*입력값 초기화-E*/

		if(v_bool) {
			$('#military_personnel').attr('style','display:block;');
			$('#military').attr('style','display:none;');
		}
		else {
			$('#military_personnel').attr('style','display:none;');
			$('#military').attr('style','display:block;');
		}
	}
</script>
</head>

<body>
	<!-- header -->
	<div id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="/">이전</a>
				<p>회원가입</p>
			</div>

		</div>
	</div>
	<!-- //header -->

	<!-- container -->
	<div id="contents" class="sub_page">
		<div class="contents">
			<form method="post" name="frm1" autocomplete="off">
				<input type="hidden" name="id_check" id="id_check" value="" /><!-- 아이디 검증 여부(0/1) -->
				<input type="hidden" name="chk_id" id="chk_id" value=""><!-- 사용(입력) 아이디 -->
				<input type="hidden" name="hd_idx" id="hd_idx" value="" /><!-- 번호인증 idx -->
				<input type="hidden" name="mobileAuthNumChk" id="mobileAuthNumChk" value="0" />
				<input type="hidden" name="hd_kind" id="hd_kind" value="2" />
				<input type="hidden" name="authproc" id="authproc" value="" />

				<div class="signup_area">
					<div class="inputArea">
						<h4>회원정보 입력 <span class="req">(필수입력)</span></h4>
						<div class="tb_area">
							<table class="tb">
								<colgroup>
									<col style="width:8.5rem"/>
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th class="req">아이디</th>
										<td>
											<div class="inp">
												<input type="text" id="txtId" name="txtId" class="txt placehd" placeholder="아이디 (5~12자 영문, 숫자 입력)" autocomplete="off" maxlength="12">
												<p class="txt" id="id_box"></p>
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">비밀번호</th>
										<td>
											<div class="inp">
												<input type="password" id="txtPass" name="txtPass" class="txt placehd" maxlength="32" placeholder="비밀번호 (8~32자 영문, 숫자, 특수문자 입력)" autocomplete="new-password">
												<p class="txt" id="pw_box"></p>
												<input type="password" id="txtPassChk" name="txtPassChk" class="txt placehd" placeholder="비밀번호 확인" autocomplete="new-password">
												<p class="txt" id="pw_box2"></p>
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">이름</th>
										<td>
											<div class="inp">
												<input type="text" id="txtName" name="txtName" class="txt placehd" maxlength="10" placeholder="이름 (실명입력)" autocomplete="off">
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">생년월일</th>
										<td>
											<div class="inp">
												<input type="text" id="txtBirth" name="txtBirth" class="txt placehd" maxlength="8" placeholder="생년월일(YYYYMMDD)" autocomplete="off">
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">성별</th>
										<td>
											<div class="rdi_box">
												<label class="radiobox">
													<input class="rdi" name="gender" value="1" type="radio" style="width:auto; margin-right:5px;"><span>남자</span>
												</label>
												<label class="radiobox">
													<input class="rdi" name="gender" value="2" type="radio" style="width:auto; margin-right:5px;"><span>여자</span>
												</label>
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">최종학력</th>
										<td>
											<div class="birth">
												<span class="selectbox" style="width:100%;">
													<span style="font-size:1rem; padding:0 0 0 0.5rem">최종학력</span>
													<select id="sel_finalSchType" name="sel_finalSchType" title="최종학력">
														<option value="">최종학력</option>
														<option value="1">고졸</option>
														<option value="2">초대졸</option>
														<option value="3">대졸</option>
														<option value="4">대재</option>
														<option value="5">대학원졸</option>														
													</select>
												</span><!-- .selectbox -->
											</div><!-- .birth -->
										</td>
									</tr>
									<tr>
										<th class="req">이메일</th>
										<td>
											<div class="inp">
												<input type="text" id="txtEmail" name="txtEmail" class="txt placehd" maxlength="100" placeholder="이메일 주소 입력" autocomplete="off">
												<p class="txt" id="mail_box"></p>
											</div>
										</td>
									</tr>
									<tr>
										<th class="req">휴대폰 번호</th>
										<td>
											<div class="inp btn2">
												<div class="sec">
													<input type="text" id="txtPhone" name="txtPhone" class="txt placehd" maxlength="13" placeholder="휴대폰 번호 입력" style="width:65%; padding:0;">
													<span class="num" id="timeCntdown" style="display:none;">(2:59)</span>
													<button type="button" id="aMobile" class="btn" onclick="fn_chkJoin(); return false;">인증번호 전송</button>
													<p class="txt" id="phone_box"></p>
												</div>
												<div id="rsltAuthArea" class="sec" style="display:none;">
													<input type="text" id="mobileAuthNumber" name="mobileAuthNumber" class="txt placehd" maxlength="6" placeholder="인증번호를 입력해 주세요" onkeyup="removeChar(event)" onkeydown="return onlyNumber(event)">
													<button type="button" class="btn blue" onclick="fnAuthNoChk(); return false;">확인</button>
													<p class="txt" id="rsltMsg1" style="display:none;">인증번호가 정상 입력 됐습니다.</p>
													<p class="txt" id="rsltMsg2" style="display:none;">인증번호가 틀립니다.</p>
												</div>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
							
							<label class="checkbox off checkbox1" for="chk_military_personnel">
								<input type="checkbox" id="chk_military_personnel" name="chk_military_personnel" class="chk" onclick="FN_chk_military_personnel(this);">
								<span>군무원인 경우 선택</span>
							</label>

							<!--군무원 선택-S-->
							<div id="military_personnel" style="display:none;">
								<h4>군무원 기타사항 입력 <span class="req">(필수입력)</span></h4>
								<table class="tb">
									<colgroup>
										<col style="width:8.5rem"/>
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th class="req">소속부대명</th>
											<td>
												<div class="inp">
													<input type="text" class="txt placehd" id="military_personnel_corps" name="military_personnel_corps" placeholder="소속부대명" maxlength="100" style="width:100%;">
												</div>
											</td>
										</tr>

										<tr>
											<th class="req">순번</th>
											<td>
												<div class="inp">
													<input type="text" class="txt placehd" id="military_personnel_number" name="military_personnel_number" placeholder="순번을 입력해 주세요" maxlength="6" onkeyup="removeChar(event)" onkeydown="return onlyNumber(event)">
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
							<!--군무원 선택-E-->

							<!--군무원 선택이 아닐때-S-->
							<div id="military">
								<h4>군 사항 입력 <span class="req">(필수입력)</span></h4>
								<table class="tb">
									<colgroup>
										<col style="width:8.5rem;"/>
										<col/>
									</colgroup>

									<tbody>
										<tr>
											<th class="req"><span style="">군별선택</span></th>
											<td>
												<div class="birth" id="birth">
													<span class="selectbox" style="width:100%;">
														<span style="font-size:1rem; padding:0 0 0 0.5rem">군별</span>
														<select id="military_group" name="military_group" title="군별 선택">
															<option value="">군별선택</option>
															<option value="1">육군</option>
															<option value="2">해군</option>
															<option value="3">공군</option>
															<option value="4">해병대</option>
														</select>
													</span><!-- .selectbox -->
												</div><!-- .birth -->
											</td>
										</tr>
										<tr>
											<th class="req">소속부대명</th>
											<td>
												<div class="inp">
													<input type="text" class="txt placehd" id="military_corps" name="military_corps" placeholder="소속부대명" maxlength="100">
												</div>
											</td>
										</tr>
									</tbody>
								</table>

								<div class="sch_area">
									<h4>계급 및 직책선택</h4>
									<table class="tb">
										<caption>계급 및 직책선택</caption>
										<colgroup>
											<col style="width:8.5rem;" />
											<col />
										</colgroup>

										<tbody>
											<tr>
												<th class="th2 th2"><strong>병 사</strong></th>
												<td class="td2 td2">
													<div class="rdi_box">
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="1" type="radio"><span>이병</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="2" type="radio"><span>일병</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="3" type="radio"><span>상병</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="4" type="radio"><span>병장</span>
														</label>
													</div>
												</td>
											</tr>
											<tr>
												<th class="th3"><strong>간 부</strong></th>
												<td class="td3">
													<div class="rdi_box">
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="5" type="radio"><span>하사</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="6" type="radio"><span>중사</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="7" type="radio"><span>상사</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="8" type="radio"><span>원사</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="9" type="radio"><span>준위</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="10" type="radio"><span>소위</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="11" type="radio"><span>중위</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="12" type="radio"><span>대사</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="13" type="radio"><span>소령</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="14" type="radio"><span>중령</span>
														</label>
														<label class="radiobox">
															<input class="rdi" name="military_rank" value="15" type="radio"><span>대령</span>
														</label>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div><!-- sch_area -->

								<div class="sch_area">
									<table class="tb">
										<caption>군변,전역일입력 테이블</caption>
										<colgroup>
											<col style="width:8.5rem" />
											<col />
										</colgroup>

										<tbody>
											<tr>
												<th class="req">군번</th>
												<td>
													<div class="inp">
														<input type="text" class="txt placehd" id="military_number" name="military_number" placeholder="군번을 입력해 주세요" onkeyup="removeChar(event)" onkeydown="return onlyNumber(event)">
													</div>
												</td>
											</tr>
											<tr>
												<th class="req"><span>전역일</span></th>
												<td>
													<div class="datePick">
														<span>
															<input type="text" style="width:80%;" class="datepicker" id="military_end_date" name="military_end_date" placeholder="전역일을 선택해 주세요" readonly>
															<button type="button" class="btncalendar dateclick">전역일입력</button>
														</span>
													</div>
												</td>
											</tr>
										</tbody>
									</table>
								</div><!-- sch_area -->
							</div>
							<!--군무원 선택이 아닐때-S-->

							<div class="privacy">
								<dl>
									<dt>개인정보 수집 및 이용동의</dt>
									<dd>
										<strong>개인정보 수집목적</strong> : <%=site_name%> 로그인 및 지원자 개인 식별, 지원의사 확인, 입사전형의 진행, 고지사항 전달, 입사 지원자와의 원활한 의사소통, 지원이력 확인<br>
										<strong>개인정보 수집항목</strong> : 이름, 이메일, 휴대폰 번호, 군별, 소속부대명, 계급, 군번, 전역예정일, 순번<br />
										<strong>개인정보 이용기간</strong> : 행사 기간<br>(사이트 오픈 후 부터 행사 종료시까지 - 서비스 제공에 관한 고객사와의 계약 이행을 완료하기 위해 회원의 이용정보를 보관할 필요가 있음)<br>
										<strong>개인정보 파기</strong> : 행사 종료 및 행사 사업보고 종료 보고 후 파기 (고객사 협의 필)<br />
										<p style="font-weight:bold; margin-top:10px;">	* 개인정보 수집 및 이용에 대해서는 거부할 수 있으며, 거부 시에는 박람회 사이트 이용이 불가합니다. </p>
									</dd>
								</dl>

								<!--동의 라디오 btn  -->
								<label class="radiobox" style="padding-right:1%">
									<input class="rdi" name="agreeCheck" value="1" type="radio"><span style="font-size:1.2rem;">동의합니다.</span>
								</label>
								<label class="radiobox">
									<input class="rdi" name="agreeCheck" value="2" type="radio"><span style="font-size:1.2rem;">동의하지 않습니다.</span>
								</label>
							</div>
						</div>
					</div>

					<div class="btnWrap" style="margin:30px 0 -20px 0;">
						<button class="btn_login" type="button" onclick="javascript:fn_sumbit();">
							<span>회원가입 하기</span>
						</button>
					</div>
				</div><!-- signup_area-->
			</form>
		</div><!-- contents -->
	</div><!-- contents -->
	<!-- //container -->

<!-- 하단 -->
<!--#include virtual = "/include/footer.asp"-->
<!-- 하단 -->

</body>
</html>
