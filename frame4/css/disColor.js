/*--------------------------------------------------------------- */
/*FUNCTION ID :TdColor                                             */
/*기    능 : 리스트 테이블의 해당 로우 클릭시에 해당로우의 색상을 변경한다.*/
/*인    수 : arg_row_num (해당 테이블의 총 Row 수  )      		*/
/*			 tot_row_num  (액션을 취한 테이블의 컬럼 seq ) 		*/
/*			 col_num        (해당 테이블의 총 Column 수)          */
/*----------------------------------------------------------------*/

var sel_id = ""; //선택된 로우의	id 값
var odd_line = "#ffffff";
var even_line = "#ffffff";
var curr_line = "#ffcccc";
function TdColorNew(arg_row_num) {
  var agt = navigator.userAgent.toLowerCase();
  if (sel_id != "") {
    if (eval(sel_id) % 2 == 0) {
      document.all["row" + sel_id].style.background = even_line;
      $("#row" + sel_id + " td").css("color", "#000000");
      $("#row" + sel_id + " td").css("font-weight", "normal");
      $("#row" + sel_id + " td").css("background-color", "#FEFEFE");
    } else {
      document.all["row" + sel_id].style.background = odd_line;
      $("#row" + sel_id + " td").css("color", "#000000");
      $("#row" + sel_id + " td").css("font-weight", "normal");
      $("#row" + sel_id + " td").css("background-color", "#FEFEFE");
    }
  }
  document.all["row" + arg_row_num].style.background = curr_line;
  $("#row" + arg_row_num + " td").css("color", "#ffffff");
  $("#row" + arg_row_num + " td").css("font-weight", "normal");
  $("#row" + arg_row_num + " td").css("background-color", "#b7b7b7");
  $("#row" + arg_row_num + " td")
    .find("th:last")
    .css("border-right", "1px solid #b7b7b7");
  sel_id = arg_row_num;
}
function TdColor(arg_row_num, tot_row_num, col_num) {
  for (i = 1; i <= parseInt(tot_row_num); i++) {
    if (i == parseInt(arg_row_num)) {
      //변경할 TD의 스타일 색상
      for (j = 1; j <= col_num; j++) {
        document.all["row" + j + "_" + i].style.background = "#E9E496";
      }
    } else {
      //원래 TD의 스타일 색상
      for (j = 1; j <= col_num; j++) {
        document.all["row" + j + "_" + i].style.background = "#F4FFFF";
      }
    }
  }
}
function TdColor1(arg_row_num, col_num) {
  //alert("1");
  //  var  d = new Date();
  if (sel_id == "") {
    for (j = 1; j <= col_num; j++) {
      document.all["row" + j + "_" + arg_row_num].style.background = "#E5F2F5";
    }
    sel_id = arg_row_num;
  } else {
    for (j = 1; j <= col_num; j++) {
      if (eval(sel_id) % 2 == 0) {
        document.all["row" + j + "_" + sel_id].style.background = "#F7F7F7";
      } else {
        document.all["row" + j + "_" + sel_id].style.background = "#FEFEFE";
      }
    }
    for (j = 1; j <= col_num; j++) {
      document.all["row" + j + "_" + arg_row_num].style.background = "#E5F2F5";
    }
    sel_id = arg_row_num;
  }
  //var d2 = new Date();
  //alert(d2.getTime()-d.getTime());
}

function TdColor3(arg_row_num, tot_row_num, col_num) {
  for (i = 1; i <= parseInt(tot_row_num); i++) {
    if (i == parseInt(arg_row_num)) {
      //변경할 TD의 스타일 색상
      for (j = 1; j <= col_num; j++) {
        document.all["row" + j + "_" + i].style.background = "#DEE4F3";
      }
    } else {
      //원래 TD의 스타일 색상
      if (i % 2 == 0) {
        for (j = 1; j <= col_num; j++) {
          document.all["row" + j + "_" + i].style.background = "#F7F7F7";
        }
      } else {
        for (j = 1; j <= col_num; j++) {
          document.all["row" + j + "_" + i].style.background = "#FEFEFE";
        }
      }
    }
  }
}

/**
 * Function      : 문자열의 앞뒤 space를 제거한다.
 * @param        : value
 * @return       : 앞뒤의 space가 제거된 문자열(checkField.js)
 */
function trimmed(value) {
  value = value.replace(/^\s+/, ""); // remove leading white spaces
  value = value.replace(/\s+$/g, ""); // remove trailing while spaces
  return value;
}
