<!--#include virtual = "/common/common.asp"-->
<!--#include virtual = "/include/header/header.asp"-->

<!--#include virtual = "/wwwconf/code/code_function.asp"-->
<!--#include virtual = "/wwwconf/function/db/DBConnection.asp"-->

<%
	ConnectDB DBCon, Application("DBInfo_FAIR")
	
	Dim arrRs
	Dim Param(0)

	Param(0) = makeparam("@com_id",adVarChar,adParamInput,20,"")

	arrRs = arrGetRsSP(dbCon, "USP_채용상담_협력사_리스트", Param, "", "")

	DisconnectDB DBCon
%>

</head>

<body>
<!-- 상단 -->
<!--#include virtual = "/include/gnb/topMenu.asp"-->
<!-- //상단 -->

	<!-- container -->
	<div id="contents" class="sub_page">
		<div class="contents">
			<div class="visual_area hire">
				<h2 class="m2"><img src="../images/h2_hire2.png" alt="채용상담 협력사"></h2>
			</div><!-- visual_area -->
			
			<div class="list_area">
				<div class="consul_tip">
					<img src="../images/consult_tip.png" alt="채용상담 협력사 팁">
					
					<dl>
						<dt>채용 상담 협력사란?</dt>
						<dd>
							현대자동차그룹 협력사 수시채용 마당
							채용을 진행하지는 않지만, 이후 예정된 채용 관련하여
							상담을 진행하는 협력사 입니다.
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

								If arrRs(11, i) = "Y" Then bizGubun = "히든챔피언"
								If arrRs(10, i) = "Y" Then bizGubun = "강소기업"
								If arrRs(9, i) = "Y" Then bizGubun = "중견기업"

								Select Case arrRs(8, i)
									Case "1" : bizGubun = "대기업"
									Case "2" : bizGubun = "공기업"
									Case "3" : bizGubun = "금융권"
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
								<caption>회사 정보</caption>
								<colgroup>
									<col style="width:7rem">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th>매출액</th>
										<td><%=getCompanyMoney_Text(CCur(arrRs(3, i)))%>(<%=year(date)-1%>년 기준)</td>
									</tr>
									<tr>
										<th>주요사업</th>
										<td>
											<p class="txt">
												<%=arrRs(4,i)%>
											</p>
										</td>
									</tr>
									<tr>
										<th>지역</th>
										<td><%=arrRs(5,i)%></td>
									</tr>
									<tr>
										<th>채용시기</th>
										<td><%=arrRs(6,i)%></td>
									</tr>
									<tr>
										<th>채용직무</th>
										<td>
											<p class="txt">
												<%=arrRs(7,i)%>
											</p>
										</td>
									</tr>
									<tr>
										<th>연봉정보</th>
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
										strSql = strSql & " 		SELECT DISTINCT COUNT(등록번호) OVER (PARTITION BY 회사아이디,상담일,상담시간) AS CNT "
										strSql = strSql & " 		  FROM 채용상담_신청정보 "
										strSql = strSql & " 		 WHERE 회사아이디 = '" & arrRs(0,i) & "' "
										strSql = strSql & " 	   ) AS T "

										TotCnt = arrGetRsParam(dbCon, strSql, "", "", "")(0,0)

										DisconnectDB DBCon
									%>
									<% If TotCnt <= 672 Then %><!-- 하루 상담 가능 시간대(16)*시간 당 신청 가능 인원 수(3)*상담 진행일 수(09/08~09/25=14[주말 제외]) -->
										<!-- <a href="./consult_apply.asp?cid=<%'=arrRs(0,i)%>" class="btn blue">채용 상담 신청</a> -->
										<a href="javascript:alert('협력사 채용상담 신청이 마감되었습니다.');" class="btn gray">채용 상담 신청</a>
									<% Else %>
										<a href="javascript:alert('해당 기업의 채용상담 신청이 마감되었습니다.');" class="btn gray">채용 상담 신청</a>
									<% End If %>
								<% Else %>
									<a href="javascript:alert('개인회원 로그인 후 사용가능합니다.'); goLogin();" class="btn blue">채용 상담 신청</a>
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
				<a href="<%=g_partner_wk%>/jobs/consult_list.asp">PC버전보기</a>
			</div>
			-->
		</div><!--contents -->
		
	</div>
	<!-- //container -->

<!-- 하단 -->
<!--#include virtual = "/include/footer.asp"-->
<!-- 하단 -->

</body>
</html>