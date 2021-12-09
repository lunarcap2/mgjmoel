<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<!--#include virtual = "/wwwconf/code/code_function.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim arrRs
	Dim Param(0)

	Param(0) = makeparam("@com_id",adVarChar,adParamInput,20,"")

	arrRs = arrGetRsSP(dbCon, "USP_ä����_���»�_����Ʈ", Param, "", "")

	DisconnectDB DBCon
%>

</head>

<body>
<!-- ��� -->
<!--#include virtual = "/include/gnb/topMenu.asp"-->
<!-- //��� -->

	<!-- container -->
	<div id="contents" class="sub_page">
		<div class="contents">
			<div class="visual_area hire">
				<h2 class="m2"><img src="../images/h2_hire2.png" alt="ä���� ���»�"></h2>
			</div><!-- visual_area -->
			
			<div class="list_area">
				<div class="consul_tip">
					<img src="../images/consult_tip.png" alt="ä���� ���»� ��">
					
					<dl>
						<dt>ä�� ��� ���»��?</dt>
						<dd>
							�����ڵ����׷� ���»� ����ä�� ����
							ä���� ���������� ������, ���� ������ ä�� �����Ͽ�
							����� �����ϴ� ���»� �Դϴ�.
						</dd>
					</dl>

				</div>
				<div class="consul_comp">
					<%
						If isArray(arrRs) Then
							Dim i

							For i=0 To UBound(arrRs,2)
								Dim bizGubun : bizGubun = ""
								Dim bizIPO : bizIPO = ""

								bizIPO = Replace(Replace(getIPOCodeName(arrRs(12, i)), "(", ""), ")", "")

								If arrRs(11, i) = "Y" Then bizGubun = "����è�Ǿ�"
								If arrRs(10, i) = "Y" Then bizGubun = "���ұ��"
								If arrRs(9, i) = "Y" Then bizGubun = "�߰߱��"

								Select Case arrRs(8, i)
									Case "1" : bizGubun = "����"
									Case "2" : bizGubun = "�����"
									Case "3" : bizGubun = "������"
								End Select
					%>
					<dl>
						<dt>
							<%=arrRs(1,i)%>
							<div class="type">
								<% If bizIPO <> "" Then %>
								<span class="blue"><%=bizIPO%></span>
								<% End If %>
								<% If bizGubun <> "" Then %>
								<span class="gray"><%=bizGubun%></span>
								<% End If %>
							</div>
						</dt>
						<dd>
							<table>
								<caption>ȸ�� ����</caption>
								<colgroup>
									<col style="width:7rem">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th>�����</th>
										<td><%=getCompanyMoney_Text(CCur(arrRs(3, i)))%>(<%=year(date)-1%>�� ����)</td>
									</tr>
									<tr>
										<th>�ֿ���</th>
										<td>
											<p class="txt">
												<%=arrRs(4,i)%>
											</p>
										</td>
									</tr>
									<tr>
										<th>����</th>
										<td><%=arrRs(5,i)%></td>
									</tr>
									<tr>
										<th>ä��ñ�</th>
										<td><%=arrRs(6,i)%></td>
									</tr>
									<tr>
										<th>ä������</th>
										<td>
											<p class="txt">
												<%=arrRs(7,i)%>
											</p>
										</td>
									</tr>
									<tr>
										<th>��������</th>
										<td>
											<p class="txt">
												<%=arrRs(13,i)%>
											</p>
										</td>
									</tr>
								</tbody>
							</table>

							<div class="btn_area">
								<% If g_LoginChk = 1 Then %>
									<%
										Dim TotCnt

										ConnectDB DBCon, Application("DBInfo_FAIR")
										
										strSql = ""
										strSql = strSql & " SELECT ISNULL(SUM(CASE WHEN CNT = 3 THEN 1 ELSE 0 END),0) AS CNT "
										strSql = strSql & "   FROM ( "
										strSql = strSql & " 		SELECT DISTINCT COUNT(��Ϲ�ȣ) OVER (PARTITION BY ȸ����̵�,�����,���ð�) AS CNT "
										strSql = strSql & " 		  FROM ä����_��û���� "
										strSql = strSql & " 		 WHERE ȸ����̵� = '" & arrRs(0,i) & "' "
										strSql = strSql & " 	   ) AS T "

										TotCnt = arrGetRsParam(dbCon, strSql, "", "", "")(0,0)

										DisconnectDB DBCon
									%>
									<% If TotCnt <= 672 Then %><!-- �Ϸ� ��� ���� �ð���(16)*�ð� �� ��û ���� �ο� ��(3)*��� ������ ��(09/08~09/25=14[�ָ� ����]) -->
										<!-- <a href="./consult_apply.asp?cid=<%'=arrRs(0,i)%>" class="btn blue">ä�� ��� ��û</a> -->
										<a href="javascript:alert('���»� ä���� ��û�� �����Ǿ����ϴ�.');" class="btn gray">ä�� ��� ��û</a>
									<% Else %>
										<a href="javascript:alert('�ش� ����� ä���� ��û�� �����Ǿ����ϴ�.');" class="btn gray">ä�� ��� ��û</a>
									<% End If %>
								<% Else %>
									<a href="javascript:alert('����ȸ�� �α��� �� ��밡���մϴ�.'); goLogin();" class="btn blue">ä�� ��� ��û</a>
								<% End If %>
							</div>
						</dd>
					</dl>
					<%
							Next
						End If
					%>
				</div><!--recruit_wrap -->
			
			</div><!-- list_area -->
			
			<!--
			<div class="pc_btn">
				<a href="<%=g_partner_wk%>/jobs/consult_list.asp">PC��������</a>
			</div>
			-->
		</div><!--contents -->
		
	</div>
	<!-- //container -->

<!-- �ϴ� -->
<!--#include virtual = "/include/footer.asp"-->
<!-- �ϴ� -->

</body>
</html>