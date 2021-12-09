<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<!-- if 교육이수 내역:S -->
			<% If isArray(arrAcademy) Then %>
			<div class="carrList MT40">
				<div class="innerWrap">
					<div class="mmTit borderBottom"> 교육이수 내역 </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- 교육이수 내역 forEach : S-->
							<%
							For i=0 To Ubound(arrAcademy,2)
								Dim edu_idx, edu_nm, edu_agency, edu_sYY, edu_sMM, edu_eYY, edu_eMM
								edu_idx		= arrAcademy(0,i)
								edu_nm		= arrAcademy(6,i)
								edu_agency	= arrAcademy(1,i)
								edu_sYY		= arrAcademy(2,i)
								edu_sMM		= arrAcademy(3,i)
								edu_eYY		= arrAcademy(4,i)
								edu_eMM		= arrAcademy(5,i)
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','','<%=edu_idx%>');">
										<div class="tt FWB lg mmColorBlue"><%=edu_nm%></div>
										<div class="st mmColorGray MT15">
											<span class="mmColorBlack FWB"><%=edu_agency%></span>
											<span class="ln mmColorGray"><%=edu_sYY%>년 <%=edu_sMM%>월~<%=edu_eYY%>년 <%=edu_eMM%>월</span>
										</div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=edu_idx%>','<%=rsubGubun%>');" title="삭제"></a>
									</div>
								</div>
							</div>
							<% Next %>
							<!-- 교육이수 내역 forEach : E-->
						</div>
					</div>
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1','');"><small class="MR10">+</small>교육이수 추가</a>
			</div>
			<!-- if 교육이수 내역:E -->
			<!-- else 교육이수 내역 :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">교육이수 내역</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">작성된 교육이수 내역이 없습니다.<br>등록해 주세요.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1','');"><small class="MR10">+</small>교육이수 내역 추가</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<% End If %>
			<!-- else 교육이수 내역 :E -->


		</div>
		<!-- 이력서등록수정관련:S -->
	</div>
</div>
<!-- //container -->