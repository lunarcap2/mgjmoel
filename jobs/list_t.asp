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
		Response.write "alert('2021년 1월4일에 메뉴가 오픈됩니다.');"
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
<!-- 상단 -->
<!--#include virtual = "/include/gnb/topMenu.asp"-->
<!-- //상단 -->

<div id="contents" class="sub_page">
	<div class="contents">
		<div class="visual_area hire">
			<h2>채용공고</h2>
		</div><!-- visual_area -->

		<form id="frm" name="frm" method="get">
		<input type="hidden" id="page" name="page" value="<%=page%>">
		<input type="hidden" id="so1" name="so1" value="<%=so1%>">
		<input type="hidden" id="so2" name="so2" value="<%=so2%>">
		<input type="hidden" id="so3" name="so3" value="<%=so3%>">
		<div class="list_area">
			<div class="list_info">
				<div class="left_box">
					<p>총 <span><%=totalPage%></span>건</p>
				</div>
				<div class="right_box">
					<span class="selectbox">
						<span class="">등록일순</span>
						<select id="sch_so" name="sch_so" title="등록일순 선택" selected="selected" onchange="fn_set_sort(this)">
							<option value="3">수정일순</option>
							<option value="1">등록일순</option>
							<option value="2">마감일순</option>
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
						rs_company_id		= ArrRs(1,i)	' 등록번호
						rs_company_name		= ArrRs(2,i)	' 회사명
						rs_jc1				= ArrRs(3,i)	' 직무1
						rs_jc2				= ArrRs(4,i)	' 직무2
						rs_area1			= ArrRs(5,i)	' 지역1
						rs_area2			= ArrRs(6,i)	' 지역2
						rs_career			= ArrRs(7,i)	' 경력
						rs_career_Month		= ArrRs(8,i)	' 경력월수
						rs_school_over		= ArrRs(9,i)	' 학력
						rs_subject			= ArrRs(10,i)	' 모집내용제목
						rs_applyUrl			= ArrRs(11,i)	' URL
						rs_apply_end		= ArrRs(12,i)	' 접수마감종류
						rs_apply_end_date	= ArrRs(13,i)	' 접수마감일
						rs_modify_date		= ArrRs(14,i)	' 등록일

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
							접수마감
							<%End if%>
							</span>
							<span><%=rs_career%><%=rs_career_Month%>↑</span>
							<span><%=rs_school_over%></span>
							<span><%=rs_area1%> &gt; <%=rs_area2%></span>
						</div>
					</dd>
				</dl>
				<%
					Next
				Else
				%>
				<dl>검색결과가 없습니다.</dl>
				<%
				End If
				%>

				<!--페이징-->
				<% Call putPage(Page, stropt, totalPage) %>
			</div><!--recruit_wrap -->

		</div><!-- list_area -->

		<!--
		<div class="pc_btn">
			<a href="<%=g_partner_wk%>/jobs/list.asp">PC버전보기</a>
		</div>
		-->
	</div><!--contents -->
	</form>
</div>

<!-- 하단 -->
<!--#include virtual = "/include/footer.asp"-->
<!-- 하단 -->

</body>
</html>
