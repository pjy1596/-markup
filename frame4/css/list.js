function list() {
  var agt = navigator.userAgent.toLowerCase();
  // 리스트의 높이를 Frameset에서 지정한 높이만큼 Height로 지정하도록 한다.
  // Frameset 에서 지정한 높이를 찾는다.
  if (agt.indexOf("msie 7.0") != -1 || agt.indexOf("msie 8.0") != -1) {
    var Height_all = document.documentElement.offsetHeight;
  } else {
    var Height_all = $(window).height();
  }
  // 리스트 제목의 높이를 찾는다.
  var Height_titl = $(".desc_title").parent().height();
  // Count의 높이를 찾는다.
  var Height_count = 20;
  // List의 타이틀 높이를 찾는다.
  var subTitl = $("#listTit").height();
  var memo = $("#memo").height();

  $("#list").css(
    "height",
    Height_all - Height_titl - subTitl - Height_count - 10 - memo
  );
  $("#timeTable").css("height", Height_all);
}

$(window).load(function () {
  list();

  var listTit = $("#list").find("table").innerWidth() + 1;
  $("#listTit table").css("width", listTit);
  $("#listTit table").find("th:last").css("border-right", "1px solid #77777");
  // 데이터가 없을 경우 '데이터가 없습니다.' 문구가 td 1개 넓이 만큼 나오는 오류 수정
  //list title 부분의 td갯수를 찾는다.
  if ($(".d_green td").length == 0) {
    var count_td = $(".d_green th").length;
  } else {
    var count_td = $(".d_green td").length;
  }
  //td갯수만큼 colspan를 입력한다. .listline_w class는 데이터가 없을 경우만 나오는 class이다.
  $(".listline_w").attr("colspan", count_td);
  $(".listline_w").text("No Data.");

  //데이터가 없을 경우
  if ($(".listline_w").length > 0) {
    var action = $("form").attr("action");
    //action 값이 없을 경우
    if (action == "") {
      viewDetail(false);
    } else {
      //리스트 구분값이 1이면 첫번째 리스트 2이면 두번째 리스트 false이면 안넘어가기
      if ($("input[name='list_gubn']").val() == "false") {
        viewDetail(false);
      } else {
        viewDetail();
      }
    }
  } else {
    //리스트 구분값이 false이면 안넘어가기
    if ($("input[name='list_gubn']").val() == "false") {
      viewDetail(false);
    } else {
      viewDetail();
    }
  }
});

$(window).resize(function () {
  list();

  var listTit = $("#list").find("table").innerWidth() + 1;
  $("#listTit table").css("width", listTit);
  $("#listTit table").find("th:last").css("border-right", "1px solid #77777");

  // 데이터가 없을 경우 '데이터가 없습니다.' 문구가 td 1개 넓이 만큼 나오는 오류 수정
  //list title 부분의 td갯수를 찾는다.
  if ($(".d_green td").length == 0) {
    var count_td = $(".d_green th").length;
  } else {
    var count_td = $(".d_green td").length;
  }
  //td갯수만큼 colspan를 입력한다. .listline_w class는 데이터가 없을 경우만 나오는 class이다.
  $(".listline_w").attr("colspan", count_td);
  $(".listline_w").text("No Data.");
});
