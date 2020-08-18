/*******************************************************
	setdef(str)	 :	POPUP을	위한 DEFAULT SET STR= "master,836,200"

	check_function 각각의 page에 define	한다..
	insert_chk():	new,
	modify_chk():	modify,
	value_chk()	:	save,search,execute,delete
	bset(str)	:	button 활성화기능 ("new,modify,delete,save,close,search,exe,
										help,logout")
	titleset(str):	검색 frame 에서	사용 한다.target_frame은 new 에서만 사용된다
					str	= "self_form,target_frame,target_url,del_url"
	bodyset(str):	action frame 에서 사용 한다.target_frame은 new 에서만 사용된다
					str	= "self_form,target_frame,target_url,del_url"
					str	= "self_form"
					str	= "self_form,del_url"
					str	= "self_form,target_frame,target_url"
	newsubmit(str):	검색 frame 에서	form을 submit할때 사용한다..
					str	= "self_form,target_frame,target_url"
	curset(asstr) :	current	frame 을 set 한다...
					str	= "frame,form" 
*******************************************************/
function bset(str) {
  parent.bset(str);
}

function setdef(str) {
  //POPUP을 위한 DEFAULT SET
  parent.setdef(str);
}
function newsubmit(str) {
  var temp = str.split(",");
  if (temp.length == 2) {
    parent.newsubmit(temp[0], temp[1]);
  } else {
    parent.titleset(self.name, temp[0], temp[1], temp[2]);
    parent.newsubmit(temp[1], temp[2]);
    if (temp.length == 4) {
      parent.setdel(temp[3]);
    }
  }
}
function titleset(str) {
  temp = str.split(",");
  parent.titleset(self.name, temp[0], temp[1], temp[2]);
  parent.newsubmit(temp[1], temp[2]);
  if (temp.length == 4) {
    parent.setdel(temp[3]);
  }
}
function bodyset(str) {
  //수정,삭제,저장을 위한	current_frame 과 new 룰	초기화 한다..
  temp = str.split(",");
  aslen = temp.length;
  if (aslen == 1) {
    parent.curset(self.name, temp);
  } else if (aslen == 2) {
    parent.curset(self.name, temp[0]);
    parent.setdel(temp[1]);
  } else if (aslen == 3) {
    parent.newsubmit(temp[1], temp[2]);
    parent.bodyset(self.name, temp[0], temp[1], temp[2], "0");
  } else {
    parent.newsubmit(temp[1], temp[2]);
    parent.bodyset(self.name, temp[0], temp[1], temp[2], temp[3]);
  }
}
function curset(asstr) {
  var temp = asstr.split(",");
  parent.curset(temp[0], temp[1]);
}

function srcset(str) {
  //검색 frame 을	set한다...
  /* str = src_frame,src_form	*/
  temp = str.split(",");
  parent.srcset(temp[0], temp[1]);
}

function targetset(str) {
  //new 에 사용하는 target_url
  parent.targetset(str);
}
function initurl(str) {
  //tab function 에서	init하는 url set
  parent.initurl(str);
}
function setinit(str) {
  //tab function 에서	사용...
  /**	arguments =	init_frame_name	 ,url **/
  parent.setinit(str);
}
function tabclear() {
  parent.tabclear();
}
/****************************************************************
    FUNCTION ID	: movepageNew2
    기	  능 : 목록의 한 행을 선택하면 넘어온 값들을 input text	에 저장하고	
               submit 한다.
    인	  수 : arg_flag	(true,false	submit() on/off
               arg_row_number (	현재클릭한 행번호 )
               values  ( 링크될	pk 들의	값	) ex) '2004,11007,04,1'
****************************************************************/

var agt = navigator.userAgent.toLowerCase();

function movepageNew2(arg_flag, arg_row_number, values) {
  var form1 = self.document.forms[0];
  var flength = form1.elements.length;
  var tvalue = values.split(",");
  var valueLength = tvalue.length;
  if (values == "") valueLength = 0;
  TdColorNew(arg_row_number);
  //리스트 2개 중 첫번째일때
  if ($("input[name='list_gubn']").val() == "1") {
    top.buttonFrame.frm1.init_indx2.value = arg_row_number; //current_page_display
  } else {
    top.buttonFrame.frm1.init_indx.value = arg_row_number; //current_page_display
  }
  for (var i = 0; i < valueLength; i++) {
    if (form1.elements[i] == undefined) {
      alert("HTML	INPUT 을 정의 하세요.." + i);
    } else {
      form1.elements[i].value = tvalue[i];
    }
  }
  if (form1.save_gubn == undefined) {
    alert("save_gubn 을	정의 하세요..");
  } else {
    form1.save_gubn.value = "2";
  }
  if (arg_flag == "true" || arg_flag == true) {
    if (parent.tab_flag == 1) {
      initurl(parent.taburl[parent.tab_current - 1]);
    }
    form1.submit();
  }
  return;
}

function checkEnter(formName) {
  //var	objForm	= document.forms[formName];
  if (formName == "40" || formName == "20") {
    parent.parent.buttonFrame.exe_check(4);
  } else if (formName == "frm2") {
    document.frm2.submit();
    return;
  } else if (event.keyCode == 13) {
    if (agt.indexOf("ie") != -1 || agt.indexOf("trident") != -1) {
      // IE
      parent.parent.buttonFrame.exe_check(4);
    }
  }
}
/************************************************
 <div =	"list">
 <table	 width="820">
 ..일때	viewDetail 을 body 에 사용가능 viewDetail 을 사용시 div 는 정의 되어야한다.
 ..
 </table>
 </div>
 ***********************************************/
function viewDetail(inopt) {
  if (inopt == false) {
    return;
  }
  var sObj2 = "";
  //리스트 2개 중 첫번째일때
  if ($("input[name='list_gubn']").val() == "1") {
    sObj2 = top.buttonFrame.frm1.init_indx2.value;
  } else {
    sObj2 = top.buttonFrame.frm1.init_indx.value;
  }
  var existObj = false;
  var autoform = autoForm();
  var tBody = document.getElementById("list");
  var agt = navigator.userAgent.toLowerCase();
  var cObj = "";

  //브라우저별에 따라서 자식노드위치가 달라진다(Table)
  if (agt.indexOf("msie 7.0") != -1 || agt.indexOf("msie 8.0") != -1) {
    //IE9미만이지만 쿼크모드일때
    if (document.documentMode == "5") {
      //Table
      cObj = tBody.firstChild;
    } else {
      //#text
      cObj = tBody.firstChild.nextSibling;
    }
  } else {
    //IE9이상이지만 쿼크모드일때
    if (document.documentMode == "5") {
      //Table
      cObj = tBody.firstChild;
    } else {
      //#text
      cObj = tBody.firstChild.nextSibling;
    }
  }

  if (sObj2 != "") {
    if (tBody != null && tBody != undefined) {
      existObj = true;
      if (agt.indexOf("msie 7.0") != -1 || agt.indexOf("msie 8.0") != -1) {
        if (document.documentMode == "5") {
          if (tBody.firstChild.rows[Number(sObj2) - 1] != undefined) {
            tBody.firstChild.rows[Number(sObj2) - 1].scrollIntoView(true);
            tBody.firstChild.rows[Number(sObj2) - 1].firstChild.click();
          }
        } else {
          if (
            tBody.firstChild.nextSibling.rows[Number(sObj2) - 1] != undefined
          ) {
            tBody.firstChild.nextSibling.rows[Number(sObj2) - 1].scrollIntoView(
              true
            );
            tBody.firstChild.nextSibling.rows[
              Number(sObj2) - 1
            ].firstChild.nextSibling.click();
          }
        }
      } else {
        if (document.documentMode == "5") {
          if (tBody.firstChild.rows[Number(sObj2) - 1] != undefined) {
            tBody.firstChild.rows[Number(sObj2) - 1].scrollIntoView(true);
            tBody.firstChild.rows[Number(sObj2) - 1].firstChild.click();
          }
        } else {
          if (
            tBody.firstChild.nextSibling.rows[Number(sObj2) - 1] != undefined
          ) {
            tBody.firstChild.nextSibling.rows[Number(sObj2) - 1].scrollIntoView(
              true
            );
            tBody.firstChild.nextSibling.rows[
              Number(sObj2) - 1
            ].firstChild.nextSibling.click();
          }
        }
      }
    }
    //좌측메뉴 클릭시 초기화되게 수정(/main/js/left_menu.js)
    //if($("input[name='list_gubn']").val() == "1"){
    //top.buttonFrame.frm1.init_indx2.value = "";
    //}else{
    //top.buttonFrame.frm1.init_indx.value = "";
    //}
  }
  if (!existObj) {
    var chk = "";
    if (agt.indexOf("msie 7.0") != -1 || agt.indexOf("msie 8.0") != -1) {
      if (document.documentMode == "5") {
        chk = cObj.rows[0].firstChild;
        if (
          tBody.firstChild.rows[Number(sObj2) - 1] != undefined &&
          chk != undefined
        ) {
          cObj.rows[0].firstChild.click();
        } //else {  if(autoform != undefined)	autoForm();}
      }
    } else {
      if (document.documentMode == "5") {
        chk = cObj.rows[0].firstChild;
        if (
          tBody.firstChild.rows[Number(sObj2) - 1] != undefined &&
          chk != undefined
        ) {
          cObj.rows[0].firstChild.click();
        }
      } else {
        chk = cObj.rows[0].firstChild.nextSibling;
        if (
          tBody.firstChild.nextSibling.rows[Number(sObj2) - 1] != undefined &&
          chk != undefined
        ) {
          cObj.rows[0].firstChild.nextSibling.click();
        }
      }
    }
  }
}

/****************************************************************
    FUNCTION ID	: value_check;
  CheckNo :	구분자.
 ****************************************************************/

function valueCheck(valueName, CheckNo) {
  if (CheckNo == 0) {
    alert("수정후 저장만 가능 합니다.");
    return false;
  }
  if (CheckNo == 1) {
    alert(valueName + "을(를)	입력하세요");
    return false;
  }
  if (CheckNo == 3) {
    alert(valueName + "을(를)	입력후 신규버튼을 선택해 주세요");
    return false;
  }
  if (CheckNo == 4) {
    alert(valueName + "버튼을	선택해 주세요");
    return false;
  }
}
/****************************************************************
    FUNCTION ID	: TdColorNew(arg_row_num)
                  arg_row_num :	선택_ROW
 ****************************************************************/

var sel_id = ""; //선택된 로우의	id 값
var odd_line = "#ffffff";
var even_line = "#f4f4f4";
var curr_line = "#ffcccc";
function TdColorNew(arg_row_num) {
  if (sel_id != "") {
    if (eval(sel_id) % 2 == 0) {
      document.all["row" + sel_id].style.background = even_line;
    } else {
      document.all["row" + sel_id].style.background = odd_line;
    }
  }
  document.all["row" + arg_row_num].style.background = curr_line;
  sel_id = arg_row_num;
}

/****************************************************************
    FUNCTION ID	: 체크박스 전체	선택;
  CheckNo :	구분자.
 ****************************************************************/

var bCheck = true;
function check() {
  if (bCheck == true) {
    checkAll();
    bCheck = false;
  } else {
    unCheckAll();
    bCheck = true;
  }
}
function checkAll() {
  var form = document.frm1;
  for (i = 0; i < form.check_box.length; i++) {
    form.check_box[i].checked = true;
  }
}
function unCheckAll() {
  var form = document.frm1;
  for (i = 0; i < form.check_box.length; i++) {
    form.check_box[i].checked = false;
  }
}

/*파이어폭스는 event 가 작동되지 않는다.
따라서 event 를 사용할 수 있도록 스크립트를 추가한다.
박의신 -2014.10.29*/
if (navigator.userAgent.indexOf("Firefox") >= 0) {
  var eventNames = [
    "mousedown",
    "mouseover",
    "mouseout",
    "mousemove",
    "mousedrag",
    "click",
    "dblclick",
    "keydown",
    "keypress",
    "keyup",
  ];

  for (var i = 0; i < eventNames.length; i++) {
    window.addEventListener(
      eventNames[i],
      function (e) {
        window.event = e;
      },
      true
    );
  }
}

function processKey() {
  if (event.altKey == true && event.keyCode == 115) {
    event.keyCode = 0;
    event.cancelBubble = true;
    event.returnValue = false;
  }
  if (
    (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) ||
    (event.keyCode >= 112 && event.keyCode <= 123)
  ) {
    event.keyCode = 0;
    event.cancelBubble = true;
    event.returnValue = false;
  }
  if (event.keyCode == 13) {
    var ev = event.srcElement;
    //alert("event.srcElement.name = "+ev.name);
    //var atb =	parseInt(ev.getAttribute("onChange"));
    //alert("attribute = "+	atb);
    //eval("document.frm1."+ev.name+"[3].focus()");
    //return false;
  }
  //back space 막기
  if (event.keyCode == 8) {
    if (typeof event.srcElement.type == "undefined") {
      if (agt.indexOf("msie") != -1) {
        event.returnValue = false;
      } else {
        event.preventDefault();
      }
    } else {
      //text나 textarea 아니면 막기
      if (
        event.srcElement.type != "text" &&
        event.srcElement.type != "textarea" &&
        event.srcElement.type != "password"
      ) {
        if (agt.indexOf("msie") != -1) {
          event.returnValue = false;
        } else {
          event.preventDefault();
        }
        //readOnly나 disabled 이면 막기
      } else if (event.srcElement.readOnly || event.srcElement.disabled) {
        if (agt.indexOf("msie") != -1) {
          event.returnValue = false;
        } else {
          event.preventDefault();
        }
      }
    }
  }
}
//document.onkeydown = processKey;
document.onkeydown = function (e) {
  key = e ? e.keyCode : event.keyCode;
  if (key == 8) {
    //firefox는 processKey를 호출하는게 아니라 브라우저 단축키가 된다
    if (navigator.userAgent.indexOf("Firefox") >= 0) {
      if (e) {
        if (typeof e.target.type != "undefined") {
          if (
            e.target.type != "text" &&
            e.target.type != "textarea" &&
            e.target != ""
          ) {
            e.returnValue = false;
            //readOnly나 disabled 이면 막기
          } else if (
            e.target.readOnly ||
            (e.target.disabled && e.target != "")
          ) {
            e.returnValue = false;
          }
        } else {
          e.preventDefault();
        }
      }
    } else {
      processKey();
    }
  }
};

function print_screen() {
  self.print();
  return;
}

function openPopup(idx) {
  // 주소검색을 수행할 팝업 페이지를 호출합니다.
  // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
  var name = $(idx)
    .parent()
    .find("input[type='hidden']")
    .attr("name")
    .substring(0, 4);
  var pop = window.open(
    "../jsp/zip/jusoPopup.jsp?gubn_val=" + name + "&gubn_val2=",
    "pop",
    "width=570,height=420, scrollbars=yes, resizable=yes"
  );
}

function openPopup2(idx) {
  // 주소검색을 수행할 팝업 페이지를 호출합니다.
  // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
  var name = $(idx)
    .parent()
    .find("input[type='text']:first")
    .attr("name")
    .substring(0, 4);
  var pop = window.open(
    "../jsp/zip/jusoPopup.jsp?gubn_val=" + name + "&gubn_val2=",
    "pop",
    "width=570,height=420, scrollbars=yes, resizable=yes"
  );
}

function openPopup3(idx) {
  // 주소검색을 수행할 팝업 페이지를 호출합니다.
  // 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
  var name = $(idx)
    .parent()
    .find("input[type='text']:first")
    .attr("name")
    .substring(0, 4);
  var pop = window.open(
    "../jsp/zip/jusoPopup.jsp?gubn_val=" + name + "&gubn_val2=stnt",
    "pop",
    "width=570,height=420, scrollbars=yes, resizable=yes"
  );
}

function jusoCallBack(
  roadFullAddr,
  roadAddrPart1,
  addrDetail,
  roadAddrPart2,
  engAddr,
  jibunAddr,
  zipNo,
  gubn,
  gubn2
) {
  // 팝업페이지에서 주소입력한 정보를 받아서, 현 페이지에 정보를 등록합니다.
  if (gubn2.length > 0) {
    //$("input[name="+gubn+"_zipc1]").val(zipNo.substring(0,3));
    //$("input[name="+gubn+"_zipc2]").val(zipNo.substring(4));
    $("input[name=" + gubn + "_zipc1]").val(zipNo);
    $("input[name=" + gubn2 + "_adr1]").val(roadFullAddr);
  } else {
    if ($("input[name=" + gubn + "_zipc1]").length > 0) {
      //$("input[name="+gubn+"_zipc1]").val(zipNo.substring(0,3));
      //$("input[name="+gubn+"_zipc2]").val(zipNo.substring(4));
      $("input[name=" + gubn + "_zipc1]").val(zipNo);
    } else if ($("input[name=" + gubn + "_post1]").length > 0) {
      $("input[name=" + gubn + "_post1]").val(zipNo.substring(0, 3));
      $("input[name=" + gubn + "_post2]").val(zipNo.substring(4));
    } else {
      //$("input[name="+gubn+"_pos1]").val(zipNo.substring(0,3));
      //$("input[name="+gubn+"_pos2]").val(zipNo.substring(4));
      $("input[name=" + gubn + "_pos1]").val(zipNo);
    }

    if ($("input[name=" + gubn + "_adr1]").length > 0) {
      $("input[name=" + gubn + "_adr1]").val(roadFullAddr);
    } else if ($("input[name=" + gubn + "_add1]").length > 0) {
      $("input[name=" + gubn + "_add1]").val(roadFullAddr);
    } else if ($("input[name=" + gubn + "_addr]").length > 0) {
      $("input[name=" + gubn + "_addr]").val(roadFullAddr);
    } else {
      $("input[name=" + gubn + "_add2]").val(roadFullAddr);
    }
  }
}
