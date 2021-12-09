<script type="text/javascript" src="https://job3.career.co.kr/js/cat_jc.js"></script>
<script type="text/javascript" src="https://job3.career.co.kr/js/cat_ct.js"></script>
<script type="text/javascript" src="/js/resume_jc.js"></script>
<script type="text/javascript" src="/js/resume_ct.js"></script>
<script type="text/javascript">
	// 업직종값 조건저장
	function fn_save_ctjc() {
		fn_save_jc();
		fn_save_ct();
	}
</script>

<div class="contents" style="padding-bottom: 0;">
	<!-- 이력서등록수정관련:S -->
	<div class="mmResumeWrap">
		<div class="resumCreateWrap">
			<div class="mmScrArea">
				<div class="mmTabs">
					<ul class="lst">
						<li class="tp fnTabsli active"><a href="#" class="txt" onclick="fn_append_jc();">직무(직종)</a></li>
						<li class="tp fnTabsli"><a href="#" class="txt" onclick="fn_append_ct();">산업(업종)</a></li>						
						<li class="tp fnTabsli "><a href="#" class="txt">키워드</a></li>
					</ul>
				</div>
				<!-- 직무(직종): S -->
				<div class="fnTabsDiv active">
					<div class="mmScrRow">
						<div class="mmScrCol6">
							<!--1차직종-->
							<ul id="col_ul_jc1" class="mmScrLst">
							</ul>
						</div>
						<div class="mmScrCol6">
							<!--2차직종-->
							<ul id="col_ul_jc2" class="mmScrLst">
							</ul>
						</div>
					</div>
				</div>
				<!-- 직무(직종): E -->
				<!-- 산업(업종): S -->
				<div class="fnTabsDiv">
					<div class="mmScrRow">
						<div class="mmScrCol6">
							<!--1차업종-->
							<ul id="col_ul_ct1" class="mmScrLst">
							</ul>
						</div>
						<div class="mmScrCol6">
							<!--2차업종-->
							<ul id="col_ul_ct2" class="mmScrLst">
							</ul>
						</div>
					</div>
				</div>
				<!-- 산업(업종): E -->
				<!-- 키워드검색 :S -->
				<div class="fnTabsDiv">
					<div class="innerWrap MB80">
						<!--3차직종-->
						<div id="col_ul_jc3">
						<%
						If isArray(jc_code_all) Then
							For i=0 To UBound(jc_code_all)
						%>
						<script>
							fn_jc3_set('<%=jc_code_all(i)%>','<%=getJobtype(jc_code_all(i))%>');
						</script>
						<%
							Next 
						End If
						%>
						</div>

						<!--3차업종-->
						<div id="col_ul_ct3">
						<%
						If isArray(ct_code_all) Then
							For i=0 To UBound(ct_code_all)
						%>
						<script>
							fn_ct3_set('<%=ct_code_all(i)%>','<%=getJobtype(ct_code_all(i))%>');
						</script>
						<%
							Next 
						End If
						%>
						</div>
					</div>
				</div>
				<!-- 키워드검색 :E -->
				<div class="mmHr"></div>
				<div class="mmScrBottom">
					<div class="innerWrap">
						<div class="mmBreadCom ">
							<div class="tp ">
								<span class="lb">직무</span>
								<div id="btm_category_jc" class="txts">
									<%
									If isArray(jc_code_all) Then
										For i=0 To UBound(jc_code_all)
									%>
									<div class="tt">
										<span><%=getJobtype(jc_code_all(i))%></span>
										<button class="clBtn" name="category_out_jc2" value="<%=jc_code_all(i)%>" onclick="fn_jckey2_del('<%=jc_code_all(i)%>')" title="삭제"></button>
										<span class="mmColorBlue2">></span>
										<span name="span_set_jc3">
											<%
											If isArray(arrJcKwd) Then
												For ii=0 To UBound(arrJcKwd, 2)
													If jc_code_all(i) = Left(arrJcKwd(0, ii), 4) Then
											%>
											<div class="tt">
												<span class="mgbInner"><%=arrJcKwd(1, ii)%></span>
												<button class="clBtn" name="category_out_jc3" value="<%=arrJcKwd(0, ii)%>" onclick="fn_jckey3_del('<%=arrJcKwd(0, ii)%>')" title="삭제"></button>
											</div>
											<%
													End If
												Next
											End If
											%>
										</span>
									</div>
									<%
										Next
									End If
									%>
								</div>
							</div>

							<div class="tp ">
								<span class="lb">산업</span>
								<div id="btm_category_ct" class="txts">
									<%
									If isArray(ct_code_all) Then
										For i=0 To UBound(ct_code_all)
									%>
									<div class="tt">
										<span><%=getJobtype(ct_code_all(i))%></span>
										<button class="clBtn" name="category_out_ct2" value="<%=ct_code_all(i)%>" onclick="fn_ctkey2_del('<%=ct_code_all(i)%>')" title="삭제"></button>
										<span class="mmColorBlue2">></span>
										<span name="span_set_ct3">
											<%
											If isArray(arrCtKwd) Then
												For ii=0 To UBound(arrCtKwd, 2)
													If ct_code_all(i) = Left(arrCtKwd(0, ii), 4) Then
											%>
											<div class="tt">
												<span class="mgbInner"><%=arrCtKwd(1, ii)%></span>
												<button class="clBtn" name="category_out_ct3" value="<%=arrCtKwd(0, ii)%>" onclick="fn_ctkey3_del('<%=arrCtKwd(0, ii)%>')" title="삭제"></button>
											</div>
											<%
													End If
												Next
											End If
											%>
										</span>
									</div>
									<%
										Next
									End If
									%>
								</div>
							</div>
						</div>
						<div class="mmBtnsWrap TXTC MT35">
							<a href="javascript:;" class="mmBtns navy bold" onclick="fn_hope(''); fn_save_ctjc();"><small class="MR10">+</small>키워드 선택완료</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 이력서등록수정관련:S -->
</div>