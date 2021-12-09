<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<!-- if 수상내역:S -->
			<% If isArray(arrPrize) Then %>
			<div class="carrList MT40">
				<div class="innerWrap">
					<div class="mmTit borderBottom"> 수상내역 </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- 수상내역 forEach : S-->
							<%
							For i=0 To UBound(arrPrize,2)
								Dim awa_idx, awa_nm, awa_agency, awa_dt
								awa_idx		= arrPrize(0,i)
								awa_nm		= arrPrize(2,i)
								awa_agency	= arrPrize(1,i)
								awa_dt		= arrPrize(3,i) & "년 " & arrPrize(4,i) & "월"
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','','<%=awa_idx%>');">
										<div class="tt FWB lg mmColorBlue"><%=awa_nm%></div>
										<div class="st mmColorGray MT15">
											<span class="mmColorBlack FWB"><%=awa_agency%></span>
											<span class="ln mmColorGray"><%=awa_dt%></span>
										</div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=awa_idx%>','<%=rsubGubun%>');" title="삭제"></a>
									</div>
								</div>
							</div>
							<% Next %>
							<!-- 수상내역 forEach : E-->
						</div>
					</div>
				</div>
			</div>
			<div class="mmBtnsWrap TXTC MT40">
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1','');"><small class="MR10">+</small>수상내역 추가</a>
			</div>
			<!-- if 경력사항:E -->
			<!-- else 경력사항 :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">수상내역</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">작성된 수상내역이 없습니다.<br>등록해 주세요.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1','');"><small class="MR10">+</small>수상내역 추가</a>
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