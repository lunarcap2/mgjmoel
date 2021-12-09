$(function() {

	$(document).ready(function() {
		tabFnc();//탭
		accordionFnc();//아코디언
		popUp();//팝업
        fileboxFnc();//파일박스
        selectboxFnc();//셀렉트박스
        checkboxFnc();//체크박스.
        radioboxFnc();//라디오박스
		disableFnc();//비활성시키기2019-10-10
		ckhAll();//체크박스 전체선택

		if ($('.datepicker').length > 0) useDatePicker();//달력
	});

	tabFnc = function(){
		//협력사 소개페이지에서 사용하지 않기 위해
		if(window.location.pathname != "/partner/list.asp") {
			$(".tab_content").hide();
			$(".tabs li:first").addClass("on").show();
			$(".tab_content:first").show();
		}

		$(".tabs li").click(function() {
			$(".tabs li").removeClass("on");
			$(this).addClass("on"); 
			$(".tab_content").hide();
			var activeTab = $(this).find("a").attr("href");
			$(activeTab).fadeIn();
			return false;
		});
	}

	tabDiv = function (obj, obj1, obj2) { //탭메뉴 ex) tabDiv(this,'.result','.tab1');
		var _this = $(obj);
		var _tab = _this.parent('li')
		var _index = _tab.index()
		var _areaN = $(obj1)
		var _area = $(obj2)

		_tab.addClass('on').siblings("li").removeClass("on")
		_areaN.css("display","block");
		_area.css("display","none");
	}//채용공고 탭

	accordionFnc = function(){
		$(".acco li a").click(function(){
			$(this).addClass('on');
			$(this).next().slideToggle(300);
			$(".acco li a").not(this).next().slideUp(300);
			$(".acco li a").not(this).removeClass('on');
			return false;
		});
		//$("ul li a").eq(0).trigger("click");
	}

	popUp = function(){//레이어팝업*/
		$openPop = $(".pop");
		$closePop = $(".pop_up .btn.close, .pop_up .dim, .pop_up .pop_close");

		$openPop.click(function(){
			var popHref = $(this).attr("href");

			if($(".pop_up .dim").is(':visible') == true ){ 
				$(popHref).show().find(".dim").addClass('plural').show();
			}
			$(popHref).show().find(".dim").show();
		});

		$closePop.click(function(){
			$(this).parents(".pop_up").hide().find(".dim").removeClass('plural').hide();
		});

	}//레이어팝업*/

    function fileboxFnc() {//찾아보기
        $('.filebox input:file').each(function (index, value) {
            $(this).prev().val($(this).val());
        }).bind('click change', function () {
            $(this).prev().val($(this).val());
        }).bind('focus', function () {
            $(this).prev().addClass('on');
        }).bind('blur', function () {
            $(this).prev().removeClass('on');
        });
    }//찾아보기

    function numeric(value) {//문자제거
        return value.toString().replace(/[^\d$]/gi, "");
    }//인풋전화번호 체크    
    
    selectboxFnc = function (obj) {//셀렉트박스
        var _select = null
        if (!obj)
            _select = $('.selectbox select');
        else
            _select = ($(obj).find('.selectbox select').length > 0) ? $(obj).find('.selectbox select') : $(obj);
        _select.unbind().each(function (index, value) {
            $(this).prev().html($(this).children('option:selected').text());
            if ($(this).val() == 'direct') {//직접입력
                $(this).parent().prev().css('display', 'inline');
            }
        }).bind('change keyup', function (evt) {
            $(this).prev().html($(this).children('option:selected').text());
            if ($(this).prev().is('.ellipsis')) $(this).prev().ellipsis();//글줄임 설정
            if ($(this).find("option[value='direct']").length == 1) {//직접입력 설정
                if ($(this).val() == 'direct') {
                    $(this).parent().prev().css('display', 'inline');
                    if (evt.type == 'change') $(this).parent().prev().focus();//직접입력 포커스 이동
                } else {
                    $(this).parent().prev().css('display', 'none');
                }
            }
        }).bind('focus', function () {
			$(this).parents('.selectbox').addClass('on');

        }).bind('blur change', function () {
			if ($(this).val() != "" ) {
				$(this).parents('.selectbox').addClass('on');
			} else {
				$(this).parents('.selectbox').removeClass('on');
			}
			//$(this).prev().removeClass('on');
        });
    }//셀렉트박스

    checkboxFnc = function () {//체크박스
        var _chk = $('.chk').parent();
        _chk.each(function() {
            if ($(this).find('input').is(':checked')) {
                $(this).removeClass('off').addClass('on');

            } else {
                $(this).removeClass('on').addClass('off');
            }
        }).click(function() {
            if ($(this).find('input').is(':checked')) {
                $(this).removeClass('off').addClass('on');
            } else {
                $(this).removeClass('on').addClass('off');
            }
        });
    }//체크박스

    radioboxFnc = function () {//라디오박스

		//비활성화 클래스명
		$(".disable").attr("readonly",true);
		$(".disable").attr("disabled",true);

        var _rdi = $('.rdi').parent();
        _rdi.unbind().each(function() {
            if ($(this).find('input').is(':checked')) {
                $(this).removeClass('off').addClass('on');
            }else if ($(this).find('input').is('[disabled=disabled]'))//비활성화시킬때
			{
				$(this).find("span").css({'color':'#a8a8a8','cursor':'default'});
				$(this).find('input').attr('name','disable')
			} else {
                $(this).removeClass('on').addClass('off');
            }
        }).bind('click', function() {
            var _name = $(this).find('input').attr('name');
            var _radio = $('label input[name$='+_name+']');
            var _index = _radio.parent().index(this);
            _radio.each(function(index, value) {
                if (_index == index) {
                    $(this).checked = true;
                    $(this).parent().removeClass('off').addClass('on');
					if ($(this).is('[disabled=disabled]'))
					{
						$(this).parent().removeClass('on');
					}
                } else {
                    $(this).checked = false;
                    $(this).parent().removeClass('on').addClass('off');
                }
            });
        });
        
        $('input:radio').click(function() {
            $('input:radio[name='+$(this).attr('name')+']').parent().removeClass('on');
            $(this).parent().addClass('on');
        });	
    }//라디오박스
	
	moreFnc = function() {//주간 더보기
		var _obj = $('.weekly-area .more a');
		_obj.bind('click', function() {
			var _more = $(this).parent();
			_more.prev().css('max-height','none');
			_more.find('a:first-child').hide();
			_more.append('<a class="close" href="#">접기</a>').bind('click', function() {
				_more.prev().removeAttr('style');
				_more.find('a:first-child').show();
				_more.find('a.close').remove();
				return false;
			});
			return false;
		});
	}//주간 더보기

	disableFnc = function (obj, param) {//비활성
		var _obj = $(obj);
		var _input = _obj.find('input.txt, input.rdi, input.chk, textarea.area');
		switch(param) {
			case 'disable':
				_obj.addClass('disable');
				if (_input.length > 0) _input.attr('readonly','readonly');
				if (_input.length > 0) _input.attr('disabled','disabled');
				selectboxFnc();
				break;
			case 'active':
				_obj.removeClass('disable');
				if (_input.length > 0) _input.removeAttr('readonly');
				break;
			case 'check'://체크박스
				if ((_obj.attr('class')) ? (_obj.attr('class') == 'disable') : false) {
					_obj.removeClass('disable');
					if (_input.length > 0) _input.removeAttr('readonly');
				} else {
					_obj.addClass('disable');
					if (_input.length > 0) _input.attr('readonly','readonly');
				}
				break;
			default:
				return false;
		}
	}//비활성

	ckhAll = function() {
		var $boxAll = $('.dd ul .checkbox.all');
		var $boxes = $('.dd ul');

		/* 전체선택 */
		$boxAll.change(function(){
			var $boxAllchk = $(this).is(":checked");
			if ( $boxAllchk == true ) {
				$(this).parents('dd').find('ul input').attr("checked", true)
				.parent().removeClass('off').addClass('on');
				$(this).parents('dd').find('ul input').prop("checked", true)
				.parent().removeClass('off').addClass('on');
			}else {
				$(this).parents('dd').find('ul input').attr("checked", false)
				.parent().removeClass('on').addClass('off');
				$(this).parents('dd').find('ul input').prop("checked", false)
				.parent().removeClass('on').addClass('off');
			}
		});


		/* 하위 전체 선택시 전체버튼 선택 */
		$boxes.change(function(){
			var bchk = $(this).find("input[type='checkbox'].chk");
			if(bchk.length == bchk.filter(":checked").length){
				$(this).parents('dd').find($boxAll).attr("checked", true)
				.parent().removeClass('off').addClass('on');
				$(this).parents('dd').find($boxAll).prop("checked", true)
				.parent().removeClass('off').addClass('on');
			}else {
				$(this).parents('dd').find($boxAll).attr("checked", false)
				.parent().removeClass('on').addClass('off');
				$(this).parents('dd').find($boxAll).prop("checked", false)
				.parent().removeClass('on').addClass('off');
			}
		});	
	}//전체선택 

	useDatePicker = function() {
	
		$(document).ready(function() {

			//datepicker 한국어로 사용하기 위한 언어설정
			$.datepicker.setDefaults($.datepicker.regional['ko']);     
		
			// Datepicker            
			$(".datepicker").datepicker({
				dateFormat: "yy-mm-dd",
				dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
				monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				changeMonth: true,
				changeYear: true,
				showButtonPanel: true,
				closeText: '닫기',
				currentText: '오늘',
				onClose : function ( selectedDate ) {
					var eleId = $(this).attr("id");
					var optionName = "";
					if(eleId.indexOf("StartDate") > 0) {
						eleId = eleId.replace("StartDate", "EndDate");
						optionName = "minDate";
					} else {
						eleId = eleId.replace("EndDate", "StartDate");
						optionName = "maxDate";
					}
					$("#"+eleId).datepicker( "option", optionName, selectedDate);        
					$(".searchDate").find(".chkbox2").removeClass("on"); 

					var $dates = $('.start_date, .end_date').datepicker();
					$('.datePick .reset').on('click', function () {	
						 $dates.val('').datepicker('option', {minDate: null, maxDate: null});
					});
				}
				
			}); 

			$.datepicker._gotoToday = function(id) { 
				$(id).datepicker('setDate', new Date()).datepicker('hide').blur(); 
			};

			$(".dateclick").dateclick();    // DateClick
			$(".searchDate").schDate();        // searchDate
			
		});   

		// Search Date
		jQuery.fn.schDate = function(){
			var $obj = $(this);
			var $chk = $obj.find("input[type=radio]");
			$chk.click(function(){                
				$('input:not(:checked)').parent(".chkbox2").removeClass("on");
				$('input:checked').parent(".chkbox2").addClass("on");                    
			});
		};

		// DateClick
		jQuery.fn.dateclick = function(){
			var $obj = $(this);
			$obj.click(function(){
				$(this).parent().find("input").focus();
			});
		}
	}// 달력

	function fn_pop_show() {
		$('.popup, .pop_dim').show(); 
		$poHeight = $('.popup').outerHeight();
		docWidth = $(document).width(),
		winHeight = $(window).height();
		if ($poHeight > winHeight/*&& $poWidth < docWidth*/) {
			$('.popup').css("top", Math.max(0, $(window).scrollTop()));
			$('.popup').css({
				marginTop:0});
				//,marginLeft:-$poWidth / 2});
			return this;
		}
		else{
			$('.popup').css("top", Math.max(0,  $(window).scrollTop() + jQuery(window).height() / 2) + "px"); 
			$('.popup').css({
				marginTop: -$poHeight / 2});
				//,marginLeft: -$poWidth / 2});
		   return this;
		}
	}

	/* 2020.12.09 */
	view_layer = function (_val){
		var popUp = $("#pop_area_question_" + _val);
		popUp.show().find(".pop_dim").show();
	}

	view_layer_hide = function (_val) {
		var popUp = $("#pop_area_question_" + _val);
		popUp.show().hide(".pop_dim").hide();
	}

	

});
	
