<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<!--#include virtual = "/inc/function/base_util.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->


<%
ConnectDB DBCon, Application("DBInfo_FAIR")

	Dim strRemoteAddr, strUserAgent
	Dim strSql, totalCnt, userChk, arrRs, firstRemoteAddr, educe_email


	strRemoteAddr	= Request.ServerVariables("REMOTE_ADDR")
	strUserAgent	= Request.ServerVariables("HTTP_USER_AGENT")

	'로그인
	If g_LoginChk = 0 Then
		Response.redirect "/my/login.asp"
		Response.end
	End If

' 내부 아이피 대역 최초 접속 여부 체크 구문 제외
If inside_yn <> "Y" Then 
	'최초접속
	strSql = "SELECT TOP 1 접속경로 FROM LOG_역량검사접속정보 WHERE 개인아이디 = '" & user_id & "' ORDER BY 등록일 ASC"
	arrRs = arrGetRsSql(DBCon, strSql, "", "")

	If isArray(arrRs) Then
		firstRemoteAddr = arrRs(0,0)

		If isItMobile(firstRemoteAddr) = False Then
			Response.write "<script type='text/javascript'>"
			Response.write "alert('" & user_name & "님의 최초접속은 PC입니다.\n PC로 접속하여 시험에 응하여 주시기 바랍니다.');"
			Response.write "location.href='/';"
			Response.write "</script>"
			Response.end
		End If
	Else
		'응시인원수
		strSql = "SELECT COUNT(DISTINCT 개인아이디) FROM LOG_역량검사접속정보 WHERE 개인아이디 NOT IN ('test4_wk', 'expotest_wk', '200310000261_wk')"
		totalCnt = arrGetRsSql(DBCon, strSql, "", "")(0,0)

		If totalCnt >= 180 Then
			Response.write "<script type='text/javascript'>"
			Response.write "alert('역량검사 응시인원이 마감되었습니다.\n감사합니다.');"
			Response.write "location.href='/';"
			Response.write "</script>"
			Response.end
		End If
	End If
End If 

	strSql = "SELECT 이메일주소 FROM AI역량검사_모바일_로그인계정_생성 WHERE 개인아이디= '" & user_id & "'"
	arrRs = arrGetRsSql(DBCon, strSql, "", "")

	If isArray(arrRs) Then
		educe_email = arrRs(0,0)
	End If

	'로그
	strSql = "INSERT INTO LOG_역량검사접속정보(개인아이디, 접속경로, 접속IP, 등록일) VALUES('" & user_id & "', '" & strUserAgent & "', '" & strRemoteAddr & "', GETDATE())"
	DBCon.Execute(strSql)

DisconnectDB DBCon
%>

<script type="text/javascript">
	$(document).ready(function () {
		// 이메일 주소 유효성 체크
		$("#id").bind("keyup keydown", function () {
			fn_checkMail();
		});

		// 비번 유효성 체크
		$("#pw").bind("keyup keydown", function () {
			fn_checkPW();
		});
	});

	/*이메일 체크 시작*/
	function email_check( email ) {    
		var regex=/([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		return (email != '' && email != 'undefined' && regex.test(email)); 
	}

	// check when email input lost foucus
	function fn_checkMail() {
	  var email = $("#id").val();

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

	/*비밀번호 체크 시작*/
	function fn_checkPW() {
		var chk = false;
		var id	= $("#id").val();

		if ($('#pw').val().length == 0 ) {
			return;
		}
		else {				
			var pattern1 = /[0-9]/;		// 숫자 
			var pattern2 = /[a-zA-Z]/;	// 문자 
			var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
								
			//if (!$('#txtPass').val().match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)) {
			//if (!$('#txtPass').val().match(/^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/)) {
			//if (!/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,25}$/.test($('#txtPass').val())) {
			if(!pattern1.test($('#pw').val()) || !pattern2.test($('#pw').val()) || !pattern3.test($('#pw').val())) {
				$("#pw_box").text("비밀번호는 영문, 숫자 및 특수문자의 조합으로 생성해야 합니다");
				return;
			}
			else{
				$("#pw_box").text("");
			}
		}

		return chk;
	}
	/*비밀번호 체크 끝*/

	function fn_submit() {
		if($('#id').val() == '') {
			alert('이메일주소를 입력해주세요.');
			return;
		}

		if($("#mail_box").text() != "") {
			alert('잘못된 이메일 형식입니다.');
			return;
		}

		if($('#pw').val() == '') {
			alert('비밀번호를 입력해주세요.');
			return;
		}

		if($("#pw_box").text() != "") {
			alert('비밀번호를 확인해 주세요.');
			return;
		}
		
		$('#hdn_id').val($('#id').val());
		$('#hdn_pw').val($('#pw').val());

		$('#frm').submit();
	}
</script>
</head>

<body>
<iframe id="procFrame" name="procFrame" style="position:absolute; top:0; left:0; width:0;height:0;border:0;" frameborder="0" src="about:blank"></iframe>

<form method="post" name="frm" id="frm" action="./login_check_T.asp">
	<input type="hidden" id="hdn_id" name="hdn_id" value="" />
	<input type="hidden" id="hdn_pw" name="hdn_pw" value="" />
</form>


<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<div class="consul_area">
			<div id="mentor_area_4" class="consul_moth ai_area1" style="display:block;">
				<dl class="what what1">
					<dt>Educe AI 역량검사_In FACE (모바일)<br>
						시작 전 계정준비</dt>
					<dd style="width:30%; text-align:center; margin:0 auto;"><img src="../images/inface1.png" alt="컨설팅신청"></dd>
					<% If isArray(arrRs) Then %>
					<dd>
						* 사용 이메일 : <%=educe_email%><br>
						* 검사시간 : 60분<br>
						* 앱 실행 시, 앱 상단 안내 문구에 따라<br>카메라 및 마이크 테스트를 진행해 주세요.
					</dd>
					<% Else %>
					<dd>
						AI역량검사를 모바일로 진행할 경우, In Face 앱 설치가 필요합니다.<br>
						생성하는 ID와 패스워드는 In FACE 앱 접속용으로만 사용됩니다.<br>
					</dd>
					<% End If %>
				</dl>
				
				<% If isArray(arrRs) Then %>
				<div class="step3">
					<div class="btn_area">
<%
' 모바일 OS에 따라 앱 스토어 연결 링크 제어 [2021-04-09]
Dim strUserAgentChk, strAppUrl
strUserAgentChk = UCase(request.ServerVariables("HTTP_USER_AGENT"))
If InStr(strUserAgentChk, "IPAD") Or InStr(strUserAgentChk, "IPHONE")  Then
	strAppUrl = "https://apps.apple.com/kr/app/inface-ai%EC%97%AD%EB%9F%89%EA%B2%80%EC%82%AC-ai%EB%A9%B4%EC%A0%91-%ED%94%8C%EB%9E%AB%ED%8F%BC-%EC%9D%B8%ED%8E%98%EC%9D%B4%EC%8A%A4/id1541126432"
Else 
	strAppUrl = "https://play.google.com/store/apps/details?id=kr.co.whitebox.educegame"
End If 
%>
						<a href="<%=strAppUrl%>" class="btn blue">AI역량검사 하러가기</a>
					</div>
				</div>
				<% End If %>
			</div>

			<div class="login1_content">
				<h2 class="blind">개인회원 로그인</h2>
				
				<div class="login1">
					<% If isArray(arrRs) = False Then %>
					<div class="inp">
						<input class="txt id" id="id" name="id" value="<%=wk_user_email%>" type="text" placeholder="In FACE앱에 접속할 계정(E-mail)을 입력해 주세요." autocomplete="off">
						<span class="txt" id="mail_box" style="color:red;margin:0 0 0;"></span>
						<input class="txt pw" id="pw" name="pw" type="password" maxlength="8" placeholder="비밀번호를 입력해 주세요.(최대 8자리)" autocomplete="new-password">
						<span class="txt" id="pw_box" style="color:red;margin:0 0 0;"></span>
					</div>

					<button class="btn_login" type="button" onclick="fn_submit();">
						<span>계정 생성하기</span>
					</button>

					<div class="consul_moth1" style="display:block;">
						<dl class="apply1">					
							<ul>
								<li>* 입력하신 ID/PW는 자유롭게 입력해 주세요.</li>
								<li>* 입력 후 계정생성 하기 버튼을 클릭하면  In FACE 앱에서 접속이 가능합니다.</li>
								<li>* AI 역량검사_In FACE는 계정당 1회 검사만 가능합니다.</li>
								<li>* 생성된 계정은 박람회 종료 후에도 In FACE 앱에서 검사결과 확인이 가능합니다.</li>
								<li>* 앱 실행 시, 앱의 설명대로 카메라, 마이크 테스트를 진행해 주세요.</li>
							</ul>					
						</dl>
					</div>
					<% End If %>

					
				</div>
			</div>
		</div>
	</div>
</div>
<!-- //container -->

</body>
</html>
