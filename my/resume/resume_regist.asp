<% option Explicit %>

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<%
Call FN_LoginLimit("1")    '개인회원만 접근가능

Dim stp     : stp = 1					'이력서 단계
Dim rid     : rid = request("rid")		'이력서 등록번호 (rid가 있으며 수정)
Dim rtype   : rtype = "T"				'이력서 구분(T:중간저장, C:완료)
Dim cflag   : cflag = request("cflag")	'신입/경력 구분. 1/8 로 현재값과 동일

Dim isBaseResume						'기본이력서
Dim set_user_id							'다른 사용자의 이력서를 보기위한 사용자아이디(뷰에서만 사용)
Dim apply_resume						'입사지원 이력서 조회여부(기업회원 지원자관리 사용)
%>

<!--#include virtual = "/wwwconf/code/code_function.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_ac.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_jc.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_resume.asp"-->
<!--#include virtual = "/wwwconf/code/code_resume.asp"-->

<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/wwwconf/query_lib/user/ResumeInfo.asp"-->
<!--#include virtual = "/my/resume/comm/getResumeStepDBInfo.asp"-->

<%
Dim i, ii, seq
Dim comma : comma = ", "

'--작성중인 이력서 rid
Dim ing_rid : ing_rid = 0
Dim ing_rGubun
If IsArray(arrIngResume) Then
	ing_rid = arrIngResume(0,0)
	ing_rGubun = arrIngResume(1,0)
End If

'--이력서 신규등록 시 : 3개이상 등록 제한 > 10개로 변경
If rid = 0  Then
	If IsArray(arrIngResume) Then
		If iResumeCnt >= 10 And ing_rid = 0 Then
			ShowAlertMsg "이력서는 10개까지 등록이 가능합니다.", "location.replace('/my/resume_list.asp');", True
		ElseIf iResumeCnt >= 10 And ing_rid > 0 Then
			ShowAlertMsg "", "if(confirm('작성중인 이력서가 있습니다. 계속 작성하시겠습니까?')){location.replace('/my/resume/resume_regist.asp?rid="& ing_rid & "');}else{location.replace('/my/resume_list.asp');}", True
		ElseIf iResumeCnt < 10 And ing_rid > 0 Then
			ShowAlertMsg "", "if(confirm('작성중인 이력서가 있습니다. 계속 작성하시겠습니까?')){location.replace('/my/resume/resume_regist.asp?rid="& ing_rid &"');}else{location.replace('/my/resume_list.asp');}", True
		End If
	Else
		If iResumeCnt >= 10 And ing_rid = 0 Then
			ShowAlertMsg "이력서는 10개까지 등록이 가능합니다.", "location.replace('/my/resume_list.asp');", True
		ElseIf iResumeCnt >= 10 And ing_rid > 0 Then
			ShowAlertMsg "", "if(confirm('작성중인 이력서가 있습니다. 계속 작성하시겠습니까?')){location.replace('"& mydir &"/resume/resume_regist.asp?rid="& ing_rid & "');}else{location.replace('"& mydir &"');}", True
		ElseIf iResumeCnt < 10 And ing_rid > 0 Then
			ShowAlertMsg "", "if(confirm('작성중인 이력서가 있습니다. 계속 작성하시겠습니까?')){location.replace('"& mydir &"/resume/resume_regist.asp?rid="& ing_rid &"');}else{location.replace('"& mydir &"/resume/resume_reg_step1.asp?flag=1&cflag=" & cflag & "');}", True
		End If
	End if
End If

'기본이력서 값설정
If iResumeCnt = "0" Then isBaseResume = "1"
If rid <> 0 And IsArray(arrResume) Then isBaseResume = arrResume(1, 0)
%>

<!--이력서 데이터 셋팅-->
<!--#include virtual = "/my/resume/inc_resume_data_set.asp"-->

<script type="text/javascript">
	$(document).ready(function () {
		window.onpageshow = function(event) {
			if(event.persisted || (window.performance && window.performance.navigation.type == 2)) {
				location.reload();
			}
		}

		//$(this).include(true);
		$(this).customTags();


		$('li[id^="resume"]').hide();

		$('#resume2').show();	//학력
		$('#resume3').show();	//경력
		$('#resume4').show();	//자기소개서
		$('#resume5').show();	//희망근무조건

		var arrActivity		= '<%=isArray(arrActivity)%>';		//인턴.대외활동
		var arrLanguageUse	= '<%=isArray(arrLanguageUse)%>';	//외국어
		var arrLanguageExam	= '<%=isArray(arrLanguageExam)%>';	//외국어
		var arrLicense		= '<%=isArray(arrLicense)%>';		//자격증
		var arrPrize		= '<%=isArray(arrPrize)%>';			//수상
		var arrAcademy		= '<%=isArray(arrAcademy)%>';		//교육
		var arrAbroad		= '<%=isArray(arrAbroad)%>';		//해외경험
		var arrPortfolio	= '<%=isArray(arrPortfolio)%>'		//포트폴리오
		var arrPersonal		= '<%=isArray(arrPersonal)%>';		//취업우대항목
		var arrMilitary		= '<%=isArray(arrMilitary)%>';		//취업우대항목
		var arrEmpSupport	= '<%=isArray(arrEmpSupport)%>';	//취업우대항목

		var arrBase			= '<%=isArray(arrBase)%>';

		if($("#rid").val() != "0") {
			if(arrActivity != 'False') {
				$('#resume6').show();
				$('input[id="chk_resume6"]').prop('checked',true);
			}

			if(arrLanguageUse != 'False' || arrLanguageExam != "False") {
				$('#resume7').show();
				$('input[id="chk_resume7"]').prop('checked',true);
			}

			if(arrLicense != 'False') {
				$('#resume8').show();
				$('input[id="chk_resume8"]').prop('checked',true);
			}

			if(arrPrize != 'False') {
				$('#resume9').show();
				$('input[id="chk_resume9"]').prop('checked',true);
			}

			if(arrAcademy != 'False') {
				$('#resume10').show();
				$('input[id="chk_resume10"]').prop('checked',true);
			}

			if(arrAbroad != 'False') {
				$('#resume11').show();
				$('input[id="chk_resume11"]').prop('checked',true);
			}

			/*
			if(arrPortfolio != 'False') {
				$('#resume12').show();
				$('input[id="chk_resume12"]').prop('checked',true);
			}
			*/

			if(arrPersonal != 'False' || arrMilitary != 'False' || arrEmpSupport != 'False') {
				$('#resume13').show();
				$('input[id="chk_resume13"]').prop('checked',true);
			}
		}

		$('[name="chk_resume"]').each(function () {
			$(this).attr('onclick','fn_chk(this);');
			
			if('<%=rtype%>' == 'C' && this.checked == true) {
				$(this).attr('onclick','fn_del(\'\',\'\',\'' + $(this).val() + '\')');
			}
		});
	});

	//각 항목별 이동
	function fn_move(val) {
		var rid		= '<%=rid%>';
		var move_url = './rsub_view.asp';

		if(rid == 0 && val != '1') {
			fn_first();
			return;
		}

		if(val == '1' || val == '4' || val == '5' || val == '13') {
			var move_url = './rsub_regist.asp';
		}

		$('#rsubGubun').val(val);
		
		$('#frm_resume').attr('target', '_self');
		$('#frm_resume').attr('action', move_url);
		$('#frm_resume').submit();
	}

	//이력서항목추가
	function fn_chk(obj) {
		var chk_bool	= $(obj).is(":checked");
		var chk_val		= $(obj).val();

		if(chk_bool) {
			$('#resume' + chk_val).show();
		}
		else {
			$('#resume' + chk_val).hide();
		}
	}

	function fn_first() {
		alert('프로필을 먼저 등록해 주세요.');
		return;
	}
</script>

</head>
<body>
	<!-- header -->
	<div  id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="/my/resume_list.asp">이전</a>
				<p><%=p_headertit%></p>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- container -->
	<div id="contents" class="sub_page mmGray">
		<div class="contents">
			<!-- 이력서등록수정관련:S -->
			<div class="mmResumeWrap">
				<div class="mmProfileArea">
					<div class="mmProfileinner">
						<div class="mmProfileTitle">
							<div class="mmCmmInput">
								<div class="ip">
									<input type="text" value="<%=p_resumeTitle%>" readonly>
								</div>
							</div>
						</div>
						<div class="lt">
							<div class="mmThumb">
								<div class="mmThumbInner">
									<img src="<%=p_userPhotoURL%>" alt="">
								</div>
							</div>
							<a href="javascript:;" class="mmBtns white blue bold md MT15" onclick="fn_move('1');">프로필 등록</a>
						</div>
						<div class="rt">
							<div class="txts">
								<ul class="lst">
									<li class="tp">
										<span class="lb">이름</span>
										<div class="tt"><%=p_userName%>(<%=p_age%>)
											<!--
											<%
											If p_age <> "" And p_gender <> "" Then
											%>
											(<%=p_age%><%=comma%><%=p_gender%>)
											<% Else %>
											(<%=p_age%><%=p_gender%>)
											<% End If %>
											-->
										</div>
									</li>
									<li class="tp">
										<span class="lb">휴대폰</span>
										<div class="tt"><%=p_phone%></div>
									</li>
									<li class="tp">
										<span class="lb">이메일</span>
										<div class="tt"><%=p_email%></div>
									</li>
									<li class="tp">
										<span class="lb">주소</span>
										<div class="tt multiEllipsis"><%=p_address%></div>
									</li>
									<li class="tp">
										<span class="lb">간략소개</span>
										<div class="tt multiEllipsis"><%=p_selfIntro%></div>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="mmBtnsWrap TXTR">
						<% If rid <> 0 Then %>
						<a href="javascript:;" class="mmBtns white outline md bold" onclick="fn_resume_save_preview();">이력서 보기</a>
						<% End If %>
					</div>
				</div>
				<div class="mmLstArea">
					<ul class="mmlstUl">
						<!-- forEach : S
							- 학력사항, 경력사항, 자기소개서, 희망 근무조건 등등
						-->
						<%
						For i=2 To 13
							Dim item_val
							Select Case i
								Case 2	item_val = "학력사항&"		& final_school
								Case 3	item_val = "경력사항&"		& total_career
								Case 4	item_val = "자기소개서&"		& introduce_cnt
								Case 5	item_val = "희망근무조건&"		& desire_cnt
								Case 6	item_val = "인턴.대외활동&"	& lately_activity
								Case 7	item_val = "외국어&"			& kind_language
								Case 8	item_val = "자격증&"			& license_cnt
								Case 9	item_val = "수상&"			& awards_cnt
								Case 10 item_val = "교육&"			& education_cnt
								Case 11 item_val = "해외경험&"		& lately_overseas
								Case 12 item_val = "포트폴리오&"		& portfolio_cnt
								Case 13 item_val = "취업우대항목&"		& preferential_cnt
							End Select
						%>
						<% If i <> 12 Then %>
						<li class="mmLstTp" id="resume<%=i%>">
							<div class="inner">
								<a href="javascript:;" class="txts" onclick="fn_move('<%=i%>');">
									<span class="lb"><%=Split(item_val,"&")(0)%></span>
									<div class="tt mmColorActiun"><%=Split(item_val,"&")(1)%></div>
									<span class="icos arrowNext"></span>
								</a>
							</div>
						</li>
						<% End If %>
						<% Next %>
						<!-- forEach : E -->
					</ul>
				</div>
				<div class="resumAddArea MT60">
					<div class="innerWrap">
						<div class="mmTit">이력서 항목 추가</div>
						<div class="listArea MT20">
							<div class="mmRow allPadding">
								<!-- 이력서항목추가 forEach : S -->
								<%
								For i=6 To 13
									Dim add_item
									Select Case i
										Case 6	add_item = "인턴.대외활동"
										Case 7	add_item = "외국어"
										Case 8	add_item = "자격증"
										Case 9	add_item = "수상"
										Case 10	add_item = "교육"
										Case 11 add_item = "해외경험"
										Case 12 add_item = "포트폴리오"
										Case 13 add_item = "취업우대항목"
									End Select
								%>
								<% If i <> 12 Then %>
								<div class="mmCol6">
									<div class="mmCmmInput radiochk">
										<input type="checkbox" id="chk_resume<%=i%>" name="chk_resume" value="<%=i%>">
										<label for="chk_resume<%=i%>" class="lb FWB"><%=add_item%></label>
									</div>
								</div>
								<% End If %>
								<% Next %>
								<!-- 이력서항목추가 forEach : E -->
							</div>
						</div>
					</div>
				</div>

				<% If rtype <> "C" Then %>
				<div class="resumAddArea MT60">
					<div class="innerWrap">
						<div class="mmCmmLst indent indent13 MT15">
							<div class="cmmtp mmColorRed">* 등록버튼을 누르셔야 최종등록됩니다.</div>
						</div>
					</div>
					<div class="mmBtnsWrap TXTC MT60">
						<% If rid = "0" Then %>
						<a href="javascript:;" class="mmBtns navy" onclick="fn_first();">등록</a>
						<% Else %>
						<a href="javascript:;" class="mmBtns navy" onclick="fn_resume_save();">등록</a>
						<% End If %>
					</div>
				</div>
				<% End If %>
			</div>
			<!-- 이력서등록수정관련:S -->
		</div>
	</div>
	<!-- //container -->

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

	<input type="hidden" id="rsubGubun" name="rsubGubun" value="" />
	<input type="hidden" id="rsubItem" name="rsubItem" value="" />
	<input type="hidden" id="rsub_seq_no" name="rsub_seq_no" value="" />
</form>
