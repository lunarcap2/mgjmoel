<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
	function fn_userphone_div(obj) {
		if (obj.value.length >= 12) {
			var split_val = obj.value.split('-');
			if (split_val.length == 3) {
				$('#contents').find("#user_cell1").val(split_val[0]);
				$('#contents').find("#user_cell2").val(split_val[1]);
				$('#contents').find("#user_cell3").val(split_val[2]);
			}
		} else {
			$('#contents').find("#user_cell1").val("");
			$('#contents').find("#user_cell2").val("");
			$('#contents').find("#user_cell3").val("");
		}
	}

	function fn_useremail_div(obj) {
		if (obj.value.indexOf("@") >= 0) {
			var split_val = obj.value.split('@');
			$("#email1").val(split_val[0]);
			$("#email2").val(split_val[1]);
		} else {
			$("#email1").val("");
			$("#email2").val("");
		}
	}

	function fn_userbirth_div(obj) {
		if (obj.value.length == 10) {
			var split_val = obj.value.split('.');
			$("#birthYY").val(split_val[0]);
			$("#birthMM").val(split_val[1]);
			$("#birthDD").val(split_val[2]);
			if (split_val[0] < 2000) {
				$("#jumin_code").val("1");
			} else {
				$("#jumin_code").val("3");
			}
		} else {
			$("#birthYY").val("");
			$("#birthMM").val("");
			$("#birthDD").val("");
			$("#jumin_code").val("");
		}
	}

	// 사진 등록/삭제
	function fn_photo(val){
		if(val == 'reg') {
			$('#frm_resume').attr('action', '/my/resume/photo_write_T.asp');
			$('#frm_resume').submit();
		}
		else {
			if(confirm('입사지원 완료된 지원서를 포함한\n모든 지원서에 등록된 사진이 일괄 삭제됩니다.\n등록된 지원서 사진을 삭제하시겠습니까?')) {
				$('#frm_resume').attr('action', '/my/resume/photo_del.asp');
				$('#frm_resume').submit();
			}
		}
	}
</script>

<!-- container -->
<div id="contents" class="sub_page">
	<input type="hidden" id="user_photo" name="user_photo" value="<%=Replace(p_userPhoto, "/files/mypic/", "")%>">
	<input type="hidden" id="birthYY" name="birthYY" value="<%=p_birthYY%>">
	<input type="hidden" id="birthMM" name="birthMM" value="<%=p_birthMM%>">
	<input type="hidden" id="birthDD" name="birthDD" value="<%=p_birthDD%>">
	<input type="hidden" id="jumin_code" name="jumin_code" value="<%=p_jumin_code%>">
	<input type="hidden" id="user_cell1" name="user_cell1" value="<%=p_phone1%>">
	<input type="hidden" id="user_cell2" name="user_cell2" value="<%=p_phone2%>">
	<input type="hidden" id="user_cell3" name="user_cell3" value="<%=p_phone3%>">
	<input type="hidden" id="email1" name="email1" value="<%=p_email1%>">
	<input type="hidden" id="email2" name="email2" value="<%=p_email2%>">
	<!-- <input type="hidden" id="resume_title" name="resume_title" value="<%=p_userName%>님의 이력서입니다."> -->
	<input type="hidden" id="address" name="address" value="<%=p_address%>">

	<div class="contents">
		<!-- 이력서등록수정관련:S -->
		<div class="mmResumeWrap">
			<div class="profileCreate MT50">
				<div class="innerWrap">

					<div class="profileCreateTop TXTC">
						<div class="mmThumb lg marginAuto">
							<div class="mmThumbInner">
								<img src="<%=p_userPhotoURL%>" alt="">
							</div>
						</div>
						<a href="javascript:;" class="mmBtns blue2 md bold MT20" onclick="fn_photo('reg');"><small class="MR10">+</small><%=p_imgbtn%></a>

						<% If p_userPhoto <>"" Then %>
						<a href="javascript:;" class="mmBtns gray md outline bold MT20" onclick="fn_photo('del');">사진삭제</a>
						<% End If %>
					</div>
					<div class="profileCreateCont MT30">

						<div class="mmLstArea tp2">
							<ul class="mmlstUl">

								<li class="mmLstTp ">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">제목</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<input type="text" id="resume_title" name="resume_title" placeholder="제목을 입력해 주세요." value="<%=p_resumeTitle%>">
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
								<li class="mmLstTp ">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">이름</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<input type="text" id="userName" name="userName" placeholder="이름을 입력해 주세요." value="<%=p_userName%>">
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
								<li class="mmLstTp ">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">휴대폰</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<input type="text" id="user_cell" name="user_cell" placeholder="휴대폰을 입력해 주세요." value="<%=p_phone%>" onkeyup="numCheck(this, 'int'); changePhoneType(this); fn_userphone_div(this);" maxlength="13">
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
								<li class="mmLstTp ">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">이메일</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<input type="text" id="email" name="email" placeholder="이메일을 입력해 주세요." value="<%=p_email%>" onkeyup="fn_useremail_div(this);" maxlength="50">
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
								<!--
								<li class="mmLstTp ">
									<div class="inner">
										<div class="txts">
											<span class="lb">성별</span>
											<div class="tt">
												<select class="fnCustomSelect">
													<option selected value="">선택해주세요</option>
													<option value="남성">남성</option>
													<option value="여성">여성</option>
												</select>
											</div>
										</div>
									</div>
								</li>
								-->
								<li class="mmLstTp ">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">생년월일</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<input type="text" id="birth" name="birth" placeholder="생년월일을 입력해 주세요.(ex. YYYYMMDD)" value="<%=p_birth%>" onkeyup="numCheck(this, 'int'); changeBirthType(this); fn_userbirth_div(this);" maxlength="10">
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
								<li class="mmLstTp paddingRight">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">주소</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<input type="text" id="address_main" name="address_main" placeholder="주소를 입력해 주세요." value="<%=p_address%>" readonly>
													</div>
												</div>
											</div>
											<a href="javascript:;" class="mmBtns gray sm normalRadius bold" onclick="openPostCode('','address', 'address_main');">검색</a>
										</a>
									</div>
								</li>
								<li class="mmLstTp ">
									<div class="inner">
										<a href="javascript:;" class="txts">
											<span class="lb">간략소개</span>
											<div class="tt">
												<div class="mmCmmInput">
													<div class="ip">
														<textarea class="resume_tt" id="self_intro" name="self_intro" placeholder="인사담당자의 눈길을 끌 수 있는 간략한 자기소개를 작성해보세요 (5줄 이내로 권장)"><%=p_selfIntro%></textarea>
													</div>
												</div>
											</div>
										</a>
									</div>
								</li>
							</ul>
						</div>

						<div class="mmBtnsWrap TXTC MT60">
							<% If rtype = "C" Then %>
							<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save2();">저장하기</a>
							<% Else %>
							<a href="javascript:;" class="mmBtns navy FWB" onclick="fn_resume_save_imsi();">저장하기</a>
							<% End If %>
						</div>

					</div>

				</div>
			</div>
		</div>
		<!-- 이력서등록수정관련:S -->
	</div>
</div>
<!-- //container -->
