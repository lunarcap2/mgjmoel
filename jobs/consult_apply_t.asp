<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<!--#include virtual = "/inc/function/code_function.asp"-->

<!--#include virtual = "/wwwconf/code/code_function.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	ConnectDB DBCon, Application("DBInfo_FAIR")

	Dim com_id, arrRs1
	com_id = request("cid")

	reDim Param(0)

	Param(0) = makeparam("@com_id",adVarChar,adParamInput,20,com_id)

	arrRs1 = arrGetRsSP(dbCon, "USP_채용상담_협력사_리스트", Param, "", "")

	DisconnectDB DBCon

	sel_bizIPO = Replace(Replace(getIPOCodeName(arrRs1(12, 0)), "(", ""), ")", "")

	If arrRs1(11, 0) = "Y" Then sel_bizGubun = "히든챔피언"
	If arrRs1(10, 0) = "Y" Then sel_bizGubun = "강소기업"
	If arrRs1(9, 0) = "Y" Then sel_bizGubun = "중견기업"

	Select Case arrRs1(8, 0)
	Case "1" : sel_bizGubun = "대기업"
	Case "2" : sel_bizGubun = "공기업"
	Case "3" : sel_bizGubun = "금융권"
	End Select
%>

<script type="text/javascript" src="/consulting/js/interview.js"></script>

<script type="text/javascript">
	$(document).ready(function () {
		var today = new Date();
		today.setDate(today.getDate() + 1)

		$('#set_interview_day').val(getDateToString(today));
		$("#sel_day").val(getDateToString(today));
		fn_chk_user_consult_time();
		fn_chk_com_consult_time();

		//fn_interview_time_reset();
		//fn_interview_time_disable();
	});

	// 날짜 선택
	function fn_sel_day(obj) {
		var week = new Array('일', '월', '화', '수', '목', '금', '토');
		var sel_day = $(obj).val();

		if (sel_day != "") {
			if (sel_day <= getDateToString(new Date())) {
				alert("오늘을 포함한 이전 날짜는 선택이 불가능합니다.");
				fn_interview_time_reset();
				fn_interview_time_disable();
				return false;
			}
			else if (week[new Date(sel_day).getDay()] == "토" || week[new Date(sel_day).getDay()] == "일") {
				alert("주말은 신청하실 수 없습니다.");
				fn_interview_time_reset();
				fn_interview_time_disable();
				return false;
			}
			else {
				$("#set_interview_day").val(sel_day);

				fn_consult_time_disable_reset();
				fn_interview_time_reset();
				fn_chk_com_consult_time();
				fn_chk_user_consult_time();
			}			
		}
		else {
			fn_interview_time_reset();
			fn_interview_time_disable();
			return false;
		}
	}
	
	// 신청하기
	function fn_submit() {
		var consult_id = $('#set_interview_id').val();
		var consult_day = $('#set_interview_day').val();
		var consult_time = "";

		$('input[name="set_interview_time"]').each(function() {
			if (this.checked == true) {				
				consult_time = this.value;
				$("#set_interview_time").val(this.value);
			}
		});

		console.log(consult_day);
		return;

		if (consult_day == "" || consult_time == "") {
			alert("채용상담 신청 날짜와 시간을 다시 확인해 주세요.");
			return;
		}		
		
		if (confirm(consult_day+" "+getInterviewTime(consult_time)+"로 채용상담 일정을 선택하셨습니다.\n채용상담을 신청하시겠습니까?")) {
			$('#frm').submit();
		}
	}
</script>

</head>

<body>
<!-- header -->
	<div  id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="<%=strRefer%>">이전</a>
				<p>채용 상담 예약</p>
			</div>
			</div>
		</div>
	</div>
	<!-- //header -->
	
	<!-- container -->
	<div id="contents" class="sub_page">
		<div class="contents detail">
			<!-- list_area -->
			<div class="consulting_area">
				<dl class="comp">
					<dt>
						<%=arrRs1(1,0)%>
						<div class="type">
							<% If sel_bizIPO <> "" Then %>
							<span class="blue"><%=sel_bizIPO%></span>
							<% End If %>
							<% If sel_bizGubun <> "" Then %>
							<span class="gray"><%=sel_bizGubun%></span>
							<% End If %>
						</div>
					</dt>
					<dd>
						<table>
							<caption>회사 정보</caption>
							<colgroup>
								<col style="width:7rem">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th>매출액</th>
									<td><%=getCompanyMoney_Text(CCur(arrRs1(3, 0)))%>(<%=year(date)-1%>년 기준)</td>
								</tr>
								<tr>
									<th>주요사업</th>
									<td>
										<p class="txt">
											<%=arrRs1(4,0)%>
										</p>
									</td>
								</tr>
								<tr>
									<th>지역</th>
									<td><%=arrRs1(5,0)%></td>
								</tr>
								<tr>
									<th>채용시기</th>
									<td><%=arrRs1(6,0)%></td>
								</tr>
								<tr>
									<th>채용직무</th>
									<td>
										<%=arrRs1(7,0)%>
									</td>
								</tr>
							</tbody>
						</table>
					</dd>
				</dl>

				<div class="consul_sel">
					<div class="date">
						<span class="txt">날짜선택</span>
						<span class="selectbox">
							<span class=""></span>
							<select class="" name="" id="sel_day" onchange="fn_sel_day(this);">
								<% 
									For i=0 To 18
										NowDate = CDate("2020-09-08") + i

										If weekDay(NowDate) <> "1" And weekDay(NowDate) <> "7" Then
								%>
								<option value="<%=NowDate%>"><%=NowDate%></option>
								<% 
										End If
									Next 
								%>
							</select>
						</span>
					</div>
					<div class="time_box">
						<ul class="t_ul">
							<% For i=1 To 6 %>
							<li>
								<label class="radiobox off" for="time1_<%=i%>">
									<input type="radio" class="rdi" id="time1_<%=i%>" name="set_interview_time" value="<%=i%>" onclick="fn_com_time_set(this);">
								</label>
								<span><%=getInterviewTime(i)%></span>
							</li>
							<% Next %>
						</ul>

						<ul class="t_ul">
							<% For i=7 To 16 %>
							<li>
								<label class="radiobox off" for="time1_<%=i%>">
									<input type="radio" class="rdi" id="time1_<%=i%>" name="set_interview_time" value="<%=i%>" onclick="fn_com_time_set(this);">
								</label>
								<span><%=getInterviewTime(i)%></span>
							</li>
							<% Next %>
						</ul>
					</div>
					<div class="btn_area">
						<a href="javascript:void(0)" onclick="fn_submit();" class="btn blue">상담 신청하기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- //container -->
</body>
</html>

<form id="frm" name="frm" method="post" action="./proc_consult_save.asp">
	<input type="hidden" id="set_interview_id" name="set_interview_id" value="<%=com_id%>">
	<input type="hidden" id="set_interview_day" name="set_interview_day" value="">
	<input type="hidden" id="set_interview_time" name="set_interview_time" value="">
</form>
