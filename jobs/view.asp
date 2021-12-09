<OBJECT RUNAT="SERVER" PROGID="ADODB.RecordSet" ID="Rs"></OBJECT>

<%
'--------------------------------------------------------------------
'   Comment		: ����ȸ�� > ä����� ��
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
	Call FN_LoginLimit("129")    '����ȸ���� ���ٰ���

	'2020.12.16
	If Left(Request.ServerVariables("REMOTE_ADDR"), 9) <> "211.54.63" And Dday < 0 Then
		Response.write "<script type='text/javascript'>"
		Response.write "alert('2021�� 1��4�Ͽ� �޴��� ���µ˴ϴ�.');"
		Response.write "location.href='/';"
		Response.write "</script>"
	End If


	Dim id_num		: id_num = Request("id_num") ' ä����� ��Ϲ�ȣ

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

	Dim jobsLog, strRemoteAddr, strUserAgent
	Dim strSql_military, military_rank
	If g_LoginChk = "1" Then
		'ä����� �������� log
		strRemoteAddr	= Request.ServerVariables("REMOTE_ADDR")
		strUserAgent	= Request.ServerVariables("HTTP_USER_AGENT")
		jobsLog = "INSERT INTO LOG_ä�������������(���ξ��̵�, �����ȣ, ���Ӱ��, ����IP) VALUES('" & user_id & "', " & id_num & ", '" & strUserAgent & "', '" & strRemoteAddr & "')"
		DBCon.Execute(jobsLog)

		'������ ��� üũ		
		strSql_military = "SELECT CASE WHEN ��� = '1' THEN '0' WHEN ��� = '2' THEN '0' WHEN ���� IS NOT NULL THEN '0' ELSE '1' END FROM ��������� WHERE ���̵� = '" & user_id & "'"
		military_rank = arrGetRsSql(DBCon, strSql_military, "", "")(0,0)
	Else
		military_rank = "1"
	End If

	Dim mode, bizNum
	' ä����� ���� �� ������� ��ȸ�� ����ڹ�ȣ ����
	ReDim param(2)
	param(0)=makeParam("@id_num", adInteger, adParamInput, 4, id_num)
	param(1)=makeParam("@mode", adVarChar, adParamOutput, 4, "")
	param(2)=makeParam("@bizNum", adVarChar, adParamOutput, 10, "")

	Call execSP(DBCon, "W_ä������_����_��ȸ", param, "", "")

	mode	= getParamOutputValue(param, "@mode")	' ä����� ����(ing : ����, cl: ����)
	bizNum	= getParamOutputValue(param, "@bizNum") ' ä����� ��� ��� ����ڹ�

	If isnull(mode) Then
		Response.write "<script language=javascript>"&_
			"alert('ä����� ������ ��Ȯ���� �ʾ� ���� �������� �̵��մϴ�.');"&_
			"history.back();"&_
			"</script>"
		Response.End
	End If

	Dim strTxt
	If mode = "ing" Then strTxt = "" Else strTxt = "����" End If

	Dim arrRsSlide, strSql, i

	' �ٹ����� üũ - getTopAcName, getAcName : /wwwconf/code/code_function_ac.asp
	Dim ArrRs, AreaNum, j, k, AreaCode, strArea, strAreaInfo
	ArrRs = arrGetRsSql(DBCon,"EXEC ä������_VIEW_������_NEW "&id_num&",'"&mode&"'","","")
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

	' ������� �� �ٹ��ð� üũ - getWorkperiodMonth : /wwwconf/code/code_function.asp
	Dim ArrRs2, workmonth, workmonthtype
	Dim strworktype : strworktype = ""
	ArrRs2 = arrGetRsSql(DBCon,"EXEC ä������_VIEW_�ٹ�����_NEW "&id_num&",'"&mode&"'","","")
	If isArray(ArrRs2) Then
		For i = 0 To UBound(ArrRs2, 2)
			ReDim strJc(11)
			Select Case ArrRs2(0,i)
				Case 1	: strworktype = strworktype & "������ "
				Case 2	: strworktype = strworktype & "�ؿ���� "
				Case 3	: strworktype = strworktype & "�Ƹ�����Ʈ "
				Case 4	: strworktype = strworktype & "����ȭ�ٷ� "
				Case 5	: strworktype = strworktype & "����Ư�� "

				Case 6	: strworktype = strworktype & "���� "

					workmonth		= getWorkperiodMonth(ArrRs2(1,i))	' ������ �ٹ��Ⱓ �ڵ� üũ
					workmonthtype	= ArrRs2(2,i)	' ������ ������ ��ȯ ���� ������(0/1)

					If workmonth <> "" Then
						If workmonthtype = 1 Then
							strworktype	= strworktype & "("&workmonth&" �� ������ ��ȯ ���) "
						Else
							If workmonth="���� �� ����" Then
								strworktype	= strworktype & "(�ٹ��Ⱓ "&workmonth&") "
							Else
								strworktype	= strworktype & "("&workmonth&" �ٹ�) "
							End If
						End If
					Else
						If workmonthtype = 1 Then
							strworktype	= strworktype & "(�ٹ� �� ������ ��ȯ ���) "
						Else
							strworktype	= strworktype
						End If
					End If

				Case 7	: strworktype = strworktype & "����� "

					workmonth		= getWorkperiodMonth(ArrRs2(3,i))	' ����� �ٹ��Ⱓ �ڵ� üũ
					workmonthtype	= ArrRs2(4,i)	' ����� ������ ��ȯ ���� ������(0/1)

					If workmonth <> "" Then
						If workmonthtype = 1 Then
							strworktype	= strworktype & "("&workmonth&" �� ������ ��ȯ ���) "
						Else
							If workmonth="���� �� ����" Then
								strworktype	= strworktype & "(�ٹ��Ⱓ "&workmonth&") "
							Else
								strworktype	= strworktype & "("&workmonth&" �ٹ�) "
							End If
						End If
					Else
						If workmonthtype = 1 Then
							strworktype	= strworktype & "(�ٹ� �� ������ ��ȯ ���) "
						Else
							strworktype	= strworktype
						End If
					End If

				Case 9	: strworktype = strworktype & "�İ��� "
				Case 10 : strworktype = strworktype & "������ "
				Case 11	: strworktype = strworktype & "�������� "
				Case 14	: strworktype = strworktype & "�ð������� "

					' �ð������� ���� üũ - �ٹ��ð� ���� ǥ���
					ReDim parameter(0)
					Dim strSql3, getWorkTimeLimitInfo, hdEMP_TP_ILST, hdWORK_TP_ICD, hdWK_TIME, hdTM_TIME, hdWORK_WEEK_NM, hdROT_WORK_YN, hdROT_WORK_HR_CONT, hdWORK_TP_CUSTOM_CONT
					strSql3 = "SELECT TOP 1 Idx, WANTED_AUTH_NO, BIZ_ID, EMP_TP_ILST, WORK_TP_ICD, WK_TIME, TM_TIME, WORK_WEEK_NM, ROT_WORK_YN, ROT_WORK_HR_CONT, WORK_TP_CUSTOM_CONT " & vbcrlf &_
								"FROM T_TM_JOBINFO (NOLOCK)" & vbcrlf &_
								"WHERE WANTED_AUTH_NO = ?"
					parameter(0) = makeParam("@WANTED_AUTH_NO", adInteger, adParamInput, 4, id_num)
					getWorkTimeLimitInfo = arrGetRsParam(DBCon, strSql3, parameter, "", "")
					If isArray(getWorkTimeLimitInfo) Then
						hdEMP_TP_ILST			= getWorkTimeLimitInfo(3,0)
						hdWORK_TP_ICD			= getWorkTimeLimitInfo(4,0)
						hdWK_TIME				= getWorkTimeLimitInfo(5,0)	' �ð�������-�ٹ��ð���(ex: 10:00~17:00)
						hdTM_TIME				= getWorkTimeLimitInfo(6,0)	' �ð�������-�ٹ��ð� �����Է�(ex: 4~8�ð�, ź�±ٹ���...)
						hdWORK_WEEK_NM			= getWorkTimeLimitInfo(7,0)
						hdROT_WORK_YN			= getWorkTimeLimitInfo(8,0)	' ����ٹ� üũ ����(Y/N)
						hdROT_WORK_HR_CONT		= getWorkTimeLimitInfo(9,0)	' ����ٹ�(2����, 3����, 4����)
						hdWORK_TP_CUSTOM_CONT	= getWorkTimeLimitInfo(10,0)
					End If

					Dim strParttime : strParttime = " [�ð�������] "
					If hdROT_WORK_YN="Y" Then ' ����ٹ��� ���
						strParttime = strParttime & hdROT_WORK_HR_CONT&" �ٹ�"
					Else
						If isnull(hdWK_TIME)=False And hdWK_TIME<>"0:00~0:00" Then ' �ٹ��ð��밡 ��ϵǾ� �ִٸ�
							strParttime = strParttime & hdWK_TIME
						ElseIf isnull(hdTM_TIME)=False Then ' �ٹ��ð� ������� ������ ����Ǿ� �ִٸ�
							strParttime = strParttime & hdTM_TIME
						Else
							strParttime = ""
						End If
					End If

				Case 15	: strworktype = strworktype & "��ü�η� "
			End Select

		Next

	Else
		strworktype = ""

	End If

	' ���� ��Ŀ� ���� �Ի����� ��ư ���� ����
	Dim strSql4, onlineForm_career, onlineForm_free, onlineForm_biz
	strSql4 = "SELECT �¶���Ŀ������, �¶����������, �¶����ڻ��� FROM ä������_�����ΰ����� WITH (NOLOCK) WHERE ä��������Ϲ�ȣ='"& id_num &"'"
	Rs.Open strSql4, DBCon, adOpenForwardOnly, adLockReadOnly, adCmdText
	If Rs.eof = False And Rs.bof = False Then
		onlineForm_career	= Rs(0)
		onlineForm_free		= Rs(1)
		onlineForm_biz		= Rs(2)
	End If
	Rs.Close

	Dim strOnlineForm : strOnlineForm = ""
	If onlineForm_career="Y" Then
		strOnlineForm = strOnlineForm & "�¶��ξ�� "
	ElseIf onlineForm_free="Y" Then
		strOnlineForm = strOnlineForm & "������� "
	ElseIf onlineForm_biz="Y" Then
		strOnlineForm = strOnlineForm & "�ڻ��� "
	Else
		strOnlineForm = strOnlineForm
	End If

	strSql = ""
	strSql = strSql & " SELECT TOP 1 CASE WHEN A.��Ϲ�ȣ='" & id_num & "' THEN 1 ELSE 0 END AS NUM, A.ȸ����̵�, A.ȸ���, A.������������, A.������������, A.����������, B.���������ð�, A.����ڵ�, A.��¿���, A.������Ѽ� "
	strSql = strSql & " , A.�����ڵ�, B.���������Է�, A.�з��ڵ�, B.�з��̻�, B.��������, A.�������, B.����Ʈ����URL, C.����ڵ�Ϲ�ȣ "
	strSql = strSql & "  FROM "& strTxt &"ä������ A WITH(NOLOCK) "
	strSql = strSql & " INNER JOIN " & strTxt & "ä������2 B  WITH(NOLOCK) ON A.��Ϲ�ȣ = B.��Ϲ�ȣ "
	strSql = strSql & " INNER JOIN ȸ������ C WITH(NOLOCK) ON A.ȸ����̵� = C.ȸ����̵� "
	strSql = strSql & " ORDER BY NUM DESC, A.��Ϲ�ȣ DESC "

	arrRsSlide = arrGetRsSql(DBCon, strSql, "", "")

	' �������� ä�����
	Dim arrRsJobsIng
	ReDim param(0)
	param(0) = makeParam("@BIZ_NUM", adVarchar, adParamInput, 10, bizNum)
	arrRsJobsIng = arrGetRsSP(dbCon, "ä������_������_����_����Ʈ", param, "", "")

DisconnectDB DBCon
%>

<script type="text/javascript">
	/// Ȩ������ �Ի�����
	function fn_HomeApply(link, idNum){
		window.location.href = link;
	}

	// �Ի����� ��ư Ŭ�� �� �α��� ���� üũ
	function fn_chkLogin() {
		var userid	= "<%=user_id%>";
		if (userid == "") {
			if(confirm("����ȸ�� �α��� �� �Ի� ���� �����մϴ�. �α����Ͻðڽ��ϱ�?")) {
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
	<style>
	#footer{display: none;}
	</style>
	<script type="text/javascript">
		function setType(hireInfo) {
			var objF = document.getElementById("lform");
			objF.hireInfo.className=hireInfo;
			objF.hireInfo.value=hireInfo;
			setDiv(hireInfo);
			setTab(hireInfo)
		}

		function setDiv(hireInfo){//2017/10/19/������ �߰�
			if(hireInfo!="1"){//hireInfo=1 :����
				var objLicom=$('#hTab2');
				objLicom.addClass("on").siblings().removeClass("on");
				$('.hire.guide').css("display","block");
				$('.comp.info').css("display","none");
			}
		}

		function setTab(hireInfo) {//2016/10/21/hjyu ����
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
		}//2016/10/21/hjyu ����

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
				<a href="<%=strRefer%>">����</a>
				<p>ä�����</p>
			</div>
			</div>
		</div>
	</div>
	<!-- //header -->

	<!-- container -->
	<div id="contents" class="sub_page">
		<div class="contents detail">

			<div class="slide_area">
				<div class="hire_area visual">
					<div class="info_box">
						<%
						If isArray(arrRsSlide) Then
							Dim close_yn, company_id2, relation_comnm2, guin_title2, seldate2, closedate2, closetime2, experience2, exper_month2, exper_line2, salary_annual2, salary_txt2, school2, school_over2, school_exp2, RegWay_2, regurl2, biz_code2

							close_yn			= arrRsSlide(0,0)
							company_id2			= arrRsSlide(1,0)
							relation_comnm2		= arrRsSlide(2,0)
							guin_title2			= arrRsSlide(3,0)
							seldate2			= arrRsSlide(4,0)
							closedate2			= arrRsSlide(5,0)
							closetime2			= arrRsSlide(6,0)
							experience2			= arrRsSlide(7,0)
							exper_month2		= arrRsSlide(8,0)
							exper_line2			= arrRsSlide(9,0)
							salary_annual2		= arrRsSlide(10,0)
							salary_txt2			= arrRsSlide(11,0)
							school2				= arrRsSlide(12,0)
							school_over2		= arrRsSlide(13,0)
							school_exp2			= arrRsSlide(14,0)
							RegWay_2			= arrRsSlide(15,0)
							regurl2				= arrRsSlide(16,0)
							biz_code2			= arrRsSlide(17,0)

							' ä����� �������� üũ - weekday_txt : /inc/function/code_function.asp
							Dim strCloseDate2
							Dim CloseCheck2			: CloseCheck2		= 0

							If mode = "cl" Then
								strCloseDate2 = "������ ä������ �Դϴ�."

							' �������� ������ ���� ���� �� ����
							ElseIf seldate2 = 1 Then
								If closedate2 <> "" Then	' ������������ ���� ���
									If datediff("d", date(), closedate2) = 0 Then	' ����=��������
										strCloseDate2		= strCloseDate2 & "<span class=""day"">���ø���</span>"
									ElseIf datediff("d", date(), closedate2) > 0 Then   ' ������
										strCloseDate2		= "~ "&Year(closedate2)&"."&Month(closedate2)&"."&Day(closedate2)&"("&weekday_txt(Weekday(closedate2))&")"
									Else  ' ������ ����
										strCloseDate2 = "������ ä������ �Դϴ�."
									End If
								End If
							ElseIf seldate2 = 2 Then
								strCloseDate2 = "ä�� �� ����"
							ElseIf seldate2 = 3 Then
								strCloseDate2 = "��� ä��"
							End If

							' �Ի���������
							Dim rCloseday2
							rCloseday2	= closedate2
							CloseCheck2	= DateDiff("d", rCloseday2, Date())

							If Len(closetime2)=5 Then
								rCloseday2	= rCloseday2&" "&closetime2
								CloseCheck2	= DateDiff("h", rCloseday2, Now())
							End If

							Dim onlineApply : onlineApply	= "fn_chkLogin();"
							If CloseCheck2 > 0 Then
								onlineApply = "alert('�ش� ä�� ������ ������ �����Ǿ����ϴ�.');"
							Else
								onlineApply = onlineApply
							End If

							'��� ���� üũ - getExp : /wwwconf/code/code_function.asp
							Dim strExperience2
							If exper_line2 = "" Then exper_line2 = "0"

							If experience2 <> "" Then
								If experience2 = "8" And exper_month2 <> "" And exper_month2 <> "0" Then	' ����ڵ尡 8(���)�̸鼭 ��°��� ���� ���� ��
									If CInt(exper_month2) > 250 Or CInt(exper_month2) = 99 Then
										strExperience2 = "�������"
									Else
										If exper_line2 = "0" Then
											strExperience2 = FormatNumber(int(exper_month2)/12,0)& "�� �̻�"
										ElseIf exper_line2 = "1" Then
											strExperience2 = FormatNumber(int(exper_month2)/12,0)& "�� �̸�"
										End If
									End If
								Else
									If experience2 = "0" And exper_month2 <> "" And exper_month2 <> "0" Then	' ����ڵ尡 0(���)�̸鼭 ��°��� ���� ���� ��
										If CInt(exper_month2) > 250 Or CInt(exper_month2) = 99 Then
											strExperience2 = "�������"
										Else
											If exper_line2 = "0" Then
												strExperience2 = getExp(experience)&" "&FormatNumber(int(exper_month2)/12,0)& "�� �̻�"
											ElseIf exper_line2 = "1" Then
												strExperience2 = getExp(experience)&" "&FormatNumber(int(exper_month2)/12,0)& "�� �̸�"
											End If
										End If
									Else
										strExperience2 = getExp(experience2)
									End if
								End If
							Else
								strExperience2 = "-"
							End If

							' �޿����� üũ - getSalary : /wwwconf/code/code_function.asp
							Dim strSalary2
							If salary_annual2<>"" Then
								If CInt(salary_annual2) < 30 Then
									strSalary2 = getSalary(salary_annual2)&" (����)"
								ElseIf CInt(salary_annual2) < 60 Then
									strSalary2 = getSalary(salary_annual2)&" (����)"
								ElseIf CInt(salary_annual2) = 88 Or CInt(salary_annual2) = 89 Then
									strSalary2 = salary_txt2
								Else
									strSalary2 = getSalary(salary_annual2)
								End If
							Else
								strSalary2 = salary2
							End If

							' �з� ���� üũ
							Dim strSchool2
							If school2 <> "" Then
								Select Case school2
									Case "0"
										strSchool2="�з¹���"
									Case "1"
										strSchool2="����б�����"
									Case "2"
										strSchool2="��������(2,3��)"
									Case "3"
										strSchool2="���б�����(4��)"
									Case "4"
										strSchool2="��������"
									Case "5"
										strSchool2="�ڻ�����"
									Case "6"
										strSchool2="���б�����"
									Case Else
										strSchool2="�з¹���"
								End Select

								If strSchool2 <> "����" Then
									If school_over2 = "1" Then
										strSchool2 = strSchool2 & " �̻�"
									End If

									If school_exp2 = "1" Then
										strSchool2 = strSchool2 & " (�������� ����)"
									End If
								End If

							Else
								strSchool2 = "-"
							End If

							' ���� ����� ���� �Ի����� ��ư ���� ����
							Dim splRegWay2
							If Not(IsNull(RegWay_2)) And RegWay_2 <> "" Then
								splRegWay2 = Split(RegWay_2, ",")
							Else
								splRegWay2 = ""
							End If

							If IsArray(splRegWay2) Then
								Dim regway_cnt2 : regway_cnt2 = UBound(splRegWay2)
								Dim regway5_2

								' Ȩ���������� �׸��� üũ�� ���
								If regway_cnt2 >= 5 Then
									If splRegWay2(5) = "1" Then
										regway5_2 = "1"
									End If
								End If
							End If

							' ����Ʈ ���� URL ��� üũ
							If regurl2 <> "" Then
								If InStr(regurl2,"http")>0 Then
									regurl2	= regurl2
								Else
									regurl2	= "http://"& regurl2
								End If
							End If

							ConnectDB DBCon, Application("DBInfo_FAIR")
							Dim chkScrap, ArrScrapRs
							Dim chk_attention, arrRsAttention
							If user_id <> "" Then
								'��ũ�� ����
								ArrScrapRs	= arrGetRsSql(DBCon, "SELECT ���ξ��̵� FROM ��ũ��ä������ WITH (NOLOCK) WHERE ä��������Ϲ�ȣ="& id_num &" AND ���ξ��̵�='"& user_id &"'", "", "")
								If isArray(ArrScrapRs) Then
									chkScrap = "Y"
								End If

								'���ɱ�� ����
								arrRsAttention = arrGetRsSql(DBCon,"SELECT ���ξ��̵� FROM ���ΰ��ɱ�� WITH(NOLOCK)  WHERE ���ξ��̵� = '" & user_id & "' AND ����ڵ�Ϲ�ȣ = '" & biz_code2 & "'", "", "")
								if isArray(arrRsAttention) then
									chk_attention = "Y"
								end If
							End If

							DisconnectDB DBCon
						%>
						<dl>
							<dt>
								<a href="javascript:voild(0)"><%=relation_comnm2%></a>
								<button type="button" class="heart <% If chk_attention = "Y" Then %> on <% End If %>" onclick="fn_attention('<%=g_LoginChk%>','<%=biz_code2%>', '<%=relation_comnm2%>', '<%=company_id2%>', this); return false;">����</button>
							</dt>
							<dd>
								<a href="javascript:void(0)"><%=guin_title2%></a>
								<div class="recruit_info">
									<span class="date"><%=strCloseDate2%></span>
									<span><%=strExperience2%></span>
									<span>
										<%=strAreaInfo%>
										<%If homeworking="1" Then Response.write " (���ñٹ� ����)" End If%>
									</span>
								</div>
							</dd>
							<dd class="keyword">
								<span><%=strExperience2%></span>
								<span>
									<%=strAreaInfo%>
									<%If homeworking="1" Then Response.write " (���ñٹ� ����)" End If%>
								</span>
								<span><%=strSalary2%></span>
								<span><%=strSchool2%></span>
							</dd>
						</dl>
						<%
						End If
						%>
					</div>
				</div>
			</div><!--slide_area -->

			<!-- list_area -->
			<div class="view_area">
				<form name="lform" id="lform" method="post" autocomplete="off" onsubmit="return validate(this);">
				<input type="hidden" value="2" name="hireInfo" >
				<!-- �󼼸����䰭 -->
				<!--#include file="./inc_view_detail.asp"-->

				<div class="btm_btn">					
					<% If military_rank = "1" Then %>
						<button type="button" class="<%If chkScrap ="Y" Then%>on<%End If%>" onclick="fn_scrap('<%=g_LoginChk%>','<%=id_num%>', this); return false;"><span>��ũ��</span></button>

						<% If regway5_2 = "1" Then %>
						<a href="javascript:fn_HomeApply('<%=regurl2%>', <%=id_num%>);">Ȩ������ ����</a>
						<% Else %>
						<a href="javascript:<% If onlineForm_career = "Y" Then %> <%=onlineApply%> <% Else %>alert('PC���� ������ �ֽñ� �ٶ��ϴ�.');<% End If %>">
						<% If onlineForm_biz = "Y" Then %>
							�ڻ� ��� ����
						<% ElseIf onlineForm_free = "Y" Then %>
							���� ��� ����
						<% Else %>
							�¶��� �Ի�����
						<% End If %>
						</a>
						<% End If %>
					<% Else %>
						<button type="button" class="<%If chkScrap ="Y" Then%>on<%End If%>" onclick="fn_scrap('<%=g_LoginChk%>','<%=id_num%>', this); return false;" style="width:100%;"><span>��ũ��</span></button>
					<% End If %>
				</div>

				</form>
			</div>
		</div>
	</div>
	<!-- //container -->

<!-- �ϴ� -->
<!--#include virtual = "/include/footer.asp"-->
<!-- �ϴ� -->
</body>
</html>
