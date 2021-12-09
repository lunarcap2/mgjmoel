<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<%
'Response.write "rid				: " & Request("rid")			& "<br>"
'Response.write "step			: " & Request("step")			& "<br>"
'Response.write "rtype			: " & Request("rtype")			& "<br>"
'Response.write "cflag			: " & Request("cflag")			& "<br>"
'Response.write "rsubGubun		: " & Request("rsubGubun")		& "<br>"
'Response.write "schoolGubun		: " & Request("schoolGubun")	& "<br>"
'Response.write "isBaseResume	: " & Request("isBaseResume")	& "<br>"
'Response.write "rGubun			: " & Request("rGubun")			& "<br>"
'Response.End

Dim rid				: rid			= Request("rid")
Dim stp				: stp			= Request("step")
Dim rtype			: rtype			= Request("rtype")
Dim cflag			: cflag			= Request("cflag")
Dim rsubGubun		: rsubGubun		= Request("rsubGubun")
Dim schoolGubun		: schoolGubun	= Request("schoolGubun")
Dim isBaseResume	: isBaseResume	= Request("isBaseResume")

Dim rsubGubun_txt
Select Case rsubGubun
	Case 1	rsubGubun_txt = "프로필"
	Case 2	rsubGubun_txt = "학력사항"
	Case 3	rsubGubun_txt = "경력사항"
	Case 4	rsubGubun_txt = "자기소개서"
	Case 5	rsubGubun_txt = "희망근무조건"
	Case 6	rsubGubun_txt = "인턴.대외활동"
	Case 7	rsubGubun_txt = "외국어"
	Case 8	rsubGubun_txt = "자격증"
	Case 9	rsubGubun_txt = "수상"
	Case 10 rsubGubun_txt = "교육"
	Case 11 rsubGubun_txt = "해외경험"
	Case 12 rsubGubun_txt = "포트폴리오"
	Case 13 rsubGubun_txt = "취업우대항목"
End Select
%>

<!--#include virtual = "/wwwconf/code/code_function.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_ac.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_jc.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_resume.asp"-->
<!--#include virtual = "/wwwconf/code/code_resume.asp"-->

<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/wwwconf/query_lib/user/ResumeInfo.asp"-->
<!--#include virtual = "/my/resume/comm/getResumeStepDBInfo.asp"-->

<!--이력서 데이터 셋팅-->
<!--#include virtual = "/my/resume/inc_resume_data_set.asp"-->

<script type="text/javascript">
	function fn_move(move, school) {
		var move_url	= './rsub_view.asp';
	
		if(move == '0') {
			move_url = './resume_regist.asp';
		}
		//등록페이지 이동
		else if(move == '1') {
			move_url = './rsub_regist.asp';
			
			//학력사항에서만 사용
			if(school != '') {				
				$('#schoolGubun').val(school);
			}
		}
		//경력사항>신입버튼 클릭했을때
		else {
			$('#rsubGubun').val('6');
		}

		$('#frm_resume').attr('action', move_url);
		$('#frm_resume').submit();
	}

	function fn_detail(school, _rsubItem, _rsub_seq_no) {
		$('#schoolGubun').val(school);
		$('#rsubItem').val(_rsubItem);
		$('#rsub_seq_no').val(_rsub_seq_no);
		$('#frm_resume').attr('action', './rsub_regist.asp');
		$('#frm_resume').submit();
	}
</script>
</head>

<body>
	<script>
		$(document).ready(function () {
			//$(this).include(true);
			$(this).customTags();
		});
	</script>

	<!-- header -->
	<div id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="javascript:;" onclick="fn_move('0', '');">이전</a>
				<p><%=rsubGubun_txt%></p>
			</div>
		</div>
	</div>
	<!-- //header -->

	<% If rsubGubun = "2" Then %>
		<!--#include virtual = "/my/resume/rsub_view/rsub_view_02_school.asp"-->
	<% ElseIf rsubGubun = "3" Then %>
		<!--#include virtual = "/my/resume/rsub_view/rsub_view_03_career.asp"-->
	<% ElseIf rsubGubun = "6" Then %>
		<!--#include virtual = "/my/resume/rsub_view/rsub_view_06_activity.asp"-->
	<% ElseIf rsubGubun = "7" Then %>
		<!--#include virtual = "/my/resume/rsub_view/rsub_view_07_language.asp"-->
	<% ElseIf rsubGubun = "8" Then %>
		<!--#include virtual = "/my/resume/rsub_view/rsub_view_08_license.asp"-->
	<% ElseIf rsubGubun = "9" Then %>
		<!--#include virtual = "/my/resume/rsub_view/rsub_view_09_awards.asp"-->
	<% ElseIf rsubGubun = "10" Then %>
		<!--#include virtual = "/my/resume/rsub_view/rsub_view_10_education.asp"-->
	<% ElseIf rsubGubun = "11" Then %>
		<!--#include virtual = "/my/resume/rsub_view/rsub_view_11_overseas.asp"-->
	<% ElseIf rsubGubun = "12" Then %>
		<!--#include virtual = "/my/resume/rsub_view/rsub_view_12_portfolio.asp"-->
	<% End If %>

	<!-- 하단 -->
	<!--#include virtual = "/include/footer.asp"-->
	<!-- //하단 -->
</body>

</html>

<form method="post" id="frm_resume" name="frm_resume" action="">
	<input type="hidden" id="rid" name="rid" value="<%=rid%>" />
	<input type="hidden" name="rtype" value="<%=rtype%>" />
	<input type="hidden" name="cflag" value="<%=cflag%>" />
	<input type="hidden" name="step" value="<%=stp%>" />
	<input type="hidden" name="rGubun" value="<%=rGubun%>" />
	<input type="hidden" name="resumeIsComplete" value="" />
	<input type="hidden" name="isBaseResume" value="<%=isBaseResume%>" />

	<input type="hidden" id="rsubGubun" name="rsubGubun" value="<%=rsubGubun%>" />
	<input type="hidden" id="schoolGubun" name="schoolGubun" value="" />
	<input type="hidden" id="rsubItem" name="rsubItem" value="" />
	<input type="hidden" id="rsub_seq_no" name="rsub_seq_no" value="" />
</form>