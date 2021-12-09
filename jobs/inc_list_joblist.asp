<div class="recruit_wrap">
	<%
	If isArray(ArrRs) Then
		For i = 0 To UBound(ArrRs, 2)
		Dim rs_id_num, rs_company_id, rs_company_name, rs_company_name_code, rs_subject, rs_sex_code, rs_school_code, rs_career_code, rs_apply_start_date, rs_view_count, rs_apply_selected, rs_apply_end, rs_apply_end_date, rs_area_code, rs_career_month, rs_career_over, rs_jc_code, rs_item_option, rs_site_gubun, rs_ipo, rs_company_kind, rs_item_option2, rs_tct_flag, rs_position_group, rs_position_title, rs_workplace, rs_modify_date, rs_runmber, rs_register_gubun, rs_school_over, rs_work_type, rs_salary_code, rs_subway_code, rs_biz_code, rs_applyUrl

		rs_id_num				= ArrRs(0, i)	'등록번호
		rs_company_id			= ArrRs(1, i)	'회사아이디
		rs_company_name			= ArrRs(2, i)	'회사명
		rs_company_name_code	= ArrRs(3, i)	'회사명1
		rs_subject				= ArrRs(4, i)	'모집내용제목
		rs_sex_code				= ArrRs(5, i)	'성별
		rs_school_code			= ArrRs(6, i)	'학력코드
		rs_career_code			= ArrRs(7, i)	'경력코드
		rs_apply_start_date		= ArrRs(8, i)	'(null)접수시작일
		rs_view_count			= ArrRs(9, i)	'조회수
		rs_apply_selected		= ArrRs(10, i)	'접수방법
		rs_apply_selected = split(rs_apply_selected, ",")
		rs_apply_end			= ArrRs(11, i)	'접수마감종류
		rs_apply_end_date		= ArrRs(12, i)	'(null)접수마감일
		rs_area_code			= ArrRs(13, i)	'지역코드
		rs_career_month			= ArrRs(14, i)	'경력월수
		rs_career_over			= ArrRs(15, i)	'경력제한선
		rs_jc_code				= ArrRs(16, i)	'직종코드
		rs_item_option			= ArrRs(17, i)	'아이템옵션
		rs_site_gubun			= ArrRs(18, i)	'사이트구분
		rs_ipo					= ArrRs(19, i)	'상장여부
		'rs_?					= ArrRs(20, i)	'관련자료여부
		rs_company_kind			= ArrRs(21, i)	'형태코드
		rs_item_option2			= ArrRs(22, i)	'아이템옵션2
		rs_tct_flag				= ArrRs(23, i)	'재택근무가능
		rs_position_group		= ArrRs(24, i)	'직급
		rs_position_title		= ArrRs(25, i)	'직책
		rs_workplace			= ArrRs(26, i)	'근무부서
		'rs_?					= ArrRs(27, i)	'회사사진수
		'rs_?					= ArrRs(28, i)	'유무료
		'rs_?					= ArrRs(29, i)	'해피커리어
		rs_modify_date			= ArrRs(30, i)	'수정일
		rs_runmber				= ArrRs(31, i)	'모집인원
		rs_register_gubun		= ArrRs(32, i)	'등록서비스
		rs_school_over			= ArrRs(33, i)	'학력이상
		rs_work_type			= ArrRs(34, i)	'(null)근무형태
		'rs_?					= ArrRs(35, i)	'인사담
		'rs_?					= ArrRs(36, i)	'댓글담
		'rs_?					= ArrRs(37, i)	'(null)담답변
		'rs_?					= ArrRs(38, i)	'(null)담답변
		rs_salary_code			= ArrRs(39, i)	'연봉코드
		'rs_?					= ArrRs(40, i)	'히든챔피언여부
		'rs_?					= ArrRs(41, i)	'WORK_TP_ICD
		rs_subway_code			= ArrRs(42, i)	'지하철코드
		rs_biz_code				= ArrRs(43, i)	'사업자번호
		rs_applyUrl				= ArrRs(44, i)	'사이트접수URL
		If InStr(rs_applyUrl, "http") = 0 Then rs_applyUrl = "http://" & rs_applyUrl

		'스크랩/즐겨찾기, 중견/강소 구분, 지역2차 리스트, 접수방법
		Dim chk_scrap, chk_attention
		Dim arrRsView, arrRsScrap, arrRsAttention, arrRsArea
		chk_scrap		= ""
		chk_attention	= ""

		ConnectDB DBCon, Application("DBInfo_FAIR")
			Dim SpName, mode, bizNum
			' 채용공고 상태 및 기업정보 조회용 사업자번호 추출
			SpName="W_채용정보_상태_조회"

			ReDim param(2)
			param(0)=makeParam("@id_num", adInteger, adParamInput, 4, rs_id_num)
			param(1)=makeParam("@mode", adVarChar, adParamOutput, 4, "")
			param(2)=makeParam("@bizNum", adVarChar, adParamOutput, 10, "")

			Call execSP(DBCon, SpName, param, "", "")
			mode	= getParamOutputValue(param, "@mode")	' 채용공고 상태(ing : 진행, cl: 마감)
			bizNum	= getParamOutputValue(param, "@bizNum") ' 채용공고 등록 기업 사업자번호

			'지원양식
			strSql = ""
			strSql = strSql & " SELECT"
			strSql = strSql & " 온라인커리어양식,온라인자유양식,온라인자사양식"
			strSql = strSql & " ,이메일커리어양식,이메일자유양식,이메일자사양식"
			strSql = strSql & " FROM 채용정보_지원부가정보 WITH(NOLOCK)"
			strSql = strSql & " WHERE 채용정보등록번호 = " & rs_id_num
			strSql = strSql & " UNION ALL"
			strSql = strSql & " SELECT NULL, NULL, NULL, NULL, NULL, NULL"
			arrRsView = arrGetRsSql(DBCon, strSql, "", "")

			'채용지역 2차
			arrRsArea = arrGetRsSql(DBCon, "SELECT TOP 1 상위지역코드, 지역코드 FROM 채용지역2 WITH(NOLOCK) WHERE 등록번호 = "& rs_id_num &" ORDER BY 순차번호", "", "")

			If user_id <> "" Then
				'스크랩 여부
				 arrRsScrap = arrGetRsSql(DBCon,"SELECT 개인아이디 FROM 스크랩채용정보 WITH(NOLOCK)  WHERE 개인아이디 = '" & user_id & "' AND 삭제여부 = '0' and 채용정보등록번호 = '" &  rs_id_num & "'", "", "")
				if isArray(arrRsScrap) then
					chk_scrap = "Y"
				end If

				'관심기업 여부
				arrRsAttention = arrGetRsSql(DBCon,"SELECT 개인아이디 FROM 개인관심기업 WITH(NOLOCK)  WHERE 개인아이디 = '" & user_id & "' AND 사업자등록번호 = '" & rs_company_id & "'", "", "")
				if isArray(arrRsAttention) then
					chk_attention = "Y"
				end If
			End If


			ReDim param(0)
			param(0) = makeParam("@BizNum", adVarchar, adParamInput, 10, bizNum)

			Dim arrRsComInfo
			SpName = "USP_COMPANY_INFO_VIEW"
			arrRsComInfo = arrGetRsSP(dbCon, spName, param, "", "")

			' 기업분류 추출
			Dim RsCom_BizIPO, RsCom_BizScale, RsCom_MediYN, RsCom_StrYN, RsCom_HdChampYN, RsCom_BIGYN
			If isArray(arrRsComInfo) Then
				RsCom_BizIPO	= arrRsComInfo(3, 0)	' 상장여부(IPO)
				RsCom_BizScale	= arrRsComInfo(4, 0)	 '기업형태(bizScale)

				RsCom_MediYN	= arrRsComInfo(17, 0)	' 중견기업(Y/N)
				RsCom_StrYN		= arrRsComInfo(18, 0)	' 강소기업(Y/N)
				RsCom_HdChampYN	= arrRsComInfo(19, 0)	' 히든챔피언(Y/N)
				RsCom_BIGYN		= arrRsComInfo(16, 0)	' 대기업 구분자(1: 대기업, 2: 공기업, 3: 금융권, NULL: 해당없음)
			Else
				RsCom_BizIPO	= ""
				RsCom_BizScale	= ""

				RsCom_MediYN	= ""
				RsCom_StrYN		= ""
				RsCom_HdChampYN	= ""
				RsCom_BIGYN		= ""
			End If

			' 기업 상장 표기
			Dim bizIPO : bizIPO	= ""
			bizIPO = getIPOCodeName(RsCom_BizIPO)
			bizIPO = Replace(Replace(Replace(bizIPO, "(", ""), ")", ""),"기타","")

			' 기업 분류 표기
			Dim bizGubun : bizGubun	= ""
			If isnull(RsCom_MediYN) And isnull(RsCom_StrYN) And isnull(RsCom_HdChampYN) And isnull(RsCom_BIGYN) Then
				' 내부 관리자가 설정한 기업 분류가 없을 경우 신용평가기관 제공 기업 분류로 대체
				Select Case RsCom_BizScale
					Case "0" bizGubun = "공공기관"
					Case "1" bizGubun = "대기업"
					'Case "2" bizGubun = "기타"
					Case "3" bizGubun = "중견기업"
				End Select
			Else
				If RsCom_HdChampYN = "Y" Then bizGubun = "히든챔피언"
				If RsCom_StrYN = "Y" Then bizGubun = "강소기업"
				If RsCom_MediYN = "Y" Then bizGubun = "중견기업"
				Select Case RsCom_BIGYN
					Case "1" bizGubun = "대기업"
					Case "2" bizGubun = "공기업"
					Case "3" bizGubun = "금융권"
				End Select
			End If

		DisconnectDB DBCon
	%>
	<dl>
		<dt>
			<a href="./view.asp?id_num=<%=rs_id_num%>"><%=rs_company_name%></a>
			<div class="comp_type">
				<% If bizGubun <> "" Then %><span class="tp tp1"><%=bizGubun%></span><% End If %>
				<% If bizIPO <> "" Then %><span class="tp tp2"><%=bizIPO%></span><% End If %>
			</div>
		</dt>
		<dd>
			<a href="./view.asp?id_num=<%=rs_id_num%>"><%=rs_subject%></a>
			<a href="javascript:void(0)" class="scrap <% If chk_scrap = "Y" Then %> on <% End If %>" onclick="fn_scrap('<%=g_LoginChk%>','<%=rs_id_num%>',this); return false;"><span>스크랩</span></a>
			<div class="recruit_info">
				<span>
					<%
					Dim str_end_date
					Select Case rs_apply_end
						Case "1" : str_end_date = "~" & Right(rs_apply_end_date, 5) & "(" & getWeekDay(weekDay(rs_apply_end_date)) & ")"
						Case "2" : str_end_date = "채용시 마감"
						Case "3" : str_end_date = "상시채용"
					End Select
					%>
					<%=str_end_date%>
				</span>
				<span><%=getExp(rs_career_code)%></span>
				<span><%=getSchool3(rs_school_code)%></span>
				<% If isArray(arrRsArea) Then %>
				<span><%=getAcName(arrRsArea(0, ii))%> &gt; <%=getAcName(arrRsArea(1, ii))%></span>
				<% End If %>
			</div>

			<% If rs_apply_selected(5) = "1" Then %>
			<a href="<%=rs_applyUrl%>" class="btn blue">홈페이지 지원</a>
			<% ElseIf arrRsView(1, 0) = "Y" Or arrRsView(3, 0) = "Y" Then %>
			<a href="./view.asp?id_num=<%=rs_id_num%>" class="btn blue">자유 양식</a>
			<% ElseIf arrRsView(2, 0) = "Y" Or arrRsView(4, 0) = "Y" Then %>
			<a href="./view.asp?id_num=<%=rs_id_num%>" class="btn blue">자사 양식</a>
			<% Else %>
			<a href="./view.asp?id_num=<%=rs_id_num%>" class="btn blue">온라인 지원</a>
			<% End If %>
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
	<!--
	<ul class="paging_area">
		<li class="btn prev"><a>이전</a></li>
		<li><strong>1</strong></li>
		<li><a href="javascript:fnGolist(2);">2</a></li>
		<li><a href="javascript:fnGolist(3);">3</a></li>
		<li><a href="javascript:fnGolist(4);">4</a></li>
		<li><a href="javascript:fnGolist(5);">5</a></li>
		<li class="btn next"><a href="javascript:fnGolist(6);">다음</a></li>
	</ul>
	-->

	<!--페이징-->
	<% Call putPage(Page, stropt, totalPage) %>
</div><!--recruit_wrap -->
