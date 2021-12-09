<OBJECT RUNAT="SERVER" PROGID="ADODB.RecordSet" ID="Rs"></OBJECT>

<%
'--------------------------------------------------------------------
'   Comment		: 개인회원 > 채용공고 상세
' 	History		:  
'---------------------------------------------------------------------
Option Explicit 
%>

<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->
<!--#include virtual = "/wwwconf/function/common/base_util.asp"-->
<!--#include virtual = "/wwwconf/query_lib/code/SelectCodeInfo.asp"-->
<!--#include virtual = "/wwwconf/code/code_function.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_ac.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_jc.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_ct.asp"-->
<!--#include virtual = "/wwwconf/code/code_function_subway.asp"-->
<!--#include virtual = "/wwwconf/query_lib/company/KangsoInfo.asp"-->

<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/inc/function/code_function.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<%
	Dim id_num		: id_num = Request("id_num") ' 채용공고 등록번호

	If InStr(strRefer,"view.asp")>0 Then 
		strRefer = "/jobs/list.asp"
	Else 
		If InStr(strRefer,"whole.asp")>0 Then 
			strRefer = strRefer
		Else 
			strRefer = "/jobs/list.asp"
		End If 
	End If
	


ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim mode, bizNum
	' 채용공고 상태 및 기업정보 조회용 사업자번호 추출
	ReDim param(2)
	param(0)=makeParam("@id_num", adInteger, adParamInput, 4, id_num)
	param(1)=makeParam("@mode", adVarChar, adParamOutput, 4, "")
	param(2)=makeParam("@bizNum", adVarChar, adParamOutput, 10, "")

	Call execSP(DBCon, "W_채용정보_상태_조회", param, "", "")

	mode	= getParamOutputValue(param, "@mode")	' 채용공고 상태(ing : 진행, cl: 마감)
	bizNum	= getParamOutputValue(param, "@bizNum") ' 채용공고 등록 기업 사업자번

	If isnull(mode) Then 
		Response.write "<script language=javascript>"&_
			"alert('채용공고 정보가 명확하지 않아 이전 페이지로 이동합니다.');"&_
			"history.back();"&_
			"</script>"
		Response.End 
	End If

	Dim strTxt
	If mode = "ing" Then strTxt = "" Else strTxt = "마감" End If
	
	Dim arrRsSlide, strSql, i

	' 근무지역 체크 - getTopAcName, getAcName : /wwwconf/code/code_function_ac.asp
	Dim ArrRs, AreaNum, j, k, AreaCode, strArea, strAreaInfo
	ArrRs = arrGetRsSql(DBCon,"EXEC 채용정보_VIEW_상세지역_NEW "&id_num&",'"&mode&"'","","")
	If isArray(ArrRs) Then
		ReDim AreaCode(UBound(ArrRs, 2))
		ReDim strArea(UBound(ArrRs, 2))
		
		For i=0 To UBound(ArrRs, 2)
				
			AreaNum = -1

			For j=0 To i
				If ArrRs(1, i) = AreaCode(j) Then
					AreaNum = j
				End If
			Next

			If Join(strArea) <> "" And ArrRs(0, i) <> "" Then 
				If AreaNum >= 0 Then
					strArea(AreaNum) = strArea(AreaNum) & getAcName(ArrRs(0, i)) &", "
				Else
					AreaCode(i) = ArrRs(1, i)
					strArea(i)	= strArea(i) & getTopAcName(ArrRs(0, i)) & " "	
					strArea(i)	= strArea(i) & getAcName(ArrRs(0, i)) & ", "
				End If
			Else
				strArea(i) = strArea(i) & getTopAcName(ArrRs(0, i)) & "  "	
				strArea(i) = strArea(i) & getAcName(ArrRs(0, i)) & ", "
			End If 
		Next

		strAreaInfo = Left(strArea(0), Len(strArea(0))-2)
	Else 
		strAreaInfo = "-"
	End If

	' 고용형태 및 근무시간 체크 - getWorkperiodMonth : /wwwconf/code/code_function.asp
	Dim ArrRs2, workmonth, workmonthtype
	Dim strworktype : strworktype = ""
	ArrRs2 = arrGetRsSql(DBCon,"EXEC 채용정보_VIEW_근무형태_NEW "&id_num&",'"&mode&"'","","")
	If isArray(ArrRs2) Then
		For i = 0 To UBound(ArrRs2, 2)
			ReDim strJc(11)
			Select Case ArrRs2(0,i)
				Case 1	: strworktype = strworktype & "정규직 "
				Case 2	: strworktype = strworktype & "해외취업 "
				Case 3	: strworktype = strworktype & "아르바이트 "
				Case 4	: strworktype = strworktype & "정보화근로 "
				Case 5	: strworktype = strworktype & "병역특례 "

				Case 6	: strworktype = strworktype & "인턴 "
					
					workmonth		= getWorkperiodMonth(ArrRs2(1,i))	' 인턴직 근무기간 코드 체크
					workmonthtype	= ArrRs2(2,i)	' 인턴직 정규직 전환 가능 구분자(0/1)

					If workmonth <> "" Then
						If workmonthtype = 1 Then
							strworktype	= strworktype & "("&workmonth&" 후 정규직 전환 고려) "
						Else
							If workmonth="협의 후 결정" Then
								strworktype	= strworktype & "(근무기간 "&workmonth&") "
							Else 
								strworktype	= strworktype & "("&workmonth&" 근무) "
							End If 
						End If 
					Else
						If workmonthtype = 1 Then
							strworktype	= strworktype & "(근무 후 정규직 전환 고려) "
						Else 
							strworktype	= strworktype
						End If 
					End If

				Case 7	: strworktype = strworktype & "계약직 "

					workmonth		= getWorkperiodMonth(ArrRs2(3,i))	' 계약직 근무기간 코드 체크
					workmonthtype	= ArrRs2(4,i)	' 계약직 정규직 전환 가능 구분자(0/1)	
				
					If workmonth <> "" Then
						If workmonthtype = 1 Then
							strworktype	= strworktype & "("&workmonth&" 후 정규직 전환 고려) "
						Else
							If workmonth="협의 후 결정" Then
								strworktype	= strworktype & "(근무기간 "&workmonth&") "
							Else 
								strworktype	= strworktype & "("&workmonth&" 근무) "
							End If 
						End If 
					Else
						If workmonthtype = 1 Then
							strworktype	= strworktype & "(근무 후 정규직 전환 고려) "
						Else 
							strworktype	= strworktype
						End If 
					End If

				Case 9	: strworktype = strworktype & "파견직 "
				Case 10 : strworktype = strworktype & "위촉직 "
				Case 11	: strworktype = strworktype & "프리랜서 "
				Case 14	: strworktype = strworktype & "시간선택제 "

					' 시간선택제 정보 체크 - 근무시간 영역 표기용
					Dim strSql3, parameter(0), getWorkTimeLimitInfo, hdEMP_TP_ILST, hdWORK_TP_ICD, hdWK_TIME, hdTM_TIME, hdWORK_WEEK_NM, hdROT_WORK_YN, hdROT_WORK_HR_CONT, hdWORK_TP_CUSTOM_CONT
					strSql3 = "SELECT TOP 1 Idx, WANTED_AUTH_NO, BIZ_ID, EMP_TP_ILST, WORK_TP_ICD, WK_TIME, TM_TIME, WORK_WEEK_NM, ROT_WORK_YN, ROT_WORK_HR_CONT, WORK_TP_CUSTOM_CONT " & vbcrlf &_
								"FROM T_TM_JOBINFO (NOLOCK)" & vbcrlf &_
								"WHERE WANTED_AUTH_NO = ?"
					parameter(0) = makeParam("@WANTED_AUTH_NO", adInteger, adParamInput, 4, id_num)
					getWorkTimeLimitInfo = arrGetRsParam(DBCon, strSql3, parameter, "", "")
					If isArray(getWorkTimeLimitInfo) Then 
						hdEMP_TP_ILST			= getWorkTimeLimitInfo(3,0)
						hdWORK_TP_ICD			= getWorkTimeLimitInfo(4,0)  
						hdWK_TIME				= getWorkTimeLimitInfo(5,0)	' 시간선택제-근무시간대(ex: 10:00~17:00)
						hdTM_TIME				= getWorkTimeLimitInfo(6,0)	' 시간선택제-근무시간 직접입력(ex: 4~8시간, 탄력근무제...)
						hdWORK_WEEK_NM			= getWorkTimeLimitInfo(7,0)
						hdROT_WORK_YN			= getWorkTimeLimitInfo(8,0)	' 교대근무 체크 여부(Y/N)
						hdROT_WORK_HR_CONT		= getWorkTimeLimitInfo(9,0)	' 교대근무(2교대, 3교대, 4교대)
						hdWORK_TP_CUSTOM_CONT	= getWorkTimeLimitInfo(10,0)
					End If

					Dim strParttime : strParttime = " [시간선택제] "
					If hdROT_WORK_YN="Y" Then ' 교대근무일 경우
						strParttime = strParttime & hdROT_WORK_HR_CONT&" 근무"
					Else
						If isnull(hdWK_TIME)=False And hdWK_TIME<>"0:00~0:00" Then ' 근무시간대가 등록되어 있다면
							strParttime = strParttime & hdWK_TIME
						ElseIf isnull(hdTM_TIME)=False Then ' 근무시간 직접등록 정보가 저장되어 있다면
							strParttime = strParttime & hdTM_TIME
						Else 
							strParttime = ""
						End If 
					End If 

				Case 15	: strworktype = strworktype & "대체인력 "
			End Select

		Next

	Else
		strworktype = ""

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
	
	strSql = ""
	strSql = strSql & " SELECT TOP 1 CASE WHEN A.등록번호='" & id_num & "' THEN 1 ELSE 0 END AS NUM, A.회사아이디, A.회사명, A.모집내용제목, A.접수마감종류, A.접수마감일, B.접수마감시간, A.경력코드, A.경력월수, A.경력제한선 "
	strSql = strSql & " , A.연봉코드, B.연봉직접입력, A.학력코드, B.학력이상, B.졸업예정, A.접수방법, B.사이트접수URL, C.사업자등록번호 "
	strSql = strSql & "  FROM "& strTxt &"채용정보 A WITH(NOLOCK) "
	strSql = strSql & " INNER JOIN " & strTxt & "채용정보2 B  WITH(NOLOCK) ON A.등록번호 = B.등록번호 "
	strSql = strSql & " INNER JOIN 회사정보 C WITH(NOLOCK) ON A.회사아이디 = C.회사아이디 "
	strSql = strSql & " ORDER BY NUM DESC, A.등록번호 DESC "

	arrRsSlide = arrGetRsSql(DBCon, strSql, "", "") 

	' 진행중인 채용공고
	Dim arrRsJobsIng
	ReDim param(0)
	param(0) = makeParam("@BIZ_NUM", adVarchar, adParamInput, 10, bizNum)
	arrRsJobsIng = arrGetRsSP(dbCon, "채용정보_진행중_간단_리스트", param, "", "")

DisconnectDB DBCon



ConnectDB DBCon, Application("DBInfo")

	Dim arrNice_info
	Dim nice_param(1)
	
	nice_param(0) = makeParam("@bizcode", adVarchar, adParamInput, 10, bizNum)
	nice_param(1) = makeParam("@rtnval", adInteger, adParamOutput, 4 , 0)
	
	arrNice_info = arrGetRsSP(dbCon, "USP_NICECOMPANY_SEARCH_View", nice_param, "", "")

	Dim arrNice_0, arrNice_1, arrNice_2, arrNice_3, arrNice_4, arrNice_5, arrNice_6, arrNice_7
	If IsArray(arrNice_info) Then
		arrNice_0	= arrNice_info(0)   '// 기본정보
		arrNice_1	= arrNice_info(1)   '// 재무정보
		'arrNice_2   = arrNice_info(2)   '// 경영진
		'arrNice_3   = arrNice_info(3)   '// 주요 주주현황
		'arrNice_4   = arrNice_info(4)   '// 관계회사현황
		arrNice_5   = arrNice_info(5)   '// 산업내경쟁분석
		'arrNice_6   = arrNice_info(6)   '// 연혁
		'arrNice_7	= arrNice_info(7)   '// 기업정보
	End If



	'// 부가정보
	Dim arrKangso_option
	Dim arrKangso_option1, arrKangso_option2, arrKangso_option3, arrKangso_option4, arrKangso_option5, arrKangso_option6, arrKangso_option7
	Dim arrKangso_option8, arrKangso_option9, arrKangso_option10, arrKangso_option11, arrKangso_option12, arrKangso_option13, arrKangso_option14
	Dim arrKangso_option15, arrKangso_option16, arrKangso_option17, arrKangso_option18, arrKangso_option19, arrKangso_option21, arrKangso_option22, arrKangso_option23

	arrKangso_option	= getKangsoCompanyOptionInfo(DBCon, bizNum)	'// /wwwconf/query_lib/company/KangsoInfo.asp
	If IsArray(arrKangso_option) Then
		arrKangso_option1 = arrKangso_option(0)		'// 1	제품사진 구분  2 완품 / 1 부품사진들 / 4 완품 코멘트 / 3 부품 코멘트 / 5 전체 코멘트
		arrKangso_option2 = arrKangso_option(1)		'// 2	미디어          
		arrKangso_option3 = arrKangso_option(2)		'// 3	인재상          
		arrKangso_option4 = arrKangso_option(3)		'// 4	비젼             
		arrKangso_option5 = arrKangso_option(4)		'// 5	핵심가치        
		arrKangso_option6 = arrKangso_option(5)		'// 6	복리후생        
		arrKangso_option7 = arrKangso_option(6)		'// 7	기업문화        
		arrKangso_option8 = arrKangso_option(7)		'// 8	기업링크        
		arrKangso_option9 = arrKangso_option(8)		'// 9	지원서양식      
		arrKangso_option10 = arrKangso_option(9)	'// 10	인사담당자TIP   
		arrKangso_option11 = arrKangso_option(10)	'// 11	평판

		arrKangso_option13 = arrKangso_option(12)	'// 13  키포인트
		arrKangso_option14 = arrKangso_option(13)	'// 14	강소기업설명

		arrKangso_option15 = arrKangso_option(14)	'// 15 대표연혁 3개 2016-01-22
		arrKangso_option16 = arrKangso_option(15)	'// 16 tbl_회사정보S_중견강소_대표제품 2016-01-22
		arrKangso_option17 = arrKangso_option(16)	'// 16 tbl_회사정보S_중견강소_채용전형 2016-01-22

		arrKangso_option18 = arrKangso_option(17)	'// 18 공시정보 2016-12-21
		arrKangso_option19 = arrKangso_option(18)	'// 19 직무소개 2016-12-21

		arrKangso_option21 = arrKangso_option(20)	'// 21 hot 복리후생 2016-12-21
		arrKangso_option22 = arrKangso_option(21)	'// 22 복리후생 직접 2016-12-22
		arrKangso_option23 = arrKangso_option(22)	'// 23 복리후생 선택 2016-12-22
	End If 

DisconnectDB DBCon
%>

<script type="text/javascript">
	/// 홈페이지 입사지원
	function fn_HomeApply(link, idNum){
		window.location.href = link;
	}

	// 입사지원 버튼 클릭 시 로그인 여부 체크
	function fn_chkLogin() {
		var userid	= "<%=user_id%>";
		if (userid == "") {
			if(confirm("개인회원 로그인 후 입사 지원 가능합니다. 로그인하시겠습니까?")) {
				window.location.href = "/my/login.asp?redir=<%=Server.URLEncode(redir)%>";
			}else{
				return;
			}
		}
		else {
			window.location.href = "/jobs/apply.asp?id_num=<%=id_num%>";
		}
	}
</script>
</head>

<body>
	<script type="text/javascript">
		function setType(hireInfo) {
			var objF = document.getElementById("lform");
			objF.hireInfo.className=hireInfo;
			objF.hireInfo.value=hireInfo;
			setDiv(hireInfo);
			setTab(hireInfo)
		}

		function setDiv(hireInfo){//2017/10/19/이정희 추가
			if(hireInfo!="1"){//hireInfo=1 :개인
				var objLicom=$('#hTab2');
				objLicom.addClass("on").siblings().removeClass("on");
				$('.hire.guide').css("display","block");
				$('.comp.info').css("display","none");
			}
		}

		function setTab(hireInfo) {//2016/10/21/hjyu 수정
			var objF1 = $('#tab1');
			var objF2 = $('#tab2');
			var objF3 = $('#tab3');
			var objF4 = $('#tab4');
			
			if (hireInfo=="4")	{
				objF1.addClass("on").siblings().removeClass("on");
			} else if(hireInfo=="6")	{
				objF2.addClass("on").siblings().removeClass("on");
			} else if(hireInfo=="5")	{
				objF3.addClass("on").siblings().removeClass("on");
			} else if(hireInfo=="3")	{
				objF4.addClass("on").siblings().removeClass("on");
			}
		}//2016/10/21/hjyu 수정
		
		$(document).ready(function () {
			var mySwiper = new Swiper('.con_slide', {
			  on: {
				slideChange: function () {
					console.log("slide");
					console.log(this.activeIndex);
				},
			  },
			});

			$('.swiper-button-next').click(function(){
				console.log("next");
				console.log(this.activeIndex);
			});
			$('.swiper-button-prev').click(function(){
				console.log("prev");
				console.log(this.activeIndex);
			});
		});
	</script>

	<!-- header -->
	<div  id="header">
		<div class="header-wrap detail">
			<div class="detail_box">
				<a href="<%=strRefer%>">이전</a>
				<p>채용공고</p>
			</div>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- container -->
	<div id="contents" class="sub_page">
		<div class="contents detail">
			<div class="slide_area">
				<div class="con_slide visual">
					<div class="swiper-wrapper">
						<%
							If isArray(arrRsSlide) Then
								For i = 0 To UBound(arrRsSlide, 2)
								
								Dim seldate2, closedate2, closetime2, experience2, exper_month2, exper_line2, salary_annual2, salary_txt2, school2, school_over2, school_exp2, RegWay_2, regurl2
								seldate2		= arrRsSlide(4,i)
								closedate2		= arrRsSlide(5,i)
								closetime2		= arrRsSlide(6,i)
								experience2		= arrRsSlide(7,i)
								exper_month2	= arrRsSlide(8,i)
								exper_line2		= arrRsSlide(9,i)
								salary_annual2	= arrRsSlide(10,i)
								salary_txt2		= arrRsSlide(11,i)
								school2			= arrRsSlide(12,i)
								school_over2	= arrRsSlide(13,i)
								school_exp2		= arrRsSlide(14,i)
								RegWay_2		= arrRsSlide(15,i)
								regurl2			= arrRsSlide(16,i)

								' 채용공고 마감일자 체크 - weekday_txt : /inc/function/code_function.asp
								Dim strCloseDate2
								Dim CloseCheck2			: CloseCheck2		= 0

								If mode = "cl" Then
									strCloseDate2 = "마감된 채용정보 입니다." 

								' 접수마감 종류에 따라 변수 값 제어	
								ElseIf seldate2 = 1 Then
									If closedate2 <> "" Then	' 접수마감일이 있을 경우
										If datediff("d", date(), closedate2) = 0 Then	' 오늘=마감일자
											strCloseDate2		= strCloseDate2 & "<span class=""day"">오늘마감</span>"											
										ElseIf datediff("d", date(), closedate2) > 0 Then   ' 접수중
											strCloseDate2		= "~ "&Year(closedate2)&"."&Month(closedate2)&"."&Day(closedate2)&"("&weekday_txt(Weekday(closedate2))&")"											
										Else  ' 마감된 공고
											strCloseDate2 = "마감된 채용정보 입니다."
										End If
									End If
								ElseIf seldate2 = 2 Then
									strCloseDate2 = "채용 시 마감"
								ElseIf seldate2 = 3 Then
									strCloseDate2 = "상시 채용"
								End If
								
								' 입사지원관련
								Dim rCloseday2
								rCloseday2	= closedate2
								CloseCheck2	= DateDiff("d", rCloseday2, Date())

								If Len(closetime2)=5 Then
									rCloseday2	= rCloseday2&" "&closetime2
									CloseCheck2	= DateDiff("h", rCloseday2, Now())
								End If

								Dim onlineApply : onlineApply	= "fn_chkLogin();"
								If CloseCheck2 > 0 Then 
									onlineApply = "alert('해당 채용 공고의 접수가 마감되었습니다.');"
								Else
									onlineApply = onlineApply
								End If

								'경력 정보 체크 - getExp : /wwwconf/code/code_function.asp
								Dim strExperience2
								If exper_line2 = "" Then exper_line2 = "0"

								If experience2 <> "" Then
									If experience2 = "8" And exper_month2 <> "" And exper_month2 <> "0" Then	' 경력코드가 8(경력)이면서 경력개월 수가 있을 때
										If CInt(exper_month2) > 250 Or CInt(exper_month2) = 99 Then 
											strExperience2 = "년수무관"
										Else
											If exper_line2 = "0" Then
												strExperience2 = FormatNumber(int(exper_month2)/12,0)& "년 이상"
											ElseIf exper_line2 = "1" Then
												strExperience2 = FormatNumber(int(exper_month2)/12,0)& "년 미만"
											End If
										End If
									Else
										If experience2 = "0" And exper_month2 <> "" And exper_month2 <> "0" Then	' 경력코드가 0(경력)이면서 경력개월 수가 있을 때
											If CInt(exper_month2) > 250 Or CInt(exper_month2) = 99 Then
												strExperience2 = "년수무관"
											Else
												If exper_line2 = "0" Then
													strExperience2 = getExp(experience)&" "&FormatNumber(int(exper_month2)/12,0)& "년 이상" 
												ElseIf exper_line2 = "1" Then
													strExperience2 = getExp(experience)&" "&FormatNumber(int(exper_month2)/12,0)& "년 미만"
												End If
											End If
										Else
											strExperience2 = getExp(experience2)
										End if
									End If
								Else
									strExperience2 = "-"
								End If

								' 급여조건 체크 - getSalary : /wwwconf/code/code_function.asp
								Dim strSalary2
								If salary_annual2<>"" Then 
									If CInt(salary_annual2) < 30 Then
										strSalary2 = getSalary(salary_annual2)&" (연봉)"
									ElseIf CInt(salary_annual2) < 60 Then 
										strSalary2 = getSalary(salary_annual2)&" (월급)"
									ElseIf CInt(salary_annual2) = 88 Or CInt(salary_annual2) = 89 Then 
										strSalary2 = salary_txt2
									Else 
										strSalary2 = getSalary(salary_annual2)
									End If
								Else 
									strSalary2 = salary2
								End If

								' 학력 정보 체크
								Dim strSchool2
								If school2 <> "" Then
									Select Case school2
										Case "0"
											strSchool2="학력무관"
										Case "1"
											strSchool2="고등학교졸업"
										Case "2"
											strSchool2="대학졸업(2,3년)"
										Case "3"
											strSchool2="대학교졸업(4년)"
										Case "4"
											strSchool2="석사학위"
										Case "5"
											strSchool2="박사학위"
										Case "6"
											strSchool2="중학교졸업"
										Case Else   
											strSchool2="학력무관"
									End Select 

									If strSchool2 <> "무관" Then
										If school_over2 = "1" Then
											strSchool2 = strSchool2 & " 이상"
										End If

										If school_exp2 = "1" Then
											strSchool2 = strSchool2 & " (졸업예정 가능)"
										End If
									End If

								Else
									strSchool2 = "-"
								End If

								' 접수 방법에 따라 입사지원 버튼 노출 제어
								Dim splRegWay2
								If Not(IsNull(RegWay_2)) And RegWay_2 <> "" Then
									splRegWay2 = Split(RegWay_2, ",")
								Else
									splRegWay2 = ""
								End If

								If IsArray(splRegWay2) Then
									Dim regway_cnt2 : regway_cnt2 = UBound(splRegWay2)	
									Dim regway5_2

									' 홈페이지접수 항목이 체크된 경우
									If regway_cnt2 >= 5 Then
										If splRegWay2(5) = "1" Then
											regway5_2 = "1"
										End If
									End If
								End If

								' 사이트 접수 URL 경로 체크
								If regurl2 <> "" Then 
									If InStr(regurl2,"http")>0 Then
										regurl2	= regurl2
									Else
										regurl2	= "http://"& regurl2
									End If
								End If
								
								ConnectDB DBCon, Application("DBInfo_FAIR")
								Dim chk_attention, arrRsAttention
								If user_id <> "" Then
									'관심기업 여부
									arrRsAttention = arrGetRsSql(DBCon,"SELECT 개인아이디 FROM 개인관심기업 WITH(NOLOCK)  WHERE 개인아이디 = '" & user_id & "' AND 사업자등록번호 = '" & arrRsSlide(17,i) & "'", "", "")
									if isArray(arrRsAttention) then
										chk_attention = "Y"
									end If
								End If

								DisconnectDB DBCon
						%>
						<div class="swiper-slide">
							<div class="info_box">
								<dl>
									<dt>
										<a href="javascript:voild(0)"><%=arrRsSlide(2,i)%></a>
										<button type="button" class="heart <% If chk_attention = "Y" Then %> on <% End If %>" onclick="fn_attention('<%=g_LoginChk%>','<%=arrRsSlide(17,i)%>', '<%=arrRsSlide(2,i)%>', '<%=arrRsSlide(1,i)%>', this); return false;">관심</button>
									</dt>
									<dd>
										<a href="javascript:void(0)"><%=arrRsSlide(3,i)%></a> 
										<div class="recruit_info">
											<span class="date"><%=strCloseDate2%></span>
											<span><%=strExperience2%></span>
											<span>
												<%=strAreaInfo%>
												<%If homeworking="1" Then Response.write " (재택근무 가능)" End If%>
											</span>											
										</div>
									</dd>
									<dd class="keyword">
										<span><%=strExperience2%></span>
										<span>
											<%=strAreaInfo%>
											<%If homeworking="1" Then Response.write " (재택근무 가능)" End If%>
										</span>
										<span><%=strSalary2%></span>
										<span><%=strSchool2%></span>
									</dd>
								</dl>
							</div>
						</div>
						<%
								Next
							End If
						%>
					</div>
					<!--
					<div class="swiper-button-prev"></div>
					<div class="swiper-button-next"></div>
					-->
				</div>
			</div><!--slide_area -->
			
			<!-- list_area -->
			<div class="view_area">
				<form name="lform" id="lform" method="post" autocomplete="off" onsubmit="return validate(this);">
				<input type="hidden" value="2" name="hireInfo" >

				<ul class="hire_tab">
					<li id="hTab1" class="on"><a href="javascript:" title="상세모집요강" onclick="setType('1'); tabDiv(this,'.hire.guide','.comp.info'); return false;">상세모집요강</a></li>
					<li id="hTab2"><a href="javascript:" title="협력사 정보" onclick="<% If isArray(arrNice_0) <> False Then %>setType('2'); tabDiv(this,'.comp.info','.hire.guide'); return false;<% End If %>">협력사 정보</a></li>
										
				</ul><!-- .memberTab -->
				
				<!-- 상세모집요강 -->
				<!--#include file="./inc_view_detail.asp"-->

				<% If isArray(arrNice_0) <> False Then %>
				<div class="comp info">
				<!-- 협력사 정보 -->
				<!--#include file="./inc_view_info_T.asp"-->
				</div>
				<% End If %>
				
				<div class="btm_btn">
					<button type="button" onclick="fn_scrap('<%=g_LoginChk%>','<%=id_num%>', this); return false;">스크랩</button>
					<% If regway5_2 = "1" Then %>
					<a href="javascript:fn_HomeApply('<%=regurl2%>', <%=id_num%>);">홈페이지 지원</a>
					<% Else %>
					<a href="javascript:<% If onlineForm_career = "Y" Then %> <%=onlineApply%> <% Else %>alert('PC에서 지원해 주시기 바랍니다.');<% End If %>">
					<% If onlineForm_career = "Y" Then %> 온라인 입사지원 
					<% Else %>
						<% If onlineForm_biz = "Y" Then %>
							자사 양식 지원
						<% ElseIf onlineForm_free = "Y" Then %>
							자유 양식 지원
						<% End If %>
					<% End If %>
					</a>
					<% End If %>
				</div>
				</form>
			</div>
		</div>
	</div>
	<!-- //container -->

<!-- 하단 -->
<!--#include virtual = "/include/footer.asp"-->
<!-- 하단 -->
</body>
</html>