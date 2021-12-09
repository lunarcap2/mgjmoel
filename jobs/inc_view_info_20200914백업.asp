<%
	Dim date_cy, date_ly, date_bly
	date_cy		= year(date) -1
	date_ly		= date_cy -1
	date_bly	= date_ly -1

	Dim capital_cy, capital_ly, capital_bly '자본금
	Dim sales_cy, sales_ly, sales_bly '매출액
	Dim income_cy, income_ly, income_bly '당기순이익
	Dim ranking_cy, ranking_ly, ranking_bly '산업내순위
	capital_cy		= Ccur(arrNice_1(0, 0)) / 10
	capital_ly		= Ccur(arrNice_1(1, 0)) / 10
	capital_bly		= Ccur(arrNice_1(2, 0)) / 10
	sales_cy		= Ccur(arrNice_1(3, 0)) / 10
	sales_ly		= Ccur(arrNice_1(4, 0)) / 10
	sales_bly		= Ccur(arrNice_1(5, 0)) / 10
	income_cy		= Ccur(arrNice_1(6, 0)) / 10
	income_ly		= Ccur(arrNice_1(7, 0)) / 10
	income_bly		= Ccur(arrNice_1(8, 0)) / 10
	ranking_cy		= arrNice_1(12, 0)
	ranking_ly		= arrNice_1(13, 0)
	ranking_bly		= arrNice_1(14, 0)

	Dim capital_rate, sales_rate, income_rate
	If capital_ly <> 0 Then capital_rate = (capital_cy - capital_ly) / capital_ly * 100
	If sales_ly <> 0 Then sales_rate = (sales_cy - sales_ly) / sales_ly * 100
	If income_ly <> 0 Then income_rate = (income_cy - income_ly) / income_ly * 100

	capital_rate = FormatNumber(capital_rate, 2)
	sales_rate = FormatNumber(sales_rate, 2)
	income_rate = FormatNumber(income_rate, 2)
	
	Dim capital_updown, sales_updown, income_updown
	Select Case Sgn(capital_rate)
		Case 0	: capital_updown = "middle"
		Case 1	: capital_updown = "up"
		Case -1 : capital_updown = "down"
	End Select
	Select Case Sgn(sales_rate)
		Case 0	: sales_updown = "middle"
		Case 1	: sales_updown = "up"
		Case -1	: sales_updown = "down"
	End Select
	Select Case Sgn(income_rate)
		Case 0	: income_updown = "middle"
		Case 1	: income_updown = "up"
		Case -1	: income_updown = "down"
	End Select

	Dim bizGubun, bizIPO
	bizGubun = "일반기업"
	If IsArray(arrNice_7) Then
		If arrNice_7(2, 0) = "Y" Then bizGubun = "히든챔피언"
		If arrNice_7(1, 0) = "Y" Then bizGubun = "강소기업"
		If arrNice_7(0, 0) = "Y" Then bizGubun = "중견기업"

		Select Case arrNice_7(7, 0)
			Case "1" : bizGubun = "대기업"
			Case "2" : bizGubun = "공기업"
			Case "3" : bizGubun = "금융권"
		End Select
	Else 
		' 내부 관리자가 설정한 기업 분류가 없을 경우 신용평가기관 제공 기업 분류로 대체
		Select Case arrNice_0(13, 0)
			Case "1" bizGubun = "대기업"
			Case "2" bizGubun = "중소기업"
			Case "3" bizGubun = "중견기업"
			Case "4" bizGubun = "기타"
			Case "5" bizGubun = "보훈대상 중견기업"
		End Select
	End If

	' 주요사업내용(GoodsName, BizField) 값 등록 여부 체크
	Dim strGoodsName : strGoodsName = ""
	If Not isnull(arrNice_0(16, 0)) Then 
		strGoodsName = arrNice_0(16, 0)
	Else 
		If Not isnull(arrNice_0(24, 0)) Then 
			strGoodsName = arrNice_0(24, 0)
		Else 
			strGoodsName = "-"
		End If 
	End If 

	' 홈페이지 URL 경로 체크
	Dim strBizHomePage
	If arrNice_0(31, 0) <> "" Then 
		If InStr(arrNice_0(31, 0),"http") > 0 Then
			strBizHomePage	= arrNice_0(31, 0)
		Else
			strBizHomePage	= "http://"& arrNice_0(31, 0)
		End If
	End If
%>

<link rel="stylesheet" type="text/css" href="/css/billboard.css?<%=publishUpdateDt%>"/>
<script type="text/javascript" src="/js/billboard.js?<%=publishUpdateDt%>"></script>
<script type="text/javascript" src="/js/billboard.pkgd.min.js?<%=publishUpdateDt%>"></script>

<div class="tab_con">
	<div class="view_box">
		<div class="tit">
			<h4>기업개요</h4>
		</div><!-- .tit -->
		<div class="comp-info">
			<ul class="lst1">
				<li class="i-1">
					<p class="t1">매출액</p>
					<p class="t2">
						<strong><%=getCompanyMoney_strongText((Trim(sales_cy)))%></strong>
					</p>
				</li>
				<li class="i-2">
					<p class="t1">설립연도</p>
					<p class="t2">
						<strong><%=Left(arrNice_0(9, 0), 4)%></strong><span>년</span>
					</p>
				</li>
				<li class="i-3">
					<p class="t1">기업형태</p>
					<p class="t2">
						<strong><%=bizGubun%></strong>
						<span><%=getIPOCodeName(arrNice_0(11, 0))%></span>
					</p>
				</li>
				<li class="i-4">
					<p class="t1">임직원수</p>
					<p class="t2">
						<strong><%=FormatNumber(arrNice_0(14, 0), 0)%></strong><span>명</span>
					</p>
				</li>
			</ul>
			<ul class="lst2">
				<li>
					<strong>기업명</strong>
					<span><%=arrNice_0(3, 0)%></span>
				</li>
				<li>
					<strong>대표자</strong>
					<span><%=arrNice_0(5, 0)%></span>
				</li>
				<li>
					<strong>주요사업</strong>
					<span><%=strGoodsName%></span>
				</li>
				<li>
					<strong>회사위치</strong>
					<span><%=arrNice_0(18, 0)%></span>
				</li>
				<li class="homepage">
					<strong>홈페이지</strong>
					<span><a href="<%=strBizHomePage%>"><%=arrNice_0(31, 0)%></a></span>
				</li>
			</ul>
		</div><!-- .comp-info -->
	</div><!--view_box -->
	
	<div class="view_box">
		<div class="tit">
			<h4>산업 내 순위</h4>
		</div><!-- .tit -->
		<div class="comp-rank">
			<div class="total">
				<p class="t1"><strong><%=arrNice_0(3, 0)%></strong> <span><%=ranking_cy%></span>위</p>
				<p class="t2"><strong><%=getCompanyMoney_strongText((Trim(sales_cy)))%></strong> (<span><%=date_cy%></span>년 기준)</p>
			</div>
			<table cellspacing="0" cellpadding="0">
				<colgroup>
					<col width="20%">
					<col width="50%">
					<col width="30%">
				</colgroup>
				<thead>
					<tr>
						<th>순위</th>
						<th>기업명</th>
						<th>매출액</th>
					</tr>
				</thead>
				<tbody>
					<% 
						If isArray(arrNice_5) Then
							For i=0 To UBound(arrNice_5,2)
					%>
					<tr>
						<td class="t1"><%=arrNice_5(1,i)%>위</td>
						<td class="t2"><%=arrNice_5(4,i)%></td>
						<td class="t3"><%=getCompanyMoney_strongText((Trim(Ccur(arrNice_5(10, i)) / 10)))%></td>
					</tr>
					<%	
							Next
						End If 
					%>
				</tbody>
			</table>
		</div>
	</div><!--view_box -->

	<div class="view_box">
		<div class="tit">
			<h4>재무분석</h4>
		</div><!-- .tit -->
		<div class="ca_chart">
			<ul>
				<li>
					<div class="chart_box">
						<h5>자본금</h5>
						<div class="chart_txt">
							<dl>
								<dt><%=date_cy%>년 자본금</dt>
								<dd><%=getCompanyMoney_Text(capital_cy)%></dd>
							</dl>
							<dl>
								<dt>작년대비</dt>
								<dd><span class="<%=capital_updown%>"><%=capital_rate%>%</span></dd>
							</dl>
						</div>
					</div>
				</li>
				<li>
					<div class="chart_box">
						<h5>매출액</h5>
						<div class="chart_txt">
							<dl>
								<dt><%=date_cy%>년 매출액</dt>
								<dd><%=getCompanyMoney_Text(sales_cy)%></dd>
							</dl>
							<dl>
								<dt>작년대비</dt>
								<dd><span class="<%=sales_updown%>"><%=sales_rate%>%</span></dd>
							</dl>
						</div>
					</div>
				</li>
				<li>
					<div class="chart_box">
						<h5>당기순이익</h5>
						<div class="chart_txt">
							<dl>
								<dt><%=date_cy%>년 매출액</dt>
								<dd><%=getCompanyMoney_Text(income_cy)%></dd>
							</dl>
							<dl>
								<dt>작년대비</dt>
								<dd><span class="<%=income_updown%>"><%=income_rate%>%</span></dd>
							</dl>
						</div>
					</div>
				</li>
			</ul>
		</div><!--ca_chart -->
	</div><!--view_box -->
	
	<% If isArray(arrKangso_option23) Then %>
	<div class="view_box">
		<div class="tit">
			<h4>복리후생</h4>
		</div><!-- .tit -->
		<div class="welfare-area">

			<%
				Dim ww, wf_view
				Dim wf_list : wf_list = Array( Array("wf01","수당제도", "13"), Array("wf02","보상&middot;포상 제도", "14"), Array("wf03","사내시설 제공", "16"), Array("wf04","생활&middot;근무편의 제공", "18"), Array("wf05","휴가&middot;휴무", "12"), Array("wf06","교육&middot;연수", "19"), Array("wf07","회사행사", "15"), Array("wf08","개인지급품", "20"), Array("wf09","연금보험", "11"), Array("wf10","장애인시설", "17"), Array("wf02","지원제도", "21")  )
			%>
			<ul>
				<% For ww = 0 To ubound(wf_list)
					wf_view = ""
					Dim ii
					If isArray(arrKangso_option23) Then '복리후생 선택

						For ii = 0 To UBound(arrKangso_option23,2)
							If Left(Trim(arrKangso_option23(1, ii)),2) = wf_list(ww)(2) Then
								wf_view = wf_view & arrKangso_option23(2, ii) & ", "
							End If
						Next

					End If

					If Len(wf_view) > 0 Then
					wf_view = Mid(wf_view, 1, Len(wf_view)-2)
				%>
				<li class="<%=wf_list(ww)(0)%>">
					<em>icon</em>
					<p>
						<strong><%=wf_list(ww)(1)%></strong>
						<span><%=wf_view%></span>
					</p>
				</li>
				<%
					End If
				next 
				%>
				
				<% If isArray(arrKangso_option22) Then '복리후생 직접 %>
				<li class="last">
				<div>
					<p>
						<strong>Plus 복리후생</strong>
						<span>
						<% For ii = 0 To UBound(arrKangso_option22,2) %>
							<%=arrKangso_option22(2,ii)%><% If UBound(arrKangso_option22,2) > ii then %><br><% End if %>
						<% next %>
						</span>
					</p>
				</div>
				</li>
				<% End If %>

			</ul>
		</div><!-- welfare-area -->
	</div><!--view_box -->
	<% End If %>

	<% If isArray(arrRsJobsIng) Then %>
	<div class="view_box" id="div_ing_job">
		<div class="tit">
			<h4>진행중 채용공고</h4>
		</div><!-- .tit -->
		<div class="recruit_wrap">
			<%
			For i=0 To UBound(arrRsJobsIng, 2)

			Dim rs_apply_start_date, rs_apply_end_date, rs_apply_selected, rs_applyUrl
			rs_apply_start_date = Replace(Left(arrRsJobsIng(10, i), 10), "-", "/") '접수시작일
			If arrRsJobsIng(12, i) <> "" Then rs_apply_end_date = Replace(Left(arrRsJobsIng(12, i), 10), "-", "/") '접수마감일
			rs_apply_selected = arrRsJobsIng(13, i)	'접수방법
			rs_apply_selected = split(rs_apply_selected, ",")
			rs_applyUrl = arrRsJobsIng(14, i)	'사이트접수URL
			If InStr(rs_applyUrl, "http") = 0 Then rs_applyUrl = "http://" & rs_applyUrl
			
			Dim str_end_date
			Select Case arrRsJobsIng(11, i) '접수마감종류
				Case "1" : str_end_date = Right(rs_apply_end_date, 5) & "(" & getWeekDay(weekDay(rs_apply_end_date)) & ")"
				Case "2" : str_end_date = "채용시 마감"
				Case "3" : str_end_date = "상시채용"
			End Select

			'스크랩
			Dim arrRsScrap, chk_scrap
			chk_scrap = ""
			If user_id <> "" Then
				ConnectDB DBCon, Application("DBInfo_FAIR")
				'스크랩 여부 
				 arrRsScrap = arrGetRsSql(DBCon,"SELECT 개인아이디 FROM 스크랩채용정보 WITH(NOLOCK)  WHERE 개인아이디 = '" & user_id & "' AND 삭제여부 = '0' and 채용정보등록번호 = '" &  arrRsJobsIng(0, i) & "'", "", "")
				if isArray(arrRsScrap) Then chk_scrap = "on"
				DisconnectDB DBCon
			End If
			%>
			<dl>
				<dd>
					<a href="/jobs/view.asp?id_num=<%=arrRsJobsIng(0, i)%>"><%=arrRsJobsIng(3, i)%></a>
					<a href="javascript:" class="scrap <%=chk_scrap%>" onclick="fn_scrap('<%=g_LoginChk%>', '<%=arrRsJobsIng(0, i)%>', this); return false;"><span>스크랩</span></a>
					<div class="recruit_info">
						<span><%=str_end_date%></span>
						<span><%=getExp(arrRsJobsIng(5, i))%></span>
						<span><%=getSchool3(arrRsJobsIng(4, i))%></span>
						<span><%=getAcName(arrRsJobsIng(6, i))%> &gt; <%=getAcName(arrRsJobsIng(7, i))%></span>
					</div>
					<% If rs_apply_selected(5) = "1" Then %>
					<a href="<%=rs_applyUrl%>" class="btn blue" target="_blank">홈페이지 지원</a>
					<% Else %>
					<a href="/jobs/view.asp?id_num=<%=arrRsJobsIng(0, i)%>" class="btn blue">온라인 지원</a>
					<% End If %>
				</dd>
			</dl>
			<% Next %>
		</div>
	</div>
	<% End If %>


</div>
