<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<!-- if 경력사항:S -->
			<% If isArray(arrCareer) Then %>
			<div class="carrList MT40">
				<div class="innerWrap">
					<div class="mmTit borderBottom">
						근무회사
						<% If total_career <> "입력된 내용이 없습니다." Then %>
						<span class="mmsTit sm right mmColorActiun">전체 경력년수 (<%=total_career%>)</span>
						<% End If %>
					</div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- 경력사항 forEach : S-->
							<%
							For i=0 To UBound(arrCareer,2)
								Dim car_idx, car_nm, car_sYY, car_sMM, car_eYY, car_eMM, car_ing
								car_idx	= arrCareer(0,i)
								car_nm	= arrCareer(1,i)
								car_sYY	= arrCareer(6,i)
								car_sMM	= arrCareer(7,i)
								car_eYY	= arrCareer(8,i)
								car_eMM	= arrCareer(9,i)
								car_ing	= arrCareer(5,i)

								If car_ing = "1" Then
									Dim car_sDT, car_eDT, car_term

									car_sDT = car_sYY & "-" & car_sMM
									car_eDT = car_eYY & "-" & car_eMM

									car_term = career_month(DateDiff("m", car_sDT, car_eDT))
								End If
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','','<%=car_idx%>');">
										<div class="tt mmColorBlue FWB"><%=car_nm%></div>
										<div class="st MT15">
											<span class="mmColorBlack FWB">입사</span> <%=car_sYY%>년 <%=car_sMM%>월 ~
											<% If car_ing = "1" Then %>
											<span class="mmColorBlack FWB">퇴사</span> <%=car_eYY%>년 <%=car_eMM%>월
											<span class="mmColorBlue2">(<%=car_term%>)</span>
											<% End If %>
										</div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=car_idx%>','<%=rsubGubun%>');" title="삭제"></a>
									</div>
								</div>
							</div>
							<% Next %>
							<!-- 경력사항 forEach : E-->
						</div>
					</div>
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1', '');"><small class="MR10">+</small>경력 추가하기</a>
			</div>
			<!-- if 경력사항:E -->
			<!-- else 경력사항 :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">경력사항</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">작성된 경력사항이 없습니다.<br>등록해 주세요.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1', '');"><small class="MR10">+</small>경력 추가하기</a>
							</div>
						</div>
					</div>
				</div>

				<div class="mmResumeNoResult MT40">
					<div class="innerWrap">
						<div class="noResultBox sm MT20">
							<div class="inner">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('2', '');">신입</a>
								<!-- <div class="mmCmmInput radiochk">
									<input type="checkbox" id="C1" value="신입" onclick="fn_move('2', '');" >
									<label for="C1" class="lb FWB">신입</label>
								</div> -->
							</div>
						</div>
						<div class="mmCmmLst indent indent13 MT15">
							<div class="cmmtp mmColorRed">*신입을 선택하시면, 인턴.대외활동으로 바로 이동합니다.</div>
						</div>
					</div>
				</div>
			</div>
			<% End If %>
			<!-- else 경력사항 :E -->
		</div>
		<!-- 이력서등록수정관련:S -->
	</div>
</div>
<!-- //container -->
