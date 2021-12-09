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
Dim ii

Dim jobs_gubun : jobs_gubun = request("jobs_gubun")
Dim jc1 : jc1 = request("jc1")

so3 = ""
so4 = ""

ConnectDB DBCon, Application("DBInfo_FAIR")

	ArrRs1 = getListInfo_busan(DBcon)

	Tcnt = ArrRs1(0)
	pageCount = ArrRs1(1)
	ArrRs = ArrRs1(2)
	totalpage = pageCount

DisconnectDB DBCon


Function getListInfo_busan(DBcon)
Dim getListInfoParam(63)

	'Response.write "EXEC 채용정보_상세검색_리스트 '"&sqlgb1&"','"&sqlgb2&"','"&schkind1 &"','"&schkind2 &"','"& jc &"','"&jc2&"','"&ac &"','"&ac2&"','"&ck&"','"&wc&"','"&kw&"','"&sc&"','"&ec&"','"&ec1&"','"&ec2&"','"&sa&"','"&st&"','"&sx&"','"&wf&"','"&sb&"','"&sw_a&"','"&sw_l&"','"&la_1&"','"&la&"','"&la_tx&"','"&ct&"','"&cf&"','"&so1&"','"&so2&"','"&so3&"','"&so4&"','"&so_dasc&"','"&listType&"','"&isTopPost&"','"&Staff&"','"&classlevel&"','"&duty&"','"&special&"','"&age&"','"&noage&"','"&majorcode&"','"&pcuse&"','"&commonsp&"','"&s_date1&"','"&s_date2&"','"&edate&"','" & jobstorychk1 & "','" & jobstorychk2 & "','" & jobstorychk3 & "','" & jobstorychk4 & "', '"&comiso1&"','"&comiso2&"','"&comiso3&"','"&comiso4&"', '"& bc &"', '"& bc2 &"', '"&WorkDay &"', '"&page&"','"&PageSize&"','','','"& jobs_gubun &"', '"& jc1 &"', '"& jobs_gubun2 &"' "
	'response.end

	getListInfoParam(0) =  makeparam("@sqldb1",adVarChar,adParamInput,30,sqlgb1)
	getListInfoParam(1) = makeparam("@sqldb2",adVarChar,adParamInput,30,sqlgb2)
	getListInfoParam(2) = makeparam("@schkind1",adVarChar,adParamInput,1,schkind1)
	getListInfoParam(3) = makeparam("@schkind2",adVarChar,adParamInput,1,schkind2)
	getListInfoParam(4) = makeparam("@jc",adVarChar,adParamInput,1000,jc)
	getListInfoParam(5) = makeparam("@jc2",adVarChar,adParamInput,1000,jc2)
	getListInfoParam(6) = makeparam("@ac",adVarChar,adParamInput,180,ac)
	getListInfoParam(7) = makeparam("@ac2",adVarChar,adParamInput,200,ac2)
	getListInfoParam(8) = makeparam("@ck",adVarChar,adParamInput,40,ck)
	getListInfoParam(9) = makeparam("@wc",adVarChar,adParamInput,50,wc)
	getListInfoParam(10) = makeparam("@kw",adVarChar,adParamInput,100,kw)
	getListInfoParam(11) = makeparam("@sc",adVarChar,adParamInput,30,sc)
	getListInfoParam(12) = makeparam("@ec",adVarChar,adParamInput,10, ec)
	getListInfoParam(13) = makeparam("@ec1",adVarChar,adParamInput,4,ec1)
	getListInfoParam(14) = makeparam("@ec2",adVarChar,adParamInput,4,ec2)
	getListInfoParam(15) = makeparam("@sa",adVarChar,adParamInput,250,sa)
	getListInfoParam(16) = makeparam("@st",adVarChar,adParamInput,10,st)
	getListInfoParam(17) = makeparam("@sx",adVarChar,adParamInput,10,sx)
	getListInfoParam(18) = makeparam("@wf",adVarChar,adParamInput,600,wf)
	getListInfoParam(19) = makeparam("@sb",adVarChar,adParamInput,100, sb)
	getListInfoParam(20) = makeparam("@sw_a",adChar,adParamInput,2,sw_a)
	getListInfoParam(21) = makeparam("@sw_l",adChar,adParamInput,2,sw_l)
	getListInfoParam(22) = makeparam("@la_1",adVarChar,adParamInput,40,la_1)
	getListInfoParam(23) = makeparam("@la",adVarChar,adParamInput,2,la)
	getListInfoParam(24) = makeparam("@la_tx",adVarChar,adParamInput,4,la_tx)
	getListInfoParam(25) = makeparam("@ct",adVarChar,adParamInput,4,ct)
	getListInfoParam(26) = makeparam("@cf",adVarChar,adParamInput,25,cf)
	getListInfoParam(27) = makeparam("@so1",advarChar,adParamInput,1,so1)
	getListInfoParam(28) = makeparam("@so2",advarChar,adParamInput,1,so2)
	getListInfoParam(29) = makeparam("@so3",advarChar,adParamInput,1,so3)
	getListInfoParam(30) = makeparam("@so4",advarChar,adParamInput,1,so4)
	getListInfoParam(31) = makeparam("@so_dasc",adChar,adParamInput,4,so_dasc)
	getListInfoParam(32) = makeparam("@listType",adChar,adParamInput,1,listType)
	getListInfoParam(33) = makeparam("@isTopPost",adChar,adParamInput,1,isTopPost)
	getListInfoParam(34) = makeparam("@Staff",adChar,adParamInput,1,Staff)
	getListInfoParam(35) = makeparam("@classlevel",advarChar,adParamInput,30,classlevel)
	getListInfoParam(36) = makeparam("@duty",advarChar,adParamInput,30,duty)
	getListInfoParam(37) = makeparam("@special",advarChar,adParamInput,100,special)
	getListInfoParam(38) = makeparam("@age",advarchar,adParamInput,4,age)
	getListInfoParam(39) = makeparam("@noage",advarchar,adParamInput,1,noage)
	getListInfoParam(40) = makeparam("@majorcode",advarchar,adParamInput,100,majorcode)
	getListInfoParam(41) = makeparam("@pcuse",advarchar,adParamInput,100,pcuse)
	getListInfoParam(42) = makeparam("@commonsp",advarchar,adParamInput,100,commonsp)
	getListInfoParam(43) = makeparam("@sdate1",adChar,adParamInput,10,s_date1)
	getListInfoParam(44) = makeparam("@sdate2",adChar,adParamInput,10,s_date2)
	getListInfoParam(45) = makeparam("@edate",adChar,adParamInput,10,edate)
	getListInfoParam(46) = makeparam("@jobstorychk1",adChar,adParamInput,1,jobstorychk1)
	getListInfoParam(47) = makeparam("@jobstorychk2",adChar,adParamInput,1,jobstorychk2)
	getListInfoParam(48) = makeparam("@jobstorychk3",adChar,adParamInput,1,jobstorychk3)
	getListInfoParam(49) = makeparam("@jobstorychk4",adChar,adParamInput,1,jobstorychk4)
	getListInfoParam(50) = makeparam("@comiso1",adChar,adParamInput,1,comiso1)
	getListInfoParam(51) = makeparam("@comiso2",adChar,adParamInput,1,comiso2)
	getListInfoParam(52) = makeparam("@comiso3",adChar,adParamInput,1,comiso3)
	getListInfoParam(53) = makeparam("@comiso4",adChar,adParamInput,1,comiso4)

	getListInfoParam(54) = makeparam("@bc",adChar,adParamInput,100,bc)
	getListInfoParam(55) = makeparam("@bc2",adChar,adParamInput,100,bc2)
	getListInfoParam(56) = makeparam("@wkcode",adChar,adParamInput,100,WorkDay)

	getListInfoParam(57) = makeparam("@NowPage",adInteger,adParamInput,4,page)
	getListInfoParam(58) = makeparam("@PageSize",adInteger,adParamInput,4,pagesize)
	getListInfoParam(59) = makeparam("@TotalCnt",adInteger,adParamOutput,4,"")
	getListInfoParam(60) = makeparam("@TotalPage",adInteger,adParamOutput,4,"")

	getListInfoParam(61) = makeparam("@gubun",advarchar,adParamInput,2,jobs_gubun) '채용관구분 신규 2020-10-08
	getListInfoParam(62) = makeparam("@jc1",advarchar,adParamInput,100,jc1) '직종코드 1차 신규 2020-10-19
	getListInfoParam(63) = makeparam("@gubun2",advarchar,adParamInput,100,jobs_gubun2) '2020-11-05 2차 채용관구분-디지털에서만 사용 (1: 콘텐츠 기획형/ 2: 빅데이터활용법/ 3: 기록물 정보화형/ 4: 기타형)

	Dim List(3)
	List(2) = arrGetRsSP(DBCon,"채용정보_상세검색_리스트",getListInfoParam,"","")
	List(0) = getParamOutputValue(getListInfoParam,"@TotalCnt")
	List(1) = getParamOutputValue(getListInfoParam,"@TotalPage")
	List(3) = sort
	getListInfo_busan = List

End Function
%>

<script type="text/javascript">
	$(document).ready(function () {
		var r_sch_so, r_psize

		r_sch_so = '<%=Request("sch_so")%>';
		r_psize = "<%=pagesize%>";

		if (r_sch_so != "") {
			$('#sch_so').val(r_sch_so);
		}

		$('#pagesize').val(r_psize);
	});

	function fn_set_sort(obj) {
		$('#so1').val("");
		$('#so2').val("");
		$('#so3').val("");

		if (obj.value == "2") {
			$('#so' + $(obj).val()).val("0");
		} else {
			$('#so' + $(obj).val()).val("1");
		}

		document.frm.submit();
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
					<p>총 <span><%=Tcnt%></span>건</p>
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

			<!--#include file = "./inc_list_joblist.asp"-->
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
