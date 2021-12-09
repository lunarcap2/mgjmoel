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

	arrRs1 = arrGetRsSP(dbCon, "USP_ä����_���»�_����Ʈ", Param, "", "")

	DisconnectDB DBCon

	sel_bizIPO = Replace(Replace(getIPOCodeName(arrRs1(12, 0)), "(", ""), ")", "")

	If arrRs1(11, 0) = "Y" Then sel_bizGubun = "����è�Ǿ�"
	If arrRs1(10, 0) = "Y" Then sel_bizGubun = "���ұ��"
	If arrRs1(9, 0) = "Y" Then sel_bizGubun = "�߰߱��"

	Select Case arrRs1(8, 0)
	Case "1" : sel_bizGubun = "����"
	Case "2" : sel_bizGubun = "�����"
	Case "3" : sel_bizGubun = "������"
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

	// ��¥ ����
	function fn_sel_day(obj) {
		var week = new Array('��', '��', 'ȭ', '��', '��', '��', '��');
		var sel_day = $(obj).val();

		if (sel_day != "") {
			if (sel_day <= getDateToString(new Date())) {
				alert("������ ������ ���� ��¥�� ������ �Ұ����մϴ�.");
				fn_interview_time_reset();
				fn_interview_time_disable();
				return false;
			}
			else if (week[new Date(sel_day).getDay()] == "��" || week[new Date(sel_day).getDay()] == "��") {
				alert("�ָ��� ��û�Ͻ� �� �����ϴ�.");
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
	
	// ��û�ϱ�
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
			alert("ä���� ��û ��¥�� �ð��� �ٽ� Ȯ���� �ּ���.");
			return;
		}		
		
		if (confirm(consult_day+" "+getInterviewTime(consult_time)+"�� ä���� ������ �����ϼ̽��ϴ�.\nä������ ��û�Ͻðڽ��ϱ�?")) {
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
				<a href="<%=strRefer%>">����</a>
				<p>ä�� ��� ����</p>
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
							<caption>ȸ�� ����</caption>
							<colgroup>
								<col style="width:7rem">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th>�����</th>
									<td><%=getCompanyMoney_Text(CCur(arrRs1(3, 0)))%>(<%=year(date)-1%>�� ����)</td>
								</tr>
								<tr>
									<th>�ֿ���</th>
									<td>
										<p class="txt">
											<%=arrRs1(4,0)%>
										</p>
									</td>
								</tr>
								<tr>
									<th>����</th>
									<td><%=arrRs1(5,0)%></td>
								</tr>
								<tr>
									<th>ä��ñ�</th>
									<td><%=arrRs1(6,0)%></td>
								</tr>
								<tr>
									<th>ä������</th>
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
						<span class="txt">��¥����</span>
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
						<a href="javascript:void(0)" onclick="fn_submit();" class="btn blue">��� ��û�ϱ�</a>
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
