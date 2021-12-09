<%
	 Response.CharSet="euc-kr"
     Session.codepage="949"
     Response.codepage="949"
     Response.ContentType="text/html;charset=euc-kr"
%>

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
'Request 값
Dim id, pw
id = Request("hdn_id")
pw = Trim(Request("hdn_pw"))

'가공한 값
Dim set_pw
set_pw = EnCodeValue(pw)

ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim strSql

	strSql = "INSERT INTO AI역량검사_모바일_로그인계정_생성(개인아이디, 이메일주소, 비밀번호, 암호화_비밀번호)"
	strSql = strSql & " VALUES('" & user_id & "', '" & id & "', '" & pw & "', '" & set_pw & "')"
	DBCon.Execute(strSql)

DisconnectDB DBCon
%>

<form method="post" name="infaceForm" id="infaceForm" action="https://inface.ai/career" accept-charset="utf-8">
	<input type="hidden" name="SetupNo" value="103" />								<!-- 생성코드 (수정불가) -->
	<input type="hidden" name="UserID" value="<%=Replace(user_id,"_wk","")%>" />	<!-- 회원번호나 아이디등의 유니크 값 -->
	<input type="hidden" name="UserName" value="<%=user_name%>" />					<!-- 성명 -->
	<input type="hidden" name="UserEmail" value="<%=id%>" />						<!-- 이메일 -->
	<input type="hidden" name="ReturnUrl" value="1" />								<!-- 모바일이면 1넣어줌 -->
	<input type="hidden" name="UserPass" value="<%=set_pw%>" />						<!-- 비밀번호 -->
</form>

<script type="text/javascript">
	$(document).ready(function () {
		$('#infaceForm').submit();
	});
</script>