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
	Call FN_LoginLimit("1")	'����ȸ�� ���

	Dim id_num
	id_num = request("id_num")

	If id_num = "" Then
		Response.write "<script language=javascript>"&_
			"alert('ä����� ������ ��Ȯ���� �ʾ� ���� �������� �̵��մϴ�.');"&_
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
	' ä����� ���� �� ������� ��ȸ�� ����ڹ�ȣ ����
	SpName="W_ä������_����_��ȸ"

	Dim param(2)
	param(0)=makeParam("@id_num", adInteger, adParamInput, 4, id_num)
	param(1)=makeParam("@mode", adVarChar, adParamOutput, 4, "")
	param(2)=makeParam("@bizNum", adVarChar, adParamOutput, 10, "")

	Call execSP(DBCon, SpName, param, "", "")

	mode	= getParamOutputValue(param, "@mode")	' ä����� ����(ing : ����, cl: ����)
	bizNum	= getParamOutputValue(param, "@bizNum") ' ä����� ��� ��� ����ڹ�ȣ

	If mode = "cl" Then
		DisconnectDB DBCon

		Response.write "<script language=javascript>"&_
			"alert('������ ������ �Ի����� �� �� �����ϴ�.');"&_
			"history.back();"&_
			"</script>"
		Response.End
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

	If onlineForm_career <> "Y" Then
		DisconnectDB DBCon

		Response.write "<script language=javascript>"&_
			"alert('����Ͽ����� �¶��ξ�ĸ� ���������մϴ�.\n�������, �ڻ����� ����\nPCȯ�濡�� �������ּ���.');"&_
			"history.back();"&_
			"</script>"
		Response.End
	End If

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

	strSql = "[W_ä������_VIEW_�⺻����_NEW] '"&id_num&"', '"&mode&"' "
	Set iRs = DBCon.Execute(strSql)
	If Not iRs.eof Then
		'ä������ tb clm
		company_id			= Trim(iRs(0))						'ȸ����̵�
		relation_comnm		= Replace(Trim(iRs(1)),"(��)","��")	'ȸ���
		compclass			= Trim(iRs(2))			'ȸ���1
		company_kind		= Trim(iRs(5))			'�����ڵ�
		point				= Trim(iRs(4))			'����
		formcode			= Trim(iRs(5))			'�����ڵ�
		guin_title			= Trim(iRs(6))			'������������
		sex					= Trim(iRs(7))			'����
		jobtypecode			= Trim(iRs(8))			'�����ڵ�
		school				= Trim(iRs(9))			'�з��ڵ�
		area				= Trim(iRs(10))			'�����ڵ�
		areacnt				= Trim(iRs(11))			'�����ڵ��
		experience			= Trim(iRs(12))			'����ڵ�
		exper_month			= Trim(iRs(13))			'��¿���
		exper_line			= Trim(iRs(14))			'������Ѽ�
		company_stock		= Trim(iRs(15))			'���忩��
		requirement			= Trim(iRs(16))			'�ڰ�����
		jobdescription		= Trim(iRs(17))			'��������
		salary_annual		= Trim(iRs(18))			'�����ڵ�
		viewcnt				= Trim(iRs(19))			'��ȸ��
		regway				= Trim(iRs(20))			'�������
		seldate				= Trim(iRs(21))			'������������
		closedate			= Trim(iRs(22))			'����������
		deletedate			= Trim(iRs(23))			'����������
		up_date				= Trim(iRs(24))			'�����
		item_option			= Trim(iRs(25))			'�����ۿɼ�
		regservice			= Trim(iRs(26))			'��ϼ���
		firstdate			= Trim(iRs(27))			'���ʵ����
		relation_data		= Trim(iRs(28))			'�����ڷῩ��
		site_gb				= Trim(iRs(29))			'����Ʈ����
		item_option2		= Trim(iRs(30))			'�����ۿɼ�2
		edit_date			= Trim(iRs(31))			'������
		homeworking			= Trim(iRs(32))			'���ñٹ�����
		classlevel			= Trim(iRs(33))			'����
		duty				= Trim(iRs(34))			'��å
		relevant			= Trim(iRs(35))			'�ٹ��μ�

		'ä������2 tb clm
		company_logo		= Trim(iRs(36))			'�ΰ�URL
		hongbo				= Trim(iRs(37))			'ä���λ縻
		age					= Trim(iRs(38))			'����
		major				= Trim(iRs(39))			'����
		language			= Trim(iRs(40))			'����
		salary				= Trim(iRs(42))			'�޿���Ÿ
		submitpaper			= Trim(iRs(43))			'2009�� �߰����⼭��
		documents_etc		= Trim(iRs(44))			'���⼭����Ÿ
		selection			= Trim(iRs(45))			'�������
		selectwayall		= Trim(iRs(46))			'2009�� �߰����������Ÿ
		guin_etc			= Trim(iRs(47))			'��Ÿ����
		chargeman			= Trim(iRs(48))			'����ڼ���
		tel					= Trim(iRs(49))			'��ȭ��ȣ
		tel_open			= Trim(iRs(50))			'��ȭ��ȣ��������
		email				= Trim(iRs(51))			'���ڿ���
		emailtxt			= Trim(iRs(51))			'���ڿ���
		fax					= Trim(iRs(52))			'�ѽ���ȣ
		zipcode				= Trim(iRs(53))			'�����ȣ
		address				= Trim(iRs(54))			'�ּ�
		address2			= Trim(iRs(55))			'�ּ�2
		rnumber				= Trim(iRs(56))			'�����ο�
		regurl				= Trim(iRs(57))			'����Ʈ����URL
		downloadurl			= Trim(iRs(58))			'��Ĵٿ�ε�URL
		closetime			= Trim(iRs(59))			'���������ð�
		startdate			= Trim(iRs(60))			'����������
		kind				= Trim(iRs(61))			'�����ó
		service_flag		= Trim(iRs(62))			'������
		school_over			= Trim(iRs(63))			'�з��̻�
		special_major1		= Trim(iRs(64))			'�������1
		special_major2		= Trim(iRs(65))			'�������2
		special_major3		= Trim(iRs(66))			'�������3
		submitpaper_split	= Trim(iRs(67))			'���⼭���ű�
		choiceprocess		= Trim(iRs(68))			'��������ű�
		chargeman_open		= Trim(iRs(69))			'����ڰ�������
		emailopen			= Trim(iRs(70))			'���ڿ����������
		email2open			= Trim(iRs(71))			'���ڿ����������2
		common_treat		= Trim(iRs(72))			'�����ڰ�
		age2				= Trim(iRs(73))			'����2
		olg_filename		= Trim(iRs(74))			'�������ϸ�
		up_filename			= Trim(iRs(75))			'���ε����ϸ�
		mobile_open			= Trim(iRs(76))			'�޴�����������
		mobile				= Trim(iRs(77))			'�޴���
		school_exp			= Trim(iRs(78))			'��������

		weekdays			= Trim(iRs(79))			'�ٹ������ڵ�
		weekdays_txt		= Trim(iRs(80))			'�ٹ�����Ű����
		submitpaper_txt		= Trim(iRs(81))			'���⼭���ű������Է�
		salary_txt			= Trim(iRs(82))			'���������Է�
	End If
	Set iRs = Nothing


	' �������� ������ ���� ���� �� ����
	Dim strCloseDate
	If mode = "cl" Then
		strCloseDate = "������ ä������ �Դϴ�."
	ElseIf seldate = 1 Then
		If closedate <> "" Then	' ������������ ���� ���

			' ## �ϴ� �����Ⱓ �޷� ���� ǥ��� ���� ##
			' ������������ �� �ð� üũ
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
				strCloseCntDw = "<strong>" & 60-minute(now()) & "�� </strong> �� �Դϴ�."
			ElseIf (60-minute(now())) = 0 Then
				strCloseCntDw = "<strong>" & datediff("h", now(), sTime) & "</strong>"
			Else
				strCloseCntDw = "<strong>" & datediff("h", now(), sTime) & "�ð� " & 60-minute(now()) & "�� </strong> �� �Դϴ�."
			End If


			strCloseDate = "~ "&Year(closedate)&"�� "&Month(closedate)&"�� "&Day(closedate)&"�� ("&weekday_txt(Weekday(closedate))&")"

			If datediff("d", date(), closedate) = 0 Then	' ����=��������
				strCloseDate		= strCloseDate & "<span class=""day"">���ø���</span>"
				strCloseDate_Txt	= Year(closedate)&"�� "&Month(closedate)&"�� "&Day(closedate)&"�� ("&weekday_txt(Weekday(closedate))&") ���ø���"

			ElseIf datediff("d", date(), closedate) > 0 Then   ' ������
				strCloseDate		= strCloseDate & " / <span class=""dDay"">D"&datediff("d", closedate, date())&"</span>"
				strCloseCntDw		= "<strong>" & datediff("d", date(), closedate) & "�� </strong> �� �Դϴ�."
				strCloseDate_Txt	= Year(closedate)&"�� "&Month(closedate)&"�� "&Day(closedate)&"�� ("&weekday_txt(Weekday(closedate))&")"

			Else  ' ������ ����
				strCloseDate = "������ ä������ �Դϴ�."
			End If
		End If

	ElseIf seldate = 2 Then
		strCloseDate = "ä�� �� ����"
	ElseIf seldate = 3 Then
		strCloseDate = "��� ä��"
	End If


	' ��� ���� üũ - getExp : /wwwconf/code/code_function.asp
	Dim strExperience
	If exper_line = "" Then exper_line = "0"

	If experience <> "" Then
		If experience = "8" And exper_month <> "" And exper_month <> "0" Then	' ����ڵ尡 8(���)�̸鼭 ��°��� ���� ���� ��
			If CInt(exper_month) > 250 Or CInt(exper_month) = 99 Then
				strExperience = "�������"
			Else
				If exper_line = "0" Then
					strExperience = FormatNumber(int(exper_month)/12,0)& "�� �̻�"
				ElseIf exper_line = "1" Then
					strExperience = FormatNumber(int(exper_month)/12,0)& "�� �̸�"
				End If
			End If
		Else
			If experience = "0" And exper_month <> "" And exper_month <> "0" Then	' ����ڵ尡 0(���)�̸鼭 ��°��� ���� ���� ��
				If CInt(exper_month) > 250 Or CInt(exper_month) = 99 Then
					strExperience = "�������"
				Else
					If exper_line = "0" Then
						strExperience = getExp(experience)&" "&FormatNumber(int(exper_month)/12,0)& "�� �̻�"
					ElseIf exper_line = "1" Then
						strExperience = getExp(experience)&" "&FormatNumber(int(exper_month)/12,0)& "�� �̸�"
					End If
				End If
			Else
				strExperience = getExp(experience)
			End if
		End If
	Else
		strExperience = "-"
	End If


	' �з� ���� üũ
	Dim strSchool
	If school <> "" Then
		Select Case school
			Case "0"
				strSchool="�з¹���"
			Case "1"
				strSchool="����б�����"
			Case "2"
				strSchool="��������(2,3��)"
			Case "3"
				strSchool="���б�����(4��)"
			Case "4"
				strSchool="��������"
			Case "5"
				strSchool="�ڻ�����"
			Case "6"
				strSchool="���б�����"
			Case Else
				strSchool="�з¹���"
		End Select

		If strSchool <> "����" Then
			If school_over = "1" Then
				strSchool = strSchool & " �̻�"
			End If

			If school_exp = "1" Then
				strSchool = strSchool & " (�������� ����)"
			End If
		End If

	Else
		strSchool = "-"
	End If


	' �ٹ����� üũ - getTopAcName, getAcName : /wwwconf/code/code_function_ac.asp
	Dim ArrRs, AreaNum, j, k, AreaCode, strArea, strAreaInfo
	ArrRs = arrGetRsSql(DBCon,"EXEC ä������_VIEW_������_NEW "&id_num&",'"&mode&"'","","")
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

	' ����� �̷¼� ����Ʈ ��������
	ReDim sub_param(1)
	sub_param(0) = makeParam("@i_user_id", adVarChar, adParamInput, 20, user_id)
	sub_param(1) = makeParam("@o_sp_rtn", adVarChar, adParamOutput, 1, "")
	arrRsUserResume = arrGetRsSP(DBCon, "USP_MY_RESUME_LIST", sub_param, "", "")


	'�̷¼� ����
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
	arrJobReInfoData = getApplyInvitationList(DbCon, id_num)	' �����ι�
	arrInternetApply_JidUserID = getInternetApply_JidUserID(DBCon, id_num, user_id)


	Dim reapp_flag : reapp_flag = "N"	' �����̷� ����
	if isArray(arrInternetApply_JidUserID) then
		reapp_flag = "Y"
	end If

	Dim appformtype
	If onlineForm_career = "Y" Then formtype = formtype & "A"
	If onlineForm_free = "Y" Then formtype = formtype & "B"
	If onlineForm_biz = "Y" Then formtype = formtype & "C"
	if appformtype = "" Then appformtype = left(formtype, 1)	' ���ð� ���� ���

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

	//�Ի����� �ϱ�
	function fn_apply() {
		/*
		if ($('input:checkbox[id="info_agree_chk"]').is(":checked") == false) {
			alert('�������� ������ �����ϼž� �մϴ�.');
			return false;
		}
		*/
        if(fn_chkForm(_frm1))
		{
		    <% if isArray(arrInternetApply_JidUserID) then %>
		    if(_frm1.reapp_flag.value=="Y") {
			    if(!confirm("�̹� �ش� ä����� �����ϼ̽��ϴ�.\n���� ������ �Ͻð� �Ǹ� ���� �Ի������� ���ó�� �˴ϴ�.\n������ �Ͻðڽ��ϱ�?")) {
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
				<a href="javascript:history.back();">����</a>
				<p>�Ի�����</p>
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
							<h4>���� �̷¼�</h4>
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
											<span class="normal">�⺻�̷¼�</span>
											<% End If %>

											<% If arrRsUserResume(5,i) <> "" Then %>
												<span class="mod"><%=Left(arrRsUserResume(5,i), 10)%> ����</span>
											<% Else %>
												<span class="mod"><%=Left(arrRsUserResume(6,i), 10)%> ���ʵ��</span>
											<% End If %>
										</div>
										<p><%=arrRsUserResume(1, i)%></p>
									</label>
									<a href="/my/resume/resume_view.asp?rid=<%=arrRsUserResume(0, i)%>" target="_blank" class="btn gray">����</a>
								</li>
							<%
								End If
								Next
							Else
							%>
								<li class="noResult">
									<p style="padding:0.5rem 0 0 0;">�������� �����ϴ�.<br>�������� ����� �ּ���.</p>
									<br>
									<a href="/my/resume/resume_regist.asp" class="btn gray" style="width:8.8rem;position:inherit;">������ ���</a>
								</li>
							<%
							End If
							%>
							</ul>
						</div>
						<a class="btn toggle fnSufResumeToggleButton">�� <span><%=total_resume_cnt%></span>���� �̷¼�</a>
						<script>
							$(document).ready(function(){
								//�����̷¼� ���
								$('.fnSufResumeToggleButton').click(function(){

									$(this).add('#contents.sub_page .apply.cust_apply .appli_list > ul > li').toggleClass('active');
								});
							});
						</script>
					</div><!-- view_box -->

					<% if isArray(arrJobReInfoData) Then %>
					<div class="view_box">
						<div class="tit">
							<h4>���� �о�</h4>
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
							<h4>������ ����</h4>
						</div>
						<!-- <a href="javascript:void(0)" class="btn blue">�Ϸ�</a> -->

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

						<input type="hidden" id="profile_file_chk" name="profile_file_chk" value=""> <!-- ������ �̷¼� ÷������ üũ ���� -->
						<input type="hidden" id="input_title" name="input_title" value="">

						<div class="appli_view">
							<table class="tb input">
								<caption>������ ����</caption>
								<colgroup>
									<col style="width:4rem;" />
									<col />
								</colgroup>
								<tbody>
									<tr>
										<th>�޴���</th>
										<td><input type="text" class="txt" id="input_cell" name="input_cell" value="<%=l_hp%>" maxlength="13" onkeyup="numCheck(this, 'int'); changePhoneType(this);"></td>
									</tr>
									<tr>
										<th class="email5">�̸���</th>
										<td><input type="text" class="txt" id="input_email" name="input_email" value="<%=l_email%>"></td>
									</tr>
								</tbody>
							</table>
						</div><!-- appli_box -->

						</form>
					</div><!-- view_box -->

					<div class="btn_area">
						<a href="javascript:void(0)" class="btn blue" onclick="fn_apply(); return false;">�¶��� �Ի�����</a>
					</div>
				</div><!-- gray_area -->
			</div>
		</div>
	</div>
	<!-- //container -->

</body>
</html>
