<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/wwwconf/code/code_function.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_ac.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_jc.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_resume.asp"-->
<!--#include virtual = "/wwwconf/code/code_resume.asp"-->
<!--#include virtual = "/wwwconf/query_lib/user/ResumeInfo.asp"-->
<%
	Call FN_LoginLimit("1")	'개인회원 허용

	Dim stp     : stp = 1					'이력서 단계
	Dim rid     : rid = request("rid")		'이력서 등록번호 (rid가 있으며 수정)
	Dim rtype   : rtype = "T"				'이력서 구분(T:중간저장, C:완료)
	Dim cflag   : cflag = request("cflag")	'신입/경력 구분. 1/8 로 현재값과 동일

	If rid = "" Or rid = "0" Then
		ShowAlertMsg "잘못된 접근입니다.", "history.back();", True
	End If

	Dim i, ii
%>
<!--#include virtual = "/my/resume/comm/getResumeStepDBInfo.asp"-->
<!--#include virtual = "/include/header/header.asp"-->
<script type="text/javascript">

</script>
</head>

<body>

<!-- header -->
<div  id="header">
	<div class="header-wrap detail">
		<div class="detail_box">
			<a href="javascript:window.close();" class="close">닫기</a>
			<p>지원서 보기</p>
		</div>
		</div>
	</div>
</div>
<!-- //header -->

<!-- 본문 -->
<!--#include file = "./comm/inc_resume_view.asp"-->
<!-- //본문 -->

<!-- 하단 -->
<!--#include virtual = "/include/footer.asp"-->
<!-- 하단 -->

</body>
</html>