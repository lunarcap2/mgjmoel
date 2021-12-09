<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<!-- if 자격증 내역:S -->
			<% If isArray(arrAbroad) Then %>
			<div class="carrList MT40">
				<div class="innerWrap">
					<div class="mmTit borderBottom"> 해외경험 </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- 자격증 내역 forEach : S-->
							<%
							For i=0 To UBound(arrAbroad,2)
								Dim ove_idx, ove_nm, ove_sYY, ove_sMM, ove_eYY, ove_eMM, ove_con
								ove_idx	= arrAbroad(0,i)
								ove_nm	= getNationCode(arrAbroad(1,i))
								ove_sYY	= arrAbroad(3,i)
								ove_sMM	= arrAbroad(4,i)
								ove_eYY	= arrAbroad(5,i)
								ove_eMM	= arrAbroad(6,i)
								ove_con	= arrAbroad(7,i)
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','','<%=ove_idx%>');">
										<div class="tt FWB lg mmColorBlue"><%=ove_nm%><span class="ln mmColorBlack"><%=ove_sYY%>년 <%=ove_sMM%>월~<%=ove_eYY%>년 <%=ove_eMM%>월</span></div>
										<div class="st mmColorGray MT15"><%=ove_con%></div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=ove_idx%>','<%=rsubGubun%>');" title="삭제"></a>
									</div>
								</div>
							</div>
							<% Next %>
							<!-- 자격증 내역 forEach : E-->
						</div>
					</div>
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1','')"><small class="MR10">+</small>해외경험 추가</a>
			</div>
			<!-- if 경력사항:E -->
			<!-- else 경력사항 :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">해외경험</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">작성된 해외경험이 없습니다.<br>등록해 주세요.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1','')"><small class="MR10">+</small>해외경험 추가</a>
							</div>
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