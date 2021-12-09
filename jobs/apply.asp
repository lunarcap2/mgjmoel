<OBJECT RUNAT="SERVER" PROGID="ADODB.RecordSet" ID="Rs"></OBJECT>
<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/wwwconf/function/common/base_util.asp"-->
<!--#include virtual = "/wwwconf/code/code_function.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_ac.asp"-->
<!--#include virtual = "/wwwconf/code/code_resume.asp"-->
<!--#include virtual = "/wwwconf/query_lib/user/ResumeInfo.asp"-->
<!--#include virtual = "/wwwconf/query_lib/jobs/EnterApply.asp"-->
<!--#include virtual = "/inc/function/code_function.asp"-->
<%
	Call FN_LoginLimit("1")	'개인회원 허용

	Dim id_num
	id_num = request("id_num")

	If id_num = "" Then
		Response.write "<script language=javascript>"&_
			"alert('채용공고 정보가 명확하지 않아 이전 페이지로 이동합니다.');"&_
			"history.back();"&_
			"</script>"
		Response.End
	End If


	Function getFullYear(sex_code,yy)
		If Not IsNumeric(sex_code) Or IsNull(sex_code) Or sex_code = "" Then sex_code = 0
		If Not IsNumeric(yy) Or IsNull(yy) Or yy = "" Then yy = 0

		If sex_code > 0 And sex_code < 9 Then
			sex_code = CInt(sex_code)
			yy = CInt(yy)

			If sex_code = "3" Or sex_code = "4" Or sex_code = "7" Or sex_code = "8" Then
				getFullYear = 2000 + yy
			Else
				getFullYear = 1900 + yy
			End If
		End If
	End Function


	ConnectDB DBCon, Application("DBInfo_FAIR")


	Dim SpName, mode, bizNum
	' 채용공고 상태 및 기업정보 조회용 사업자번호 추출
	SpName="W_채용정보_상태_조회"

	Dim param(2)
	param(0)=makeParam("@id_num", adInteger, adParamInput, 4, id_num)
	param(1)=makeParam("@mode", adVarChar, adParamOutput, 4, "")
	param(2)=makeParam("@bizNum", adVarChar, adParamOutput, 10, "")

	Call execSP(DBCon, SpName, param, "", "")

	mode	= getParamOutputValue(param, "@mode")	' 채용공고 상태(ing : 진행, cl: 마감)
	bizNum	= getParamOutputValue(param, "@bizNum") ' 채용공고 등록 기업 사업자번호

	If mode = "cl" Then
		DisconnectDB DBCon

		Response.write "<script language=javascript>"&_
			"alert('마감된 공고에는 입사지원 할 수 없습니다.');"&_
			"history.back();"&_
			"</script>"
		Response.End
	End If



	' 지원 양식에 따라 입사지원 버튼 노출 제어
	Dim strSql4, onlineForm_career, onlineForm_free, onlineForm_biz
	strSql4 = "SELECT 온라인커리어양식, 온라인자유양식, 온라인자사양식 FROM 채용정보_지원부가정보 WITH (NOLOCK) WHERE 채용정보등록번호='"& id_num &"'"
	Rs.Open strSql4, DBCon, adOpenForwardOnly, adLockReadOnly, adCmdText
	If Rs.eof = False And Rs.bof = False Then
		onlineForm_career	= Rs(0)
		onlineForm_free		= Rs(1)
		onlineForm_biz		= Rs(2)
	End If
	Rs.Close

	If onlineForm_career <> "Y" Then
		DisconnectDB DBCon

		Response.write "<script language=javascript>"&_
			"alert('모바일에서는 온라인양식만 지원가능합니다.\n자유양식, 자사양식의 경우는\nPC환경에서 지원해주세요.');"&_
			"history.back();"&_
			"</script>"
		Response.End
	End If

	Dim strOnlineForm : strOnlineForm = ""
	If onlineForm_career="Y" Then
		strOnlineForm = strOnlineForm & "온라인양식 "
	ElseIf onlineForm_free="Y" Then
		strOnlineForm = strOnlineForm & "자유양식 "
	ElseIf onlineForm_biz="Y" Then
		strOnlineForm = strOnlineForm & "자사양식 "
	Else
		strOnlineForm = strOnlineForm
	End If

	Dim formtype
	Dim tmpFormtype		: tmpFormtype	= "A"
	Dim tmpFormtype2	: tmpFormtype2	= "D"
	If InStrRev(formtype, "A") > 0 Then
		tmpFormtype		= "A"
		tmpFormtype2	= "D"
	ElseIf InStrRev(formtype, "B") > 0 Then
		tmpFormtype		= "B"
		tmpFormtype2	= "E"
	ElseIf InStrRev(formtype, "C") > 0 Then
		tmpFormtype		= "C"
		tmpFormtype2	= "F"
	End If


	Dim strSql, iRs
	Dim company_id, relation_comnm, compclass, company_kind, point, formcode, guin_title, sex, jobtypecode, school, area, areacnt, experience, exper_month
	Dim exper_line, company_stock, requirement, jobdescription, salary_annual, viewcnt, regway, seldate, closedate, deletedate, up_date, item_option, regservice
	Dim firstdate, relation_data, site_gb, item_option2, edit_date, homeworking, classlevel, duty, relevant, company_logo, hongbo, age, major, language, salary
	Dim submitpaper, documents_etc, selection, selectwayall, guin_etc, chargeman, tel, tel_open, email, emailtxt, fax, zipcode, address, address2, rnumber, regurl
	Dim downloadurl, closetime, startdate, kind, service_flag, school_over, special_major1, special_major2, special_major3, submitpaper_split, choiceprocess, chargeman_open
	Dim emailopen, email2open, common_treat, age2, olg_filename, up_filename, mobile_open, mobile, school_exp, weekdays, weekdays_txt, submitpaper_txt, salary_txt

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


	' 접수마감 종류에 따라 변수 값 제어
	Dim strCloseDate
	If mode = "cl" Then
		strCloseDate = "마감된 채용정보 입니다."
	ElseIf seldate = 1 Then
		If closedate <> "" Then	' 접수마감일이 있을 경우

			' ## 하단 접수기간 달력 형식 표기용 변수 ##
			' 접수마감일자 및 시간 체크
			Dim rCloseday
			rCloseday	= closedate
			CloseCheck	= DateDiff("d", rCloseday, Date())

			If Len(closetime)=5 Then
				rCloseday	= rCloseday&" "&closetime
				CloseCheck	= DateDiff("h", rCloseday, Now())
			End If

			Dim sTime : sTime = rCloseday
			If minute(now()) > 0 And minute(dateadd("n", 1, sTime)) > 0 Then
				sTime = dateadd("h", -1, sTime)
			End If

			If CDate(rCloseday) < Now() Then
				strCloseCntDw = "<strong>0</strong>"
			ElseIf datediff("h", now(), sTime) = 0 Then
				strCloseCntDw = "<strong>" & 60-minute(now()) & "분 </strong> 전 입니다."
			ElseIf (60-minute(now())) = 0 Then
				strCloseCntDw = "<strong>" & datediff("h", now(), sTime) & "</strong>"
			Else
				strCloseCntDw = "<strong>" & datediff("h", now(), sTime) & "시간 " & 60-minute(now()) & "분 </strong> 전 입니다."
			End If


			strCloseDate = "~ "&Year(closedate)&"년 "&Month(closedate)&"월 "&Day(closedate)&"일 ("&weekday_txt(Weekday(closedate))&")"

			If datediff("d", date(), closedate) = 0 Then	' 오늘=마감일자
				strCloseDate		= strCloseDate & "<span class=""day"">오늘마감</span>"
				strCloseDate_Txt	= Year(closedate)&"년 "&Month(closedate)&"월 "&Day(closedate)&"일 ("&weekday_txt(Weekday(closedate))&") 오늘마감"

			ElseIf datediff("d", date(), closedate) > 0 Then   ' 접수중
				strCloseDate		= strCloseDate & " / <span class=""dDay"">D"&datediff("d", closedate, date())&"</span>"
				strCloseCntDw		= "<strong>" & datediff("d", date(), closedate) & "일 </strong> 전 입니다."
				strCloseDate_Txt	= Year(closedate)&"년 "&Month(closedate)&"월 "&Day(closedate)&"일 ("&weekday_txt(Weekday(closedate))&")"

			Else  ' 마감된 공고
				strCloseDate = "마감된 채용정보 입니다."
			End If
		End If

	ElseIf seldate = 2 Then
		strCloseDate = "채용 시 마감"
	ElseIf seldate = 3 Then
		strCloseDate = "상시 채용"
	End If


	' 경력 정보 체크 - getExp : /wwwconf/code/code_function.asp
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


	' 근무지역 체크 - getTopAcName, getAcName : /wwwconf/code/code_function_ac.asp
	Dim ArrRs, AreaNum, j, k, AreaCode, strArea, strAreaInfo
	ArrRs = arrGetRsSql(DBCon,"EXEC 채용정보_VIEW_상세지역_NEW "&id_num&",'"&mode&"'","","")
	If isArray(ArrRs) Then
		ReDim AreaCode(UBound(ArrRs, 2))
		ReDim strArea(UBound(ArrRs, 2))

		Dim i : i = 0
		For i=0 To UBound(ArrRs, 2)

			AreaNum = -1

			For j=0 To i
				If ArrRs(1, i) = AreaCode(j) Then
					AreaNum = j
				End If
			Next

			Dim urlValue : urlValue = "/jobs/list.asp"

			If Join(strArea) <> "" And ArrRs(0, i) <> "" Then
				If AreaNum >= 0 Then
					strArea(AreaNum) = strArea(AreaNum) & getAcName(ArrRs(0, i)) & ", "
				Else
					AreaCode(i) = ArrRs(1, i)
					strArea(i)	= strArea(i) & getTopAcName(ArrRs(0, i))
					strArea(i)	= strArea(i) & " " & getAcName(ArrRs(0, i)) & ", "
				End If
			Else
				strArea(i) = strArea(i) & getTopAcName(ArrRs(0, i))
				strArea(i) = strArea(i) & " " & getAcName(ArrRs(0, i)) & ", "
			End If
		Next

		strAreaInfo = Left(strArea(0), Len(strArea(0))-2)
	Else
		strAreaInfo = "-"
	End If



	Dim arrRsUserResume, arrRsUserResumeComm, arrData

	' 등록한 이력서 리스트 가져오기
	ReDim sub_param(1)
	sub_param(0) = makeParam("@i_user_id", adVarChar, adParamInput, 20, user_id)
	sub_param(1) = makeParam("@o_sp_rtn", adVarChar, adParamOutput, 1, "")
	arrRsUserResume = arrGetRsSP(DBCon, "USP_MY_RESUME_LIST", sub_param, "", "")


	'이력서 정보
	Dim arrResumeInfo
	arrResumeInfo = getResumeForApply(DBCon, user_id) '//  \wwwconf_2009\query_lib\user\ResumeInfo.asp

	Dim l_name, l_year, l_month, l_day, l_sex, l_paycode, l_email, l_hp, l_tel, l_status, l_contact, l_email_flag, l_hp_flag, l_tel_flag, l_sch_code, l_career_code, l_career_months, rs_resume_gb, rid
	If IsArray(arrResumeInfo) Then
		l_name = arrResumeInfo(0,0)
		l_year = getFullYear(arrResumeInfo(4,0),arrResumeInfo(1,0))
		l_month = arrResumeInfo(2,0)
		l_day = arrResumeInfo(3,0)
		l_sex = arrResumeInfo(4,0)
		l_paycode = arrResumeInfo(5,0)
		l_email = arrResumeInfo(7,0)
		l_hp = arrResumeInfo(8,0)
		l_tel = arrResumeInfo(9,0)
		l_status =  getJobStatus(arrResumeInfo(10,0))

		If Not IsNull(arrResumeInfo(11,0)) And Not IsNull(arrResumeInfo(12,0)) Then
			l_contact = Right("00"& arrResumeInfo(11,0),2) &":00 ~ "& Right("00"& arrResumeInfo(12,0),2) &":00"
		End If
		l_email_flag = arrResumeInfo(13,0)
		l_hp_flag = arrResumeInfo(14,0)
		l_tel_flag = arrResumeInfo(15,0)
		l_sch_code = arrResumeInfo(16,0)
		l_career_code = arrResumeInfo(17,0)
		l_career_months = strfix(arrResumeInfo(18,0), "int", 0)

		rid = strfix( arrResumeInfo(19,0), "int", 0)
		rs_resume_gb = arrResumeInfo(21,0)
	End If

	Dim arrJobReInfoData, arrInternetApply_JidUserID
	arrJobReInfoData = getApplyInvitationList(DbCon, id_num)	' 모집부문
	arrInternetApply_JidUserID = getInternetApply_JidUserID(DBCon, id_num, user_id)


	Dim reapp_flag : reapp_flag = "N"	' 지원이력 여부
	if isArray(arrInternetApply_JidUserID) then
		reapp_flag = "Y"
	end If

	Dim appformtype
	If onlineForm_career = "Y" Then formtype = formtype & "A"
	If onlineForm_free = "Y" Then formtype = formtype & "B"
	If onlineForm_biz = "Y" Then formtype = formtype & "C"
	if appformtype = "" Then appformtype = left(formtype, 1)	' 선택값 없을 경우

	DisconnectDB DBCon

%>
<!--#include virtual = "/include/header/header.asp"-->
<script type="text/javascript" src="/js/apply_check.js?<%=publishUpdateDt%>"></script>
<script type="text/javascript">

	var _frm1 = null;
	$(document).ready(function () {
		_frm1 = document.appSendForm;
	});

	function onlyNumber(event){
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
			return;
		else
			return false;
	}

	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 )
			return;
		else
			event.target.value = event.target.value.replace(/[^0-9]/g, "");
	}

	//입사지원 하기
	function fn_apply() {
		/*
		if ($('input:checkbox[id="info_agree_chk"]').is(":checked") == false) {
			alert('개인정보 제공에 동의하셔야 합니다.');
			return false;
		}
		*/
        if(fn_chkForm(_frm1))
		{
		    <% if isArray(arrInternetApply_JidUserID) then %>
		    if(_frm1.reapp_flag.value=="Y") {
			    if(!confirm("이미 해당 채용공고에 지원하셨습니다.\n만약 재지원 하시게 되면 기존 입사지원은 취소처리 됩니다.\n재지원 하시겠습니까?")) {
				    return;
			    }
			    _frm1.reapp_flag.value = "N";
		    }
		    <% end if %>

			_frm1.submit();
		}
	}

	function fn_set_mojip(_val) {
		$("#mojip").val(_val);
	}

</script>

<body>

	<!-- header -->
	<div  id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="javascript:history.back();">이전</a>
				<p>입사지원</p>
			</div>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- container -->
	<div id="contents" class="sub_page">
		<div class="contents detail">
			<!-- list_area -->
			<div class="view_area apply cust_apply">
				<div class="appli_box">
					<dl>
						<dt><%=relation_comnm%></dt>
						<dd>
							<span><%=guin_title%></span>
							<div class="appli_info">
								<span><%=strCloseDate%></span>
								<span><%=strExperience%></span>
								<span><%=strSchool%></span>
								<span><%=strAreaInfo%></span>
							</div>
						</dd>
					</dl>
				</div><!-- appli_box -->

				<div class="gray_area">

					<div class="view_box">
						<div class="tit">
							<h4>지원 이력서</h4>
						</div>
						<div class="appli_list open">
							<ul>
							<%
							Dim total_resume_cnt : total_resume_cnt = 0
							If isArray(arrRsUserResume) Then
								For i=0 To Ubound(arrRsUserResume, 2)
								If arrRsUserResume(2, i) = "5" Then
								total_resume_cnt = total_resume_cnt + 1
							%>
								<li <% If arrRsUserResume(3, i) = "1" Then %>class="fnDefaultResum"<% End If %>>
									<label class="radiobox on" for="regResume_<%=i%>">
										<input type="radio" class="rdi" id="regResume_<%=i%>" name="regResume" value="<%=arrRsUserResume(0, i)%>" onclick='javascript:$("#rid").val(this.value);'>
										<div class="info">
											<% If arrRsUserResume(3, i) = "1" Then %>
											<span class="normal">기본이력서</span>
											<% End If %>

											<% If arrRsUserResume(5,i) <> "" Then %>
												<span class="mod"><%=Left(arrRsUserResume(5,i), 10)%> 수정</span>
											<% Else %>
												<span class="mod"><%=Left(arrRsUserResume(6,i), 10)%> 최초등록</span>
											<% End If %>
										</div>
										<p><%=arrRsUserResume(1, i)%></p>
									</label>
									<a href="/my/resume/resume_view.asp?rid=<%=arrRsUserResume(0, i)%>" target="_blank" class="btn gray">보기</a>
								</li>
							<%
								End If
								Next
							Else
							%>
								<li class="noResult">
									<p style="padding:0.5rem 0 0 0;">지원서가 없습니다.<br>지원서를 등록해 주세요.</p>
									<br>
									<a href="/my/resume/resume_regist.asp" class="btn gray" style="width:8.8rem;position:inherit;">지원서 등록</a>
								</li>
							<%
							End If
							%>
							</ul>
						</div>
						<a class="btn toggle fnSufResumeToggleButton">총 <span><%=total_resume_cnt%></span>개의 이력서</a>
						<script>
							$(document).ready(function(){
								//지원이력서 토글
								$('.fnSufResumeToggleButton').click(function(){

									$(this).add('#contents.sub_page .apply.cust_apply .appli_list > ul > li').toggleClass('active');
								});
							});
						</script>
					</div><!-- view_box -->

					<% if isArray(arrJobReInfoData) Then %>
					<div class="view_box">
						<div class="tit">
							<h4>지원 분야</h4>
						</div>
						<div class="appli_list open">
							<ul>
								<% For i=0 To UBound(arrJobReInfoData, 2) %>
								<li style="display:block;">
									<label class="radiobox on" for="mojip_sel<%=i%>">
										<input type="radio" class="rdi" id="mojip_sel<%=i%>" name="mojip_sel" value="<%=arrJobReInfoData(0, i)%>" onclick="fn_set_mojip(this.value)">
										<p><%=arrJobReInfoData(2, i)%></p>
									</label>
								</li>
								<% Next %>
							</ul>
						</div>
					</div><!-- view_box -->
					<% End If %>

					<div class="view_box">
						<div class="tit">
							<h4>지원자 정보</h4>
						</div>
						<!-- <a href="javascript:void(0)" class="btn blue">완료</a> -->

						<form id="appSendForm" name="appSendForm" method="post" action="./apply_exec_complete.asp" onsubmit="return false;">

						<input type="hidden" id="jid" name="jid" value="<%=id_num%>">
						<input type="hidden" id="guin_title" name="guin_title" value="<%=guin_title%>">
						<input type="hidden" id="new_salary" name="new_salary" value="<%=l_paycode%>">
						<input type="hidden" id="gender" name="gender" value="<%=l_sex%>">

						<input type="hidden" id="l_name" name="l_name" value="<%=l_name%>">
						<input type="hidden" id="l_tel" name="l_tel" value="<%=l_tel%>">
						<input type="hidden" id="l_hp" name="l_hp" value="<%=l_hp%>">
						<input type="hidden" id="l_email" name="l_email" value="<%=l_email%>">

						<input type="hidden" id="mojip" name="mojip" value="">
						<input type="hidden" id="rid" name="rid" value="">
						<input type="hidden" id="filelist" name="filelist" value="">
						<input type="hidden" id="reapp_flag" name="reapp_flag" value="<%=reapp_flag%>">

						<input type="hidden" id="mailme" name="mailme" value="Y">
						<input type="hidden" id="company_id" name="company_id" value="<%=company_id%>">
						<input type="hidden" id="company_name" name="company_name" value="<%=relation_comnm%>">
						<input type="hidden" id="charge_email" name="charge_email" value="<%=email%>">

						<input type="hidden" id="appnomem" name="appnomem" value="False">
						<input type="hidden" id="appmethod" name="appmethod" value="A">
						<input type="hidden" id="onlienemail_chk" name="onlienemail_chk" value="A">
						<input type="hidden" id="appformtype" name="appformtype" id="appformtype" value="<%=appformtype%>">

						<input type="hidden" id="birth_year" name="birth_year" value="<%=l_year%>">
						<input type="hidden" id="birth_month" name="birth_month" value="<%=l_month%>">
						<input type="hidden" id="birth_day" name="birth_day" value="<%=l_day%>">

						<input type="hidden" id="final_school" name="final_school" value="">
						<input type="hidden" id="experience_flag" name="experience_flag" value="">
						<input type="hidden" id="experience_year" name="experience_year" value="0">
						<input type="hidden" id="experience_month" name="experience_month" value="">

						<input type="hidden" id="profile_file_chk" name="profile_file_chk" value=""> <!-- 프로필 이력서 첨부파일 체크 여부 -->
						<input type="hidden" id="input_title" name="input_title" value="">

						<div class="appli_view">
							<table class="tb input">
								<caption>지원자 정보</caption>
								<colgroup>
									<col style="width:4rem;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th>휴대폰</th>
										<td><input type="text" class="txt" id="input_cell" name="input_cell" value="<%=l_hp%>" maxlength="13" onkeyup="numCheck(this, 'int'); changePhoneType(this);"></td>
									</tr>
									<tr>
										<th class="email5">이메일</th>
										<td><input type="text" class="txt" id="input_email" name="input_email" value="<%=l_email%>"></td>
									</tr>
								</tbody>
							</table>
						</div><!-- appli_box -->

						</form>
					</div><!-- view_box -->

					<div class="btn_area">
						<a href="javascript:void(0)" class="btn blue" onclick="fn_apply(); return false;">온라인 입사지원</a>
					</div>
				</div><!-- gray_area -->
			</div>
		</div>
	</div>
	<!-- //container -->

</body>
</html>
