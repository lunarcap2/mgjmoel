<link href="/css/template.css?<%=publishUpdateDt%>" rel="stylesheet" type="text/css" />

<%
	ConnectDB DBCon, Application("DBInfo_FAIR")

	'��������Ȳ(���)
	Dim param2(1)
	param2(0) = makeparam("@TYPE",adVarChar,adParamInput,10,mode)
	param2(1) = makeparam("@JOBS_NUM",adInteger,adParamInput,4,id_num)

	Dim arrRsList, arrRsTotal, arrStatsAge
	arrRsList = arrGetRsSP(DBcon,"USP_BIZSERVICE_APPLY_STATISTIC_INFO",param2,"","")

	'arrRsTotal = arrRsList(0)	'�Ի����� ��ü�Ǽ�
	'arrStatsAge = arrRsList(6)	'���� ���

	' ��������
	Dim iRs
	Dim company_id, relation_comnm, compclass, company_kind, point, formcode, guin_title, sex, jobtypecode, school, area, areacnt, experience, exper_month
	Dim exper_line, company_stock, requirement, jobdescription, salary_annual, viewcnt, regway, seldate, closedate, deletedate, up_date, item_option, regservice
	Dim firstdate, relation_data, site_gb, item_option2, edit_date, homeworking, classlevel, duty, relevant, company_logo, hongbo, age, major, language, salary
	Dim submitpaper, documents_etc, selection, selectwayall, guin_etc, chargeman, tel, tel_open, email, emailtxt, fax, zipcode, address, address2, rnumber, regurl
	Dim downloadurl, closetime, startdate, kind, service_flag, school_over, special_major1, special_major2, special_major3, submitpaper_split, choiceprocess, chargeman_open
	Dim emailopen, email2open, common_treat, age2, olg_filename, up_filename, mobile_open, mobile, school_exp, weekdays, weekdays_txt, submitpaper_txt, salary_txt

	If id_num <> "" Then
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
	Else
		Response.write "<script language=javascript>"&_
			"alert('ä����� ������ ��Ȯ���� �ʾ� ���� �������� �̵��մϴ�.');"&_
			"window.history.back();"&_
			"</script>"
		Response.End
	End If

	' ����Ʈ ���� URL ��� üũ
	If regurl <> "" Then
		If InStr(regurl,"http")>0 Then
			regurl	= regurl
		Else
			regurl	= "http://"& regurl
		End If
	End If

	' �Ի����� ��� �ٿ�ε� URL ��� üũ
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
				strWorkHour = "����� �����޹� (��~��)"
			Case "1"
				strWorkHour = "��5�� (��~��)"
			Case "2"
				strWorkHour = "��6�� (��~��)"
			Case "5"
				strWorkHour = weekdays_txt
		End Select
	Else
		strWorkHour = "-"
	End If

	'��� ���� üũ - getExp : /wwwconf/code/code_function.asp
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

	' �޿����� üũ - getSalary : /wwwconf/code/code_function.asp
	Dim strSalary
	If salary_annual<>"" Then
		If CInt(salary_annual) < 30 Then
			strSalary = getSalary(salary_annual)&" (����)"
		ElseIf CInt(salary_annual) < 60 Then
			strSalary = getSalary(salary_annual)&" (����)"
		ElseIf CInt(salary_annual) = 88 Or CInt(salary_annual) = 89 Then
			strSalary = salary_txt
		Else
			strSalary = getSalary(salary_annual)
		End If
	Else
		strSalary = salary
	End If

	' ä����� �������� üũ - weekday_txt : /inc/function/code_function.asp
	Dim strCloseDate
	Dim strCloseDate_Txt	: strCloseDate_Txt	= ""
	Dim strStartDate_Txt	: strStartDate_Txt = Year(startdate)&"."&Month(startdate)&"."&Day(startdate)&"("&weekday_txt(Weekday(startdate))&")"

	If mode = "cl" Then
		strCloseDate = "������ ä������ �Դϴ�."

	' �������� ������ ���� ���� �� ����
	ElseIf seldate = 1 Then
		If closedate <> "" Then	' ������������ ���� ���
			If datediff("d", date(), closedate) = 0 Then	' ����=��������
				strCloseDate		= strCloseDate & "<span class=""day"">���ø���</span>"
				strCloseDate_Txt	= Year(closedate)&"."&Month(closedate)&"."&Day(closedate)&"("&weekday_txt(Weekday(closedate))&") ���ø���"

			ElseIf datediff("d", date(), closedate) > 0 Then   ' ������
				strCloseDate		= "<span class=""dDay"">������ D"&datediff("d", closedate, date())&"</span> " & strCloseDate
				strCloseDate_Txt	= Year(closedate)&"."&Month(closedate)&"."&Day(closedate)&"("&weekday_txt(Weekday(closedate))&")"

			Else  ' ������ ����
				strCloseDate = "������ ä������ �Դϴ�."
			End If
		End If

	ElseIf seldate = 2 Then
		strCloseDate = "ä�� �� ����"

	ElseIf seldate = 3 Then
		strCloseDate = "��� ä��"
	End If

	' ���� ����� ���� �Ի����� ��ư ���� ����
	Dim splRegWay
	If Not(IsNull(regway)) And regway <> "" Then
		splRegWay = Split(regway, ",")
	Else
		splRegWay = ""
	End If

	If IsArray(splRegWay) Then
		Dim regway_cnt : regway_cnt = UBound(splRegWay)
		Dim regway0, regway1, regway2, regway3, regway4, regway5, regway6, regway7, strRegway

		' ����ä��� �¶��� ä�� �ý���(�����ڰ� �Ի����� �� ���Ϸ� �̷¼� ����) �׸��� üũ�� ���
		If regway_cnt >= 0 Then
			If splRegWay(0) = "1" Then
				regway0		= "1"
				strRegway	= "[�¶��� �Ի�����]"
			End If
		End If

		' �̸������� �׸��� üũ�� ��� > ���� ���X
		If regway_cnt >= 1 Then
			If splRegWay(1) = "1" Then
				regway1		= "1"
				strRegway	= strRegway & "[�̸��� �Ի�����]"
			End If
		End If

		' �������� �׸��� üũ�� ���
		If regway_cnt >= 2 Then
			IF splRegWay(2) = "1" Then
				regway2		= "1"
				strRegway	= strRegway & "[��������]"
			End If
		End If

		' �ѽ����� �׸��� üũ�� ���
		If regway_cnt >= 3 Then
			IF splRegWay(3) = "1" Then
				regway3		= "1"
				strRegway	= strRegway & "[�ѽ�����]"
			End If
		End If

		' �湮���� �׸��� üũ�� ���
		If regway_cnt >= 4 Then
			If splRegWay(4) = "1" Then
				regway4		= "1"
				strRegway	= strRegway & "[�湮����]"
			End If
		End If

		' Ȩ���������� �׸��� üũ�� ���
		If regway_cnt >= 5 Then
			If splRegWay(5) = "1" Then
				regway5		= "1"
				strRegway	= strRegway & "[Ȩ������ ����]"
			End If
		End If

		' �̷¼� ��� ÷������ �Ǵ� ÷������ �ٿ�ε� URL ��ΰ� ���� ���(������� > �ڻ��� �׸� üũ�� �ش�)
		If (downloadurl <> "" Or (olg_filename <> "" And up_filename <> "")) Then
			' �ѽ�, �湮 ����, Ȩ������ ������ üũ�Ǿ� ���� ���
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

	' ����, ��å
	Dim ArrRs3

	strSql = ""
	strSql = strSql & " SELECT �����ڵ�, ��å�ڵ� "
	strSql = strSql & "   FROM " & strTxt & "ä��������å "
	strSql = strSql & "  WHERE (�����ڵ� != '' OR ��å�ڵ� != '' ) "
	strSql = strSql & "    AND ä���Ϲ�ȣ = '" & id_num & "' "

	ArrRs3 = arrGetRsSql(DBCon, strSql, "", "")

	If isArray(ArrRs3) Then
		For i=0 To UBound(ArrRs3, 2)
			' ����
			If ArrRs3(0,i) <> "" Then
				classlevel = classlevel & "," & arrGetRsSql(DBCon,"EXEC usp_bizservice_code_view 'C0134','" & ArrRs3(0,i) & "',''","","")(1,0)
			End If

			' ��å
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
			' �� ���� �䰭 ��� ���� üũ
			Dim Table_Name_Content, ArrRs4, cont_i, str_sc
			If mode="ing" Then
				Table_Name_Content = "ä������_����������"
			Else
				Table_Name_Content = "����ä������_����������"
			End If

			ConnectDB DBCon, Application("DBInfo_FAIR")
			ArrRs4 = arrGetRsSql(DBCon, "SELECT �󼼸������� FROM "&Table_Name_Content&" WITH (NOLOCK) WHERE ��Ϲ�ȣ="&id_num,"", "")
			If IsArray(ArrRs4) Then
				str_sc = ArrRs4(0,cont_i)
				str_sc = replace(str_sc,"\r\n","<br>" )
				str_sc = replace(str_sc,"&lt;","<" )
				str_sc = replace(str_sc,"&gt;",">" )
				str_sc = Replace(str_sc,"<img","<img name='autosizeImg'")	'ū ������ �̹��� �������� ���� Replace
				str_sc = Replace(str_sc,"<IMG","<IMG name='autosizeImg'")	'ū ������ �̹��� �������� ���� Replace
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
				<h4>�����䰭</h3>
			</div>
			<table class="tb">
				<caption>�����䰭</caption>
				<colgroup>
					<col style="width:10rem"/>
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th>���</th>
						<td><%=strExperience%></td>
					</tr>
					<tr>
						<th>�з�</th>
						<td><%=strSchool%></td>
					</tr>
					<tr>
						<th>�������</th>
						<td>
							<span class="blue"><%=strworktype%></span>
						</td>
					</tr>
					<tr>
						<th>�޿�����</th>
						<td><span class="red"><%=strSalary%></span></td>
					</tr>
					<tr>
						<th>�ٹ�����</th>
						<td>
							<%=strAreaInfo%>
							<%If homeworking="1" Then Response.write " (���ñٹ� ����)" End If%>
						</td>
					</tr>
					<tr>
						<th>�ٹ��ð�</th>
						<td class="time"><%=strWorkHour&strParttime%></td>
					</tr>
					<% If classlevel <> "" Or duty <> "" Then %>
					<tr>
						<th>����/��å</th>
						<td>
							<%=classlevel%>
							<% If classlevel <> "" Then %>/<% End If %>
							<%=duty%>
						</td>
					</tr>
					<% End If %>
					<tr>
						<th>������</th>
						<td><%=jobdescription%></td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="view_box">
			<div class="tit">
				<h4>�����Ⱓ �� ���</h3>
			</div>

			<div class="deadline">
				<p><%=strCloseDate%></p>
				<dl>
					<dt>������</dt>
					<dd><%=strStartDate_Txt%></dd>
				</dl>
				<dl>
					<dt>������</dt>
					<% If seldate="1" And datediff("d", date(), closedate)>=0 Then %>
					<dd><%=strCloseDate_Txt%></dd>
					<% ElseIf seldate = "2" Then ' ä�� �� ���� %>
					<dd>ä�� �� ����</dd>
					<% ElseIf seldate = "3" Then ' ��� ä�� %>
					<dd>��� ä��</dd>
					<% End If %>
				</dl>
			</div>

			<table class="tb">
				<caption>�����Ⱓ �� ���</caption>
				<colgroup>
					<col style="width:10rem"/>
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th>�������</th>
						<td><%=strRegway%></td>
					</tr>
					<% If up_filename <> "" Or downloadurl <> "" Then %>
					<tr>
						<th>������</th>
						<td>
						<%
							If up_filename <> "" Then
								Dim mt_download_url : mt_download_url = "http://www2.career.co.kr/lib/jobfiledownload.asp?fileid1="&olg_filename&"&fileid2="&up_filename
						%>
						<a href="<%=mt_download_url%>">[<%=olg_filename%>]</a>
						<% End If %>
						<% If downloadurl <> "" Then %>
						<a href="<%=downloadurl%>" target="_new">[�Ի����� ��� �ٿ�ε� �Ϸ� ����]</a>
						<% End If %>
						</td>
					</tr>
					<% End If %>
					<!-- ����/�ѽ�/�湮�����鼭 ȸ�� �ּҰ� ���� ���, �ѽ������̸鼭 �ѽ���ȣ�� ���� ���, ������� ������ �����鼭 Ȩ������ ������ �ƴ� ��쿡 �ش� -->
					<% If ((regway2 = "1" Or regway3 = "1" Or regway4 = "1") And address <> "") Or (regway3 = "1" And fax <> "" And fax <> "-") Or (strOnlineForm <> "" And regway5 <> "1") Then %>
						<% If (regway2 = "1" Or regway4 = "1") And address <> "" Then %>
						<tr>
							<th>����/�湮 ����</th>
							<td><%="["&zipcode&"] "&address%></td>
						</tr>
						<% End If %>

						<% If regway3 = "1" And fax <> "" And fax <> "-" Then %>
						<tr>
							<th>�ѽ�����</th>
							<td><%=fax%></td>
						</tr>
						<% End If %>
					<% End If %>
				</tbody>
			</table>
		</div>

	</div>
</div><!-- hire guide -->
