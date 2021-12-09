<!-- container -->
<div id="contents" class="sub_page">
	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<!-- if 자격증 내역:S -->
			<% If isArray(arrLicense) Then %>
			<div class="carrList MT40">
				<div class="innerWrap">
					<div class="mmTit borderBottom"> 자격증 내역 </div>
					<div class="mmLstArea tp3">
						<div class="mmlstUl">
							<!-- 자격증 내역 forEach : S-->
							<%
							For i=0 To UBound(arrLicense,2)
								Dim lic_idx, lic_nm, lic_agency, lic_DT
								lic_idx		= arrLicense(0,i)
								lic_nm		= arrLicense(1,i)
								lic_agency	= arrLicense(2,i)
								lic_DT		= arrLicense(3,i) & "년 " & arrLicense(4,i) & "월"
							%>
							<div class="mmLstTp paddingRight">
								<div class="txts">
									<a href="javascript:;" onclick="fn_detail('','','<%=lic_idx%>');">
										<div class="tt FWB lg">
											<%=lic_nm%>
											<span class="ln mmColorBlue"><%=lic_agency%></span>
											
										</div>
										<div class="st mmColorGray MT15">
											<span class="mmColorBlack FWB">취득</span>
											<%=lic_DT%>
										</div>
									</a>

									<div class="right">
										<a href="#;" class="mmIcoDelBtns" onclick="fn_del('','<%=lic_idx%>','<%=rsubGubun%>');" title="삭제"></a>
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
				<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_move('1','');"><small class="MR10">+</small>자격증 추가</a>
			</div>
			<!-- if 경력사항:E -->
			<!-- else 경력사항 :S -->
			<% Else %>
			<div class="mmResumeNoResult MT40">
				<div class="innerWrap">
					<div class="mmTit">자격증 내역</div>
					<div class="noResultBox MT20">
						<div class="inner">
							<div class="txts">작성된 자격증 내역이 없습니다.<br>등록해 주세요.</div>
							<div class="mmBtnsWrap MT30">
								<a href="javascript:;" class="mmBtns blue2 FWB" onclick="fn_move('1','');"><small class="MR10">+</small>자격증 내역 추가</a>
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