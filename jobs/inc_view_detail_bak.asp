<link href="/css/template.css?<%=publishUpdateDt%>" rel="stylesheet" type="text/css" />

<%
	ConnectDB DBCon, Application("DBInfo_FAIR")

	'지원자현황(통계)
	Dim param2(1)
	param2(0) = makeparam("@TYPE",adVarChar,adParamInput,10,mode)
	param2(1) = makeparam("@JOBS_NUM",adInteger,adParamInput,4,id_num)

	Dim arrRsList, arrRsTotal, arrStatsAge
	arrRsList = arrGetRsSP(DBcon,"USP_BIZSERVICE_APPLY_STATISTIC_INFO",param2,"","")

	'arrRsTotal = arrRsList(0)	'입사지원 전체건수
	'arrStatsAge = arrRsList(6)	'나이 통계

	' 모집내용
	Dim iRs
	Dim company_id, relation_comnm, compclass, company_kind, point, formcode, guin_title, sex, jobtypecode, school, area, areacnt, experience, exper_month
	Dim exper_line, company_stock, requirement, jobdescription, salary_annual, viewcnt, regway, seldate, closedate, deletedate, up_date, item_option, regservice
	Dim firstdate, relation_data, site_gb, item_option2, edit_date, homeworking, classlevel, duty, relevant, company_logo, hongbo, age, major, language, salary
	Dim submitpaper, documents_etc, selection, selectwayall, guin_etc, chargeman, tel, tel_open, email, emailtxt, fax, zipcode, address, address2, rnumber, regurl
	Dim downloadurl, closetime, startdate, kind, service_flag, school_over, special_major1, special_major2, special_major3, submitpaper_split, choiceprocess, chargeman_open
	Dim emailopen, email2open, common_treat, age2, olg_filename, up_filename, mobile_open, mobile, school_exp, weekdays, weekdays_txt, submitpaper_txt, salary_txt

	If id_num <> "" Then
		strSql = "[W_채용정보_VIEW_기본정보_NEW] '"&id_num&"', '"&mode&"' "
		Set iRs = DBCon.Execute(strSql)
		If Not iRs.eof Then
			'채용정보 tb clm
			company_id			= Trim(iRs(0))						'회사아이디
			relation_comnm		= Replace(Trim(iRs(1)),"(주)","㈜")	'회사명
			compclass			= Trim(iRs(2))			'회사명1
			company_kind		= Trim(iRs(5))			'형태코드
			point				= Trim(iRs(4))			'점수
			formcode			= Trim(iRs(5))			'형태코드
			guin_title			= Trim(iRs(6))			'모집내용제목
			sex					= Trim(iRs(7))			'성별
			jobtypecode			= Trim(iRs(8))			'직종코드
			school				= Trim(iRs(9))			'학력코드
			area				= Trim(iRs(10))			'지역코드
			areacnt				= Trim(iRs(11))			'지역코드수
			experience			= Trim(iRs(12))			'경력코드
			exper_month			= Trim(iRs(13))			'경력월수
			exper_line			= Trim(iRs(14))			'경력제한선
			company_stock		= Trim(iRs(15))			'상장여부
			requirement			= Trim(iRs(16))			'자격조건
			jobdescription		= Trim(iRs(17))			'업무내용
			salary_annual		= Trim(iRs(18))			'연봉코드
			viewcnt				= Trim(iRs(19))			'조회수
			regway				= Trim(iRs(20))			'접수방법
			seldate				= Trim(iRs(21))			'접수마감종류
			closedate			= Trim(iRs(22))			'접수마감일
			deletedate			= Trim(iRs(23))			'삭제예정일
			up_date				= Trim(iRs(24))			'등록일
			item_option			= Trim(iRs(25))			'아이템옵션
			regservice			= Trim(iRs(26))			'등록서비스
			firstdate			= Trim(iRs(27))			'최초등록일
			relation_data		= Trim(iRs(28))			'관련자료여부
			site_gb				= Trim(iRs(29))			'사이트구분
			item_option2		= Trim(iRs(30))			'아이템옵션2
			edit_date			= Trim(iRs(31))			'수정일
			homeworking			= Trim(iRs(32))			'재택근무가능
			classlevel			= Trim(iRs(33))			'직급
			duty				= Trim(iRs(34))			'직책
			relevant			= Trim(iRs(35))			'근무부서

			'채용정보2 tb clm
			company_logo		= Trim(iRs(36))			'로고URL
			hongbo				= Trim(iRs(37))			'채용인사말
			age					= Trim(iRs(38))			'나이
			major				= Trim(iRs(39))			'전공
			language			= Trim(iRs(40))			'어학
			salary				= Trim(iRs(42))			'급여기타
			submitpaper			= Trim(iRs(43))			'2009년 추가제출서류
			documents_etc		= Trim(iRs(44))			'제출서류기타
			selection			= Trim(iRs(45))			'전형방법
			selectwayall		= Trim(iRs(46))			'2009년 추가전형방법기타
			guin_etc			= Trim(iRs(47))			'기타사항
			chargeman			= Trim(iRs(48))			'담당자성명
			tel					= Trim(iRs(49))			'전화번호
			tel_open			= Trim(iRs(50))			'전화번호공개여부
			email				= Trim(iRs(51))			'전자우편
			emailtxt			= Trim(iRs(51))			'전자우편
			fax					= Trim(iRs(52))			'팩스번호
			zipcode				= Trim(iRs(53))			'우편번호
			address				= Trim(iRs(54))			'주소
			address2			= Trim(iRs(55))			'주소2
			rnumber				= Trim(iRs(56))			'모집인원
			regurl				= Trim(iRs(57))			'사이트접수URL
			downloadurl			= Trim(iRs(58))			'양식다운로드URL
			closetime			= Trim(iRs(59))			'접수마감시간
			startdate			= Trim(iRs(60))			'접수시작일
			kind				= Trim(iRs(61))			'등록출처
			service_flag		= Trim(iRs(62))			'봉사우대
			school_over			= Trim(iRs(63))			'학력이상
			special_major1		= Trim(iRs(64))			'우대전공1
			special_major2		= Trim(iRs(65))			'우대전공2
			special_major3		= Trim(iRs(66))			'우대전공3
			submitpaper_split	= Trim(iRs(67))			'제출서류신규
			choiceprocess		= Trim(iRs(68))			'전형방법신규
			chargeman_open		= Trim(iRs(69))			'담당자공개여부
			emailopen			= Trim(iRs(70))			'전자우편공개여부
			email2open			= Trim(iRs(71))			'전자우편공개여부2
			common_treat		= Trim(iRs(72))			'공통자격
			age2				= Trim(iRs(73))			'나이2
			olg_filename		= Trim(iRs(74))			'원본파일명
			up_filename			= Trim(iRs(75))			'업로드파일명
			mobile_open			= Trim(iRs(76))			'휴대폰공개여부
			mobile				= Trim(iRs(77))			'휴대폰
			school_exp			= Trim(iRs(78))			'졸업예정

			weekdays			= Trim(iRs(79))			'근무요일코드
			weekdays_txt		= Trim(iRs(80))			'근무요일키워드
			submitpaper_txt		= Trim(iRs(81))			'제출서류신규직접입력
			salary_txt			= Trim(iRs(82))			'연봉직접입력
		End If
		Set iRs = Nothing
	Else
		Response.write "<script language=javascript>"&_
			"alert('채용공고 정보가 명확하지 않아 이전 페이지로 이동합니다.');"&_
			"window.history.back();"&_
			"</script>"
		Response.End
	End If

	' 사이트 접수 URL 경로 체크
	If regurl <> "" Then
		If InStr(regurl,"http")>0 Then
			regurl	= regurl
		Else
			regurl	= "http://"& regurl
		End If
	End If

	' 입사지원 양식 다운로드 URL 경로 체크
	If downloadurl <> "" Then
		If InStr(downloadurl,"http")>0 Then
			downloadurl	= downloadurl
		Else
			downloadurl	= "http://"& downloadurl
		End If
	End If

	Dim strWorkHour
	If weekdays <> "" Then
		Select Case weekdays
			Case "0"
				strWorkHour = "토요일 격주휴무 (월~토)"
			Case "1"
				strWorkHour = "주5일 (월~금)"
			Case "2"
				strWorkHour = "주6일 (월~토)"
			Case "5"
				strWorkHour = weekdays_txt
		End Select
	Else
		strWorkHour = "-"
	End If

	'경력 정보 체크 - getExp : /wwwconf/code/code_function.asp
	Dim strExperience
	If exper_line = "" Then exper_line = "0"

	If experience <> "" Then
		If experience = "8" And exper_month <> "" And exper_month <> "0" Then	' 경력코드가 8(경력)이면서 경력개월 수가 있을 때
			If CInt(exper_month) > 250 Or CInt(exper_month) = 99 Then
				strExperience = "년수무관"
			Else
				If exper_line = "0" Then
					strExperience = FormatNumber(int(exper_month)/12,0)& "년 이상"
				ElseIf exper_line = "1" Then
					strExperience = FormatNumber(int(exper_month)/12,0)& "년 미만"
				End If
			End If
		Else
			If experience = "0" And exper_month <> "" And exper_month <> "0" Then	' 경력코드가 0(경력)이면서 경력개월 수가 있을 때
				If CInt(exper_month) > 250 Or CInt(exper_month) = 99 Then
					strExperience = "년수무관"
				Else
					If exper_line = "0" Then
						strExperience = getExp(experience)&" "&FormatNumber(int(exper_month)/12,0)& "년 이상"
					ElseIf exper_line = "1" Then
						strExperience = getExp(experience)&" "&FormatNumber(int(exper_month)/12,0)& "년 미만"
					End If
				End If
			Else
				strExperience = getExp(experience)
			End if
		End If
	Else
		strExperience = "-"
	End If

	' 학력 정보 체크
	Dim strSchool
	If school <> "" Then
		Select Case school
			Case "0"
				strSchool="학력무관"
			Case "1"
				strSchool="고등학교졸업"
			Case "2"
				strSchool="대학졸업(2,3년)"
			Case "3"
				strSchool="대학교졸업(4년)"
			Case "4"
				strSchool="석사학위"
			Case "5"
				strSchool="박사학위"
			Case "6"
				strSchool="중학교졸업"
			Case Else
				strSchool="학력무관"
		End Select

		If strSchool <> "무관" Then
			If school_over = "1" Then
				strSchool = strSchool & " 이상"
			End If

			If school_exp = "1" Then
				strSchool = strSchool & " (졸업예정 가능)"
			End If
		End If

	Else
		strSchool = "-"
	End If

	' 급여조건 체크 - getSalary : /wwwconf/code/code_function.asp
	Dim strSalary
	If salary_annual<>"" Then
		If CInt(salary_annual) < 30 Then
			strSalary = getSalary(salary_annual)&" (연봉)"
		ElseIf CInt(salary_annual) < 60 Then
			strSalary = getSalary(salary_annual)&" (월급)"
		ElseIf CInt(salary_annual) = 88 Or CInt(salary_annual) = 89 Then
			strSalary = salary_txt
		Else
			strSalary = getSalary(salary_annual)
		End If
	Else
		strSalary = salary
	End If

	' 채용공고 마감일자 체크 - weekday_txt : /inc/function/code_function.asp
	Dim strCloseDate
	Dim strCloseDate_Txt	: strCloseDate_Txt	= ""
	Dim strStartDate_Txt	: strStartDate_Txt = Year(startdate)&"."&Month(startdate)&"."&Day(startdate)&"("&weekday_txt(Weekday(startdate))&")"

	If mode = "cl" Then
		strCloseDate = "마감된 채용정보 입니다."

	' 접수마감 종류에 따라 변수 값 제어
	ElseIf seldate = 1 Then
		If closedate <> "" Then	' 접수마감일이 있을 경우
			If datediff("d", date(), closedate) = 0 Then	' 오늘=마감일자
				strCloseDate		= strCloseDate & "<span class=""day"">오늘마감</span>"
				strCloseDate_Txt	= Year(closedate)&"."&Month(closedate)&"."&Day(closedate)&"("&weekday_txt(Weekday(closedate))&") 오늘마감"

			ElseIf datediff("d", date(), closedate) > 0 Then   ' 접수중
				strCloseDate		= "<span class=""dDay"">마감일 D"&datediff("d", closedate, date())&"</span> " & strCloseDate
				strCloseDate_Txt	= Year(closedate)&"."&Month(closedate)&"."&Day(closedate)&"("&weekday_txt(Weekday(closedate))&")"

			Else  ' 마감된 공고
				strCloseDate = "마감된 채용정보 입니다."
			End If
		End If

	ElseIf seldate = 2 Then
		strCloseDate = "채용 시 마감"

	ElseIf seldate = 3 Then
		strCloseDate = "상시 채용"
	End If

	' 접수 방법에 따라 입사지원 버튼 노출 제어
	Dim splRegWay
	If Not(IsNull(regway)) And regway <> "" Then
		splRegWay = Split(regway, ",")
	Else
		splRegWay = ""
	End If

	If IsArray(splRegWay) Then
		Dim regway_cnt : regway_cnt = UBound(splRegWay)
		Dim regway0, regway1, regway2, regway3, regway4, regway5, regway6, regway7, strRegway

		' 수시채용관 온라인 채용 시스템(구직자가 입사지원 시 메일로 이력서 전송) 항목이 체크된 경우
		If regway_cnt >= 0 Then
			If splRegWay(0) = "1" Then
				regway0		= "1"
				strRegway	= "[온라인 입사지원]"
			End If
		End If

		' 이메일접수 항목이 체크된 경우 > 현재 사용X
		If regway_cnt >= 1 Then
			If splRegWay(1) = "1" Then
				regway1		= "1"
				strRegway	= strRegway & "[이메일 입사지원]"
			End If
		End If

		' 우편접수 항목이 체크된 경우
		If regway_cnt >= 2 Then
			IF splRegWay(2) = "1" Then
				regway2		= "1"
				strRegway	= strRegway & "[우편접수]"
			End If
		End If

		' 팩스접수 항목이 체크된 경우
		If regway_cnt >= 3 Then
			IF splRegWay(3) = "1" Then
				regway3		= "1"
				strRegway	= strRegway & "[팩스접수]"
			End If
		End If

		' 방문접수 항목이 체크된 경우
		If regway_cnt >= 4 Then
			If splRegWay(4) = "1" Then
				regway4		= "1"
				strRegway	= strRegway & "[방문접수]"
			End If
		End If

		' 홈페이지접수 항목이 체크된 경우
		If regway_cnt >= 5 Then
			If splRegWay(5) = "1" Then
				regway5		= "1"
				strRegway	= strRegway & "[홈페이지 접수]"
			End If
		End If

		' 이력서 양식 첨부파일 또는 첨부파일 다운로드 URL 경로가 있을 경우(접수양식 > 자사양식 항목 체크에 해당)
		If (downloadurl <> "" Or (olg_filename <> "" And up_filename <> "")) Then
			' 팩스, 방문 접수, 홈페이지 접수가 체크되어 있을 경우
			IF splRegWay(3)="1" Or splRegWay(4)="1" Or splRegWay(5)="1" Or splRegWay(6)="1" Or splRegWay(7)="1" Then

				If splRegWay(6) = "1" Then
					regway6 = "1"
				End If

				If splRegWay(7) = "1" Then
					regway7 = "1"
				End If
			End If
		End If
	End If

	DisconnectDB DBCon

	ConnectDB DBCon, Application("DBInfo")

	' 직급, 직책
	Dim ArrRs3

	strSql = ""
	strSql = strSql & " SELECT 직급코드, 직책코드 "
	strSql = strSql & "   FROM " & strTxt & "채용직급직책 "
	strSql = strSql & "  WHERE (직급코드 != '' OR 직책코드 != '' ) "
	strSql = strSql & "    AND 채용등록번호 = '" & id_num & "' "

	ArrRs3 = arrGetRsSql(DBCon, strSql, "", "")

	If isArray(ArrRs3) Then
		For i=0 To UBound(ArrRs3, 2)
			' 직급
			If ArrRs3(0,i) <> "" Then
				classlevel = classlevel & "," & arrGetRsSql(DBCon,"EXEC usp_bizservice_code_view 'C0134','" & ArrRs3(0,i) & "',''","","")(1,0)
			End If

			' 직책
			If ArrRs3(1,i) <> "" Then
				duty = duty & "," & arrGetRsSql(DBCon,"EXEC usp_bizservice_code_view 'C0135','" & ArrRs3(1,i) & "',''","","")(1,0)
			End If
		Next

		classlevel = Mid(classlevel,2,Len(classlevel))
		duty = Mid(duty,2,Len(duty))
	End If

	DisconnectDB DBCon
%>

<link rel="stylesheet" type="text/css" href="/css/billboard.css?<%=publishUpdateDt%>"/>
<script type="text/javascript" src="/js/billboard.js?<%=publishUpdateDt%>"></script>
<script type="text/javascript" src="/js/billboard.pkgd.min.js?<%=publishUpdateDt%>"></script>

<div class="hire guide">
	<div class="recruit-detail">
		<script>
			$(document).ready(function () {
				//alert($("#container").width())
				$('.recruit-detail img').each(function () {
					var maxWidth = document.body.clientWidth - 5; // Max width for the image
					var maxHeight = document.body.clientHeight;    // Max height for the image
					var ratio = 0;  // Used for aspect ratio
					var width = $(this).width();    // Current image width
					var height = $(this).height();  // Current image height

					// Check if the current width is larger than the max
					if (width > maxWidth) {
						ratio = maxWidth / width;   // get ratio for scaling image
						$(this).css("width", maxWidth); // Set new width
						$(this).css("height", height * ratio);  // Scale height based on ratio
						height = height * ratio;    // Reset height to match scaled image
						width = width * ratio;    // Reset width to match scaled image
					}

					// Check if current height is larger than max
					if (height > maxHeight) {
						ratio = maxHeight / height; // get ratio for scaling image
						$(this).css("height", maxHeight);   // Set new height
						$(this).css("width", width * ratio);    // Scale width based on ratio
						width = width * ratio;    // Reset width to match scaled image
					}
				});

				$('.recruit-detail table').each(function () {
					var maxWidth = document.body.clientWidth - 10; // Max width for the image
					var ratio = 0;  // Used for aspect ratio
					var width = $(this).width();    // Current image width


					// Check if the current width is larger than the max
					if (width > maxWidth) {
						ratio = maxWidth / width;   // get ratio for scaling image
						$(this).css("width", maxWidth); // Set new width
						width = width * ratio;    // Reset width to match scaled image
					}
				});
			})
		</script>
		<%
			' 상세 모집 요강 등록 정보 체크
			Dim Table_Name_Content, ArrRs4, cont_i, str_sc
			If mode="ing" Then
				Table_Name_Content = "채용정보_전문컨텐츠"
			Else
				Table_Name_Content = "마감채용정보_전문컨텐츠"
			End If

			ConnectDB DBCon, Application("DBInfo_FAIR")
			ArrRs4 = arrGetRsSql(DBCon, "SELECT 상세모집정보 FROM "&Table_Name_Content&" WITH (NOLOCK) WHERE 등록번호="&id_num,"", "")
			If IsArray(ArrRs4) Then
				str_sc = ArrRs4(0,cont_i)
				str_sc = replace(str_sc,"\r\n","<br>" )
				str_sc = replace(str_sc,"&lt;","<" )
				str_sc = replace(str_sc,"&gt;",">" )
				str_sc = Replace(str_sc,"<img","<img name='autosizeImg'")	'큰 사이즈 이미지 리사이즈 위한 Replace
				str_sc = Replace(str_sc,"<IMG","<IMG name='autosizeImg'")	'큰 사이즈 이미지 리사이즈 위한 Replace
				str_sc = CareerDeCrypt(str_sc)
			End If
			DisconnectDB DBCon
		%>
		<div id="view_wrap">
		<%=str_sc%>
		</div>

	</div>

	<div class="tab_con">

		<div class="view_box">
			<div class="tit">
				<h4>모집요강</h3>
			</div>
			<table class="tb">
				<caption>모집요강</caption>
				<colgroup>
					<col style="width:10rem"/>
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th>경력</th>
						<td><%=strExperience%></td>
					</tr>
					<tr>
						<th>학력</th>
						<td><%=strSchool%></td>
					</tr>
					<tr>
						<th>고용형태</th>
						<td>
							<span class="blue"><%=strworktype%></span>
						</td>
					</tr>
					<tr>
						<th>급여조건</th>
						<td><span class="red"><%=strSalary%></span></td>
					</tr>
					<tr>
						<th>근무지역</th>
						<td>
							<%=strAreaInfo%>
							<%If homeworking="1" Then Response.write " (재택근무 가능)" End If%>
						</td>
					</tr>
					<tr>
						<th>근무시간</th>
						<td class="time"><%=strWorkHour&strParttime%></td>
					</tr>
					<% If classlevel <> "" Or duty <> "" Then %>
					<tr>
						<th>직급/직책</th>
						<td>
							<%=classlevel%>
							<% If classlevel <> "" Then %>/<% End If %>
							<%=duty%>
						</td>
					</tr>
					<% End If %>
					<tr>
						<th>담당업무</th>
						<td><%=jobdescription%></td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="view_box">
			<div class="tit">
				<h4>접수기간 및 방법</h3>
			</div>

			<div class="deadline">
				<p><%=strCloseDate%></p>
				<dl>
					<dt>시작일</dt>
					<dd><%=strStartDate_Txt%></dd>
				</dl>
				<dl>
					<dt>마감일</dt>
					<% If seldate="1" And datediff("d", date(), closedate)>=0 Then %>
					<dd><%=strCloseDate_Txt%></dd>
					<% ElseIf seldate = "2" Then ' 채용 시 마감 %>
					<dd>채용 시 마감</dd>
					<% ElseIf seldate = "3" Then ' 상시 채용 %>
					<dd>상시 채용</dd>
					<% End If %>
				</dl>
			</div>

			<table class="tb">
				<caption>접수기간 및 방법</caption>
				<colgroup>
					<col style="width:10rem"/>
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th>접수방법</th>
						<td><%=strRegway%></td>
					</tr>
					<% If up_filename <> "" Or downloadurl <> "" Then %>
					<tr>
						<th>지원서</th>
						<td>
						<%
							If up_filename <> "" Then
								Dim mt_download_url : mt_download_url = "http://www2.career.co.kr/lib/jobfiledownload.asp?fileid1="&olg_filename&"&fileid2="&up_filename
						%>
						<a href="<%=mt_download_url%>">[<%=olg_filename%>]</a>
						<% End If %>
						<% If downloadurl <> "" Then %>
						<a href="<%=downloadurl%>" target="_new">[입사지원 양식 다운로드 하러 가기]</a>
						<% End If %>
						</td>
					</tr>
					<% End If %>
					<!-- 우편/팩스/방문접수면서 회사 주소가 있을 경우, 팩스접수이면서 팩스번호가 있을 경우, 접수양식 정보가 있으면서 홈페이지 접수가 아닐 경우에 해당 -->
					<% If ((regway2 = "1" Or regway3 = "1" Or regway4 = "1") And address <> "") Or (regway3 = "1" And fax <> "" And fax <> "-") Or (strOnlineForm <> "" And regway5 <> "1") Then %>
						<% If (regway2 = "1" Or regway4 = "1") And address <> "" Then %>
						<tr>
							<th>우편/방문 지원</th>
							<td><%="["&zipcode&"] "&address%></td>
						</tr>
						<% End If %>

						<% If regway3 = "1" And fax <> "" And fax <> "-" Then %>
						<tr>
							<th>팩스지원</th>
							<td><%=fax%></td>
						</tr>
						<% End If %>
					<% End If %>
				</tbody>
			</table>
		</div>

	</div>
</div><!-- hire guide -->
