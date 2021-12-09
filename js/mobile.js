/* prototype 동시사용 */
jQuery.noConflict();

/* 2016-03-09 V2 skydown@career.co.kr */
var tabFnc, displayFnc, selectboxFnc, inputFnc, inputcheckFnc, checkboxFnc, radioboxFnc;
(function ($) {
	$(function () {
		$(document).ready(function() {
			selectboxFnc();//셀렉트박스
			inputFnc();//인풋박스
			checkboxFnc();//체크박스
			radioboxFnc();//라디오박스
			fadeChange();//메인비주얼
			topFnc();
			tabInit();
			var timer = setInterval("fadeChange()",4000);//메인비주얼 순환
			if($('input.value').length > 0) $('input.value').inputcheckFnc();//인풋텍스트 체크박스
			//if($('#gnb').length > 0) swiperSub('#gnb'); //GNB
			if($('.directionsWrap').length > 0) directionsFnc(); //익스프레스배너
		});//ready

		function loaded() {
			window.scrollTo(0, 1);
		}

		function directionsFnc() {//익스프레스배너
			var _obj = $('.container');
			var _directionsNew = _obj.find('.directionsWrap');
			_directionsNew.find('ul').append(_directionsNew.find('li:first-child').clone());
			directionsRollFnc(_directionsNew, 0);
		}
		var _directionsWrap = [];
		var _directionsUl = [];
		var _directionsLi = [];
		var _directionsTimer = [];
		var _directionsUp = [];
		var _directionsCnt = [];
		function directionsRollFnc(obj, index) {
			_directionsWrap[index] = obj;
			_directionsUl[index] = obj.find('ul');
			_directionsLi[index] = obj.find('li');
			_directionsUp[index] = obj.find('li').height();
			_directionsCnt[index] = 0;
			var _due = 7000;
			var _speed = 500;
			directionsSet = {
				up : function(index) {
					_directionsCnt[index]++;
					if(_directionsCnt[index] < _directionsLi[index].length -1) {
						_directionsUl[index].animate({
							top: '-'+_directionsUp[index] *_directionsCnt[index] +'px'
						},_speed);
					} else {
						_directionsUl[index].animate({
							top: '-'+_directionsUp[index] *_directionsCnt[index] +'px'
						}, _speed, function() {
							_directionsCnt[index] = 0;
							_directionsUl[index].css('top', 0);
						});
					}
				},
				start : function(index) {
					if(!_directionsTimer[index]) _directionsTimer[index] = setInterval('directionsSet.up('+ index +')', _due);
				},
				stop : function(index) {
					clearInterval(_directionsTimer[index]);
					_directionsTimer[index] = null;
				}
			};
			if(_directionsLi[index].length > 2) {//한개 이상일때 롤링
				directionsSet.start(index);
				_directionsWrap[index].mouseover(function() {
					directionsSet.stop(index);
				});
				_directionsWrap[index].mouseout(function() {
					for(var i = 0; i < _directionsWrap.length; i++) {//타이머 싱크
						directionsSet.stop(i);
						directionsSet.start(i);
					}
				});
			}
		}//익스프레스배너


		//상단메뉴 고정
		$(window).scroll(function(){
			var _top = $(this).scrollTop();
			var _start = ($(".container section").offset().top);
			var _gnb = $("#gnb");
			if (_top>_start){
				_gnb.addClass('fixed');
			}else {
				_gnb.removeClass('fixed');
			}
		});

		fadeChange = function (){//메인비주얼
			var now_img, next_img;
			now_img = $(".imgArea img:eq(0)");
			next_img = $(".imgArea img:eq(1)");
			next_img.addClass("on").css("opacity",0).animate({"opacity":1},1000, function(){
				$(".imgArea").append(now_img);//콜백
				now_img.removeClass("on");
			});
		};

		//자주묻는질문 리스트
		$('.qna_list > dt').click(function(){
			$('.qna_list dt').removeClass('over');
			$(this).addClass('over');
			$(this).next('dd').show().siblings('dd').hide();
			return false;
		});

		function topFnc(){
			$(".goTop").hide(); // 탑 버튼 숨김
			$(window).scroll(function () {
				if ($(this).scrollTop() > 100) { // 스크롤 내릴 표시
					$('.goTop').fadeIn();
				} else {
					$('.goTop').fadeOut();
				}
			});
			$('.goTop').click(function () {
				$('body,html').animate({
					scrollTop: 0
				}, 300);  // 탑 이동 스크롤 속도
				return false;
			});
		};

		tabFnc = function (obj, group, idx) {//탭메뉴
			$(group).each(function (index, value) {
				if(idx == index) {
					$(group).eq(index).show();
					$(obj).parents('ul').find('li').eq(index).addClass('on');
				} else {
					$(group).eq(index).hide();
					$(obj).parents('ul').find('li').eq(index).removeClass('on');
				}
			});
		}//탭메뉴

		displayFnc = function (obj, param) {//디스플레이
			if ($(obj).length == 0) return false;
			var _obj = $(obj);
			switch(param) {
				case 'block':
					if (_obj.get(0).tagName == 'TABLE') {
						_obj.css('display','table');
					} else if (_obj.get(0).tagName == 'TR') {
						_obj.css('display','table-row');
					} else {
						_obj.css('display','block');
					}
					break;
				case 'none':
					_obj.css('display','none');
					break;
				case 'check':
					_obj = $(obj).parent().next();//다음항목 검색
					if ($(obj).is(":checked") == true || _obj.css('display') == 'none')
						_obj.css('display','block');
					else
						_obj.css('display','none');
					break;
				default:
					return false;
			}
			return false;
		};//디스플레이

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
				$(this).prev().addClass('on');
			}).bind('blur', function () {
				$(this).prev().removeClass('on');
			});
		}//셀렉트박스

		inputFnc = function (obj) {//인풋박스
			var _this, _tmp;
			if (!obj)
				_this = $('input.txt, textarea.area, span.direct > input');
			else
				_this = $(obj).find('input.txt, textarea.area, span.direct > input');
			_this.unbind('focus blur').each(function (index, value) {
				if ($(this).val() != null && $(this).val() != '') $(this).addClass('bg');//배경이미지 초기화
				else $(this).removeClass('bg');
			}).bind('focus', function () {
				_tmp = this.value;
				$(this).addClass('on');
			}).bind('blur', function () {
				$(this).removeClass('on');
			});
		}//인풋박스

		$.fn.inputcheckFnc = function(index) {//인풋텍스트 체크
			return this.each(function(index, value) {
				var _default = $(this).attr('default');
				var _type = $(this).attr('type');
				if(this.value == '' || this.value == _default) {
					$(this).attr('value', _default);
					$(this).prop('type', 'text');
				} else {
					$(this).removeClass('value');
					$(this).prop('type', _type);
				}
				$(this).bind('focus', function() {
					if(this.value == _default) {
						this.value = '';
						this.type = _type;
					}
					$(this).removeClass('value')
				}).bind('blur', function() {
					if(this.value == '' || this.value == _default) {
						this.value = _default;
						this.type = 'text';
						$(this).addClass('value');
					}
				});
			});
		};//인풋텍스트 체크

		$.event.special.textchange = {//Detecting Text Changes
			setup: function (data, namespaces) {
			  $(this).data('lastValue', this.contentEditable === 'true' ? $(this).html() : $(this).val());
				$(this).bind('keyup.textchange', $.event.special.textchange.handler);
				$(this).bind('cut.textchange paste.textchange input.textchange', $.event.special.textchange.delayedHandler);
			},
			teardown: function (namespaces) {
				$(this).unbind('.textchange');
			},
			handler: function (event) {
				$.event.special.textchange.triggerIfChanged($(this));
			},
			delayedHandler: function (event) {
				var element = $(this);
				setTimeout(function () {
					$.event.special.textchange.triggerIfChanged(element);
				}, 25);
			},
			triggerIfChanged: function (element) {
			  var current = element[0].contentEditable === 'true' ? element.html() : element.val();
				if (current !== element.data('lastValue')) {
					element.trigger('textchange',  [element.data('lastValue')]);
					element.data('lastValue', current);
				}
			}
		};//Detecting Text Changes

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
			var _rdi = $('.rdi').parent();
			_rdi.each(function() {
				if ($(this).find('input').is(':checked')) {
					$(this).removeClass('off').addClass('on');
					$(this).find('input').prop('checked', 'checked');
				} else {
					$(this).removeClass('on').addClass('off');
					$(this).find('input').removeProp('checked');
				}
			}).click(function() {
				var _name = $(this).find('input').attr('name');
				var _radio = $('label input[name$='+_name+']');
				var _index = _radio.parent().index(this);
				_radio.each(function(index, value) {
					if (_index == index) {
						//$(this).checked = true;
						$(this).prop('checked', 'checked');
						$(this).parent().removeClass('off').addClass('on');
					} else {
						//$(this).checked = false;
						$(this).removeProp('checked');
						$(this).parent().removeClass('on').addClass('off');
					}
				});
			});
		}//라디오박스
	});//$
})(jQuery);

/* skydown@career.co.kr */
var _bodyHeight;
var _minHeight;
var _setTimeout;
jQuery(window).load(function() {
	_bodyHeight = jQuery('.container')[0].offsetHeight
	_minHeight = 350;

	setTimeout(loaded, 100);

	//screenHeight();
	offsetHeight();
	historyBack();
	goHome();
	goPcver();
});

jQuery(window).resize(function() {
	//console.log('window.resize');
	setTimeout(offsetHeight, 100);
});

function loaded(){//주소창 자동 가리기
	window.scrollTo(0, 1);
}
function screenHeight() {
	jQuery('.container ').css({'min-height':screen.height -57});
	jQuery(window).resize(function() {
		jQuery('.container ').css({'min-height':screen.height -57});
	});
}
function offsetHeight() {//하단 위치 조절
	//console.log('_bodyHeight: '+_bodyHeight +' / _minHeight: ' + _minHeight);
	//alert('_bodyHeight: '+_bodyHeight +' / _minHeight: ' + _minHeight);
	jQuery('.subpage section').css('min-height',_minHeight);
	if(jQuery.browser.mobile) {
		//console.log('모바일 기기 입니다!');
		if (window.orientation == 0) {
			//console.log("세로모드 입니다");
			if(_bodyHeight < _minHeight) {
				jQuery('html, body').attr('style','height:auto');
			}
		} else {
			//console.log("가로모드 입니다");
			jQuery('html, body').attr('style','height:auto');
		}
	} else {
		//console.log('모바일 기기가 아닙니다!');
		if(_bodyHeight < _minHeight) {
			jQuery('html, body').attr('style','height:100%');
		}
	}
}
function tabInit() {//탭메뉴 초기화
	var _tabArea = jQuery('ul.tabArea');
	var _tab =  jQuery('ul.tabArea a.tab');
	_tab.click(function() {
		_tabArea.attr('class', 'tabArea tabArea'+ jQuery(this).parent().attr('class').slice(-1));
	});
}
function historyBack() {//공통 이전 페이지로 가기
	if(jQuery('.goBack').attr('class') != undefined ) {
		jQuery('.goBack').click(function() {
			history.back(-1);
			return false;
		});
	}
}
function goHome() {//공통 홈으로 가기
	if(jQuery('.goHome').attr('class') != undefined ) {
		jQuery('.goHome').click(function() {
			jQuery(location).attr('href','/');
			return false;
		});
	}
}
function goPcver() {//공통 PC버전 가기
	//var _footerA = jQuery('body > .container > section > .pcver > a');
	//_footerA.click(function() {
	//	window.open('http://hkjobfair.career.co.kr/', '_blank');
	//	return false;
	//});
}


/** 모바일 기기 체크
 * jQuery.browser.mobile (http://detectmobilebrowser.com/)
 * jQuery.browser.mobile will be true if the browser is a mobile device
 **/
(function(a){jQuery.browser.mobile=/android.+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|e\-|e\/|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\-|2|g)|yas\-|your|zeto|zte\-/i.test(a.substr(0,4))})(navigator.userAgent||navigator.vendor||window.opera);
