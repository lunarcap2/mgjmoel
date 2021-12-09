<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<!--#include virtual = "/wwwconf/code/code_function.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_ac.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_jc.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_ct.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_subway.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_license.asp"-->

<!--#include virtual = "/wwwconf/function/common/base_util.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/wwwconf/listparam/jobsSearchListParam.asp"-->
<!--#include virtual = "/wwwconf/query_lib/list/jobpostListInfo.asp"-->

<!--#include virtual = "/inc/function/paging.asp"-->
<%
	'2020.12.16
	If Left(Request.ServerVariables("REMOTE_ADDR"), 9) <> "211.54.63" And Dday < 0 Then
		Response.write "<script type='text/javascript'>"
		Response.write "alert('2021�� 1��4�Ͽ� �޴��� ���µ˴ϴ�.');"
		Response.write "location.href='/';"
		Response.write "</script>"
	End If

Dim strSql, ArrRs, ArrRs1
Dim Tcnt, totalpage

Dim gubun
Dim keyword	: keyword = request("kw")
Dim jobs_gubun : jobs_gubun = request("jobs_gubun")
Dim jobs_gubun2 : jobs_gubun2 = request("jobs_gubun2")

Dim sch_so		: sch_so	= request("sch_so")

If page = "" Then
	page = "1"
End If
If sch_so = "" Then
	sch_so = "1"
End if

ConnectDB DBCon, Application("DBInfo_FAIR")

	Dim Param(5)
	Param(0) = makeparam("@KW",			adVarChar, adParamInput, 200, keyword)
	Param(1) = makeparam("@OrderNum",	adInteger, adParamInput, 4, sch_so)
	Param(2) = makeparam("@Page",		adInteger, adParamInput, 4, page)
	Param(3) = makeparam("@PageSize",	adInteger, adParamInput, 4, pagesize)
	Param(4) = makeparam("@Gubun",		adVarChar, adParamInput, 3, gubun)
	Param(5) = makeparam("@TotalCnt",	adInteger, adParamOutput, 4, "")

	Dim arrayList(2)
	arrayList(0) = arrGetRsSP(DBcon,"USP_GJMOEL_JOBS_LIST",Param,"","")
	arrayList(1) = getParamOutputValue(Param,"@TotalCnt")

	ArrRs		= arrayList(0)
	totalPage	= arrayList(1)

	pageCount = Int(((totalPage-1) / pagesize) + 1)

DisconnectDB DBCon

stropt = "keyword="&keyword&""


%>

<script type="text/javascript">
	function fn_set_sort(obj) {
		$("#page").val('1');
		document.frm.submit();
	}

	function fn_set_pagesize(obj) {
		$('#page').val("1");
		document.frm.submit();
	}
	function fn_search() {
		$("#page").val('1');
		$('#kw').val($("[name=kw]").val());

		document.frm.submit();
	}
	function fn_reset() {
		$('#page').val("1");
		$("[name=kw]").val('');
		document.frm.submit();
	}
	function fn_worknet_view(seq,subject) {

		$.ajax({
			url: "ajax_worknet_view.asp",
			type: "POST",
			dataType: "html",
			data: ({
				"seq": seq,
				"subject": escape(subject)
			})
		});
	}
</script>

</head>

<body>
<!-- ��� -->
<!--#include virtual = "/include/gnb/topMenu.asp"-->
<!-- //��� -->

<div id="contents" class="sub_page">
	<div class="contents">
		<div class="visual_area hire">
			<h2>ä�����</h2>
		</div><!-- visual_area -->

		<form id="frm" name="frm" method="get">
		<input type="hidden" id="page" name="page" value="<%=page%>">
		<input type="hidden" id="so1" name="so1" value="<%=so1%>">
		<input type="hidden" id="so2" name="so2" value="<%=so2%>">
		<input type="hidden" id="so3" name="so3" value="<%=so3%>">
		<div class="list_area">
			<div class="list_info">
				<div class="left_box">
					<p>�� <span><%=totalPage%></span>��</p>
				</div>
				<div class="right_box">
					<span class="selectbox">
						<span class="">����ϼ�</span>
						<select id="sch_so" name="sch_so" title="����ϼ� ����" selected="selected" onchange="fn_set_sort(this)">
							<option value="3">�����ϼ�</option>
							<option value="1">����ϼ�</option>
							<option value="2">�����ϼ�</option>
						</select>
					</span>
				</div>
			</div>

			<div class="recruit_wrap">
				<%
				If isArray(ArrRs) Then
					For i = 0 To UBound(ArrRs, 2)
						Dim rs_id_num, rs_company_id, rs_company_name, rs_jc1, rs_jc2, rs_area1, rs_area2, rs_career, rs_career_Month, rs_school_over, rs_subject, rs_applyUrl, rs_apply_end, rs_apply_end_date, rs_modify_date
						Dim rs_apply_start_date	 : rs_apply_start_date = Now()

						rs_id_num			= ArrRs(0,i)	' RN
						rs_company_id		= ArrRs(1,i)	' ��Ϲ�ȣ
						rs_company_name		= ArrRs(2,i)	' ȸ���
						rs_jc1				= ArrRs(3,i)	' ����1
						rs_jc2				= ArrRs(4,i)	' ����2
						rs_area1			= ArrRs(5,i)	' ����1
						rs_area2			= ArrRs(6,i)	' ����2
						rs_career			= ArrRs(7,i)	' ���
						rs_career_Month		= ArrRs(8,i)	' ��¿���
						rs_school_over		= ArrRs(9,i)	' �з�
						rs_subject			= ArrRs(10,i)	' ������������
						rs_applyUrl			= ArrRs(11,i)	' URL
						rs_apply_end		= ArrRs(12,i)	' ������������
						rs_apply_end_date	= ArrRs(13,i)	' ����������
						rs_modify_date		= ArrRs(14,i)	' �����

				%>
				<dl>
					<dt><%=rs_company_name%></dt>
					<dd>
						<a href="<%=rs_applyUrl%>" onclick="javascript:fn_worknet_view('<%=rs_company_id%>','<%=rs_subject%>');" class="tiStx" target="_blank"><%=rs_subject%></a>
						<div class="recruit_info">
							<span>
							<%If rs_apply_end = "LIVE" then%>
							<%=rs_apply_end_date%>
							<%else%>
							��������
							<%End if%>
							</span>
							<span><%=rs_career%><%=rs_career_Month%>��</span>
							<span><%=rs_school_over%></span>
							<span><%=rs_area1%> &gt; <%=rs_area2%></span>
						</div>
					</dd>
				</dl>
				<%
					Next
				Else
				%>
				<dl>�˻������ �����ϴ�.</dl>
				<%
				End If
				%>

				<!--����¡-->
				<% Call putPage(Page, stropt, totalPage) %>
			</div><!--recruit_wrap -->

		</div><!-- list_area -->

		<!--
		<div class="pc_btn">
			<a href="<%=g_partner_wk%>/jobs/list.asp">PC��������</a>
		</div>
		-->
	</div><!--contents -->
	</form>
</div>

<!-- �ϴ� -->
<!--#include virtual = "/include/footer.asp"-->
<!-- �ϴ� -->

</body>
</html>
