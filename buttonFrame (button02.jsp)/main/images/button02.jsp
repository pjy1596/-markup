<!---- Jsp include files ..........----------------------------------->

<!DOCTYPE html>
<html
  style="
    margin: 0;
    padding: 0;
    height: 30px;
    overflow: hidden;
    max-width: 1413px;
    background-color: #f3f3f3;
  "
>
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <head>
    <!---- Link and css Define area.   ----------------------------------->
    <link href="../main/css/button_menu.css" rel="stylesheet" type="text/css" />
    <title>button Menu</title>
    <!----User  jsp coding area .................------------------------>

    <script
      type="text/JavaScript"
      src="../function/jquery-1.9.0.min.js"
    ></script>
    <script type="text/JavaScript" src="../function/createWin.js"></script>

    <script type="text/JavaScript">
      function	frameindex(asframe)	{
      	var	index = 0;
      	var len =	parent.workFrame.frames.length;
      	for (i=0; i < len; i++) {
      		if (asframe == parent.workFrame.frames[i].name) { index = i; return index;}
      	}
      	alert(' ?? 없는 Frame Name 입니다..	' + asframe);
      	return 1;
      }
      function	formindex(asframe,asform)	{
      	var	index = 0;
      	var len =	parent.workFrame.frames[asframe].document.forms.length;
      	for (i=0; i < len; i++) {
      		if (asform == parent.workFrame.frames[asframe].document.forms[i].name) {
      			 index = i; return index;
      		}
      	}
      	if(asform != 'frm1')	{
      		alert(' ?? 없는 Form Name 입니다.. ' +parent.workFrame.frames[asframe].name + '  '+ asform);
      	}return 0;
      }
      /*****  main function ***************************************/
      function set_src(src, asform ) {//실행,조회,help frame......
      	this.srcframe 	=  frameindex(src);
      	this.srcfrm		= formindex(this.srcframe,asform);
      }
      function set_cur(cur, asform) {//수정,삭제,저장,닫기..frame
      	this.curframe 	= frameindex(cur);
      	this.curfrm		= formindex(this.curframe,asform);
      }
      function set_trg(asframe,astarget) {//신규  = popup,row,frame_name을 사용한다...
      	if (asframe == 'popup')         {this.popwin = 1; }
      	else if (asframe == 'row')      {this.popwin = 2; }
         	else if (asframe == 'insert')    {this.popwin = 3;}
         	else    { this.trgframe 	= frameindex(asframe); this.popwin = 0; }
      	this.trgurl		= astarget;
      }
      function set_init(str) {
      	/* -- str = frame , url */
      	temp			=   str.split(',');
      	if(temp[0] == 'popup') {
      	    this.popwin = 1; return;
      	}
      	if(temp.length == 1) {this.initframe =this.trgframe	= frameindex(temp);}
          else     {
              this.initframe 	= this.trgframe = frameindex(temp[0]);
      	    this.initurl	= temp[1];
      	}
      }
      function set_def(defvalue)	{
      	var temp = defvalue.split(',');
      	this.popwin		= 0;		//( 0:current_frame_set, 1: popup 2:add_row())
      	this.win_name   = temp[0];	//window_name
      	this.width      = temp[1];	//for window
      	this.height     = temp[2];	//for window
      	this.initurl    = '';
      	this.initframe	= '';
      }
      function set_del(asurl) {
      	this.delurl     = asurl;
      }

      function set_win()	{
      	this.srcframe 	;	this.curframe ;		this.trgframe ;		this.newframe 	;
      	this.srcfrm 	; 	this.curfrm		;	this.trgurl	  ;		this.popwin	  ;
      	this.win_name   ;	this.width      ;	this.height   ;		this.newurl ;
      	this.initurl	= '';					this.initframe	= ''; this.delurl;
      	this.help_page  = '';					this.func_name  = '';
      	this.setinit		= set_init;	        this.setsrc	 = set_src;	 this.setcur	= set_cur;
      	this.settrg		= set_trg;	this.setdef     = set_def;	 this.setdel    = set_del;
      }

      /*--  end of set_win function ...................*/
      	/*-- image path name....*/
      	var imageon = new Array('../main/images/new.jpg',  	'../main/images/modify.jpg',
      					  '../main/images/delete.jpg',		'../main/images/save.jpg',
      	                  '../main/images/search.jpg', 	'../main/images/execute.jpg',
      	                  '../main/images/excel.jpg', 		'../main/images/print_active.gif',
      	                  '../main/images/help_active.gif',		'../main/images/close_active.gif',
                          '../main/images/logout_active.gif' );
          var imageoff = new Array('../main/images/new.jpg',  	'../main/images/modify.jpg',
      						  '../main/images/delete.jpg',		'../main/images/save.jpg',
      			              '../main/images/search.jpg', 	'../main/images/execute.jpg',
      			              '../main/images/excel.jpg', 		'../main/images/print_active.gif',
      			              '../main/images/help_active.gif',		'../main/images/close_active.gif',
      			            '../main/images/logout_active.gif' );
          var imageload = new Array('../main/images/new2.jpg',  	'../main/images/modify2.jpg',
      					  '../main/images/delete2.jpg',		'../main/images/save2.jpg',
      	                  '../main/images/search2.jpg', 	'../main/images/execute2.jpg',
      	                  '../main/images/excel_over.gif', 		'../main/images/print_over.gif',
      	                  '../main/images/help_over.gif',		'../main/images/close_over.gif',
                          '../main/images/logout_over.gif' );

      	var imgs    	= new Array();
      	var	imgenable   = new Array();
      	var nameset 	= new Array('new','modify','delete','save','search','exe','excel','print','help','close','logout');
      	/*-- image path init....*/
      	function b_format() {
      		//경로 넣어준다
      		for (i = 0; i <11; i++) {
      			imgs[i] = imageoff[i];
      			imgenable[i] = '0';
      		}
      	}
      	function bset (str) {
      	  if(str == 'default'||str =='') { str ='';}
      	  else {	str += '';  }

      		var a = str.split(',');
      		b_format();
      		for(j = 0; j< nameset.length; j++) {
      			if(j<9){
      				var k = "0"+(j+1);
      			}else{
      				var k = j+1;
      			}
      			$("img[name='Image"+k+"']").parent().hide();
      		}

      		for(i=0; i<a.length; i++)  {
      			if(a[i] != 'help'){
      				for(j = 0; j< nameset.length; j++) {
      					if ( a[i] == nameset[j]) {
      						if(j<9){
      							var h = "0"+(j+1);
      						}else{
      							var h = j+1;
      						}
      						$("img[name='Image"+h+"']").parent().show(500);
      						 imgs[j] = imageon[j];
      						 imgenable[j] = '1';

      						 break;
      					}
      				}
      			}
      		}
      		document.Image01.src = imgs[0];   document.Image06.src = imgs[5];
      		document.Image02.src = imgs[1];   //document.Image07.src = imgs[6];
      		document.Image03.src = imgs[2];   //document.Image08.src = imgs[7];
      		document.Image04.src = imgs[3];   //document.Image09.src = imgs[8];
      		document.Image05.src = imgs[4];   //document.Image10.src = imgs[9];
      		//document.Image11.src = imgs[10];

      	}
      /*--  end of  image	function  ...  */
      //onMouseOut
      function MM_swapImgRestore() { //v3.0
        var i,x,a=document.MM_sr;
        for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
      }
      //onLoad
      function MM_preloadImages() { //v3.0
        	var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
          var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
          if (a[i].indexOf('#')!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
      }
      //
      function MM_findObj(n, d) { //v4.01
        var p,i,x;  if(!d) d=document;
        if((p=n.indexOf('?'))>0&&parent.frames.length) {
          	d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
        if(!(x=d[n])&&d.all) x=d.all[n];
        for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
        for (i=0;!x&&d.layers&&i<d.layers.length;i++) 	x=MM_findObj(n,d.layers[i].document);
        if(!x && d.getElementById) x=d.getElementById(n);
        return x;
      }
      //onMouseOver
      function MM_swapImage() { //v3.0
      	var i,j=0,x,a=MM_swapImage.arguments;
      	if (a[1] == 0)	return;
      	document.MM_sr=new Array;
      	for(i=0;i<(a.length-2);i+=3)	{
      		if ((x=MM_findObj(a[i]))!=null){
      			document.MM_sr[j++]=x;
      			if(!x.oSrc) x.oSrc=x.src;	x.src=a[i+2];
      		}
      	}
      }
      function exe_check( num ) {
      	switch ( num )	   {
      		 case 0:
      		 	if ( imgenable[num] == true ) {	b00()	};	break;
      	     case 1:
      			if ( imgenable[num] == true ) {	b01()	};	break;
      	     case 2:
      			if ( imgenable[num] == true ) {	b02()	};	break;
      	     case 3:
      			if ( imgenable[num] == true ) {	b03()	};	break;
      	     case 4:
      			if ( imgenable[num] == true ) {	b04()	};	break;
      	     case 5:
      			if ( imgenable[num] == true ) {	b05()	};  break;
      	     case 6:
      			if ( imgenable[num] == true ) {	b06()	};  break;
      	     case 7:
      			if ( imgenable[num] == true ) {	b07()	};  break;
      	     case 8:
      			if ( imgenable[num] == true ) {	b08()	};  break;
      	     case 9:
      			if ( imgenable[num] == true ) {	b09()	};  break;
      	     case 10:
      			if ( imgenable[num] == true ) {	b10()	};  break;
      	     case 11:
      			if ( imgenable[num] == true ) {	b11()	};  break;
      	     default:
      	     	break;
        }
      }
      //--신규 -- frame = trgframe
      function b00(){
       	var temp;
       	var flag  = parent.workFrame.frames[setwin.srcframe].insert_chk();
        	if ((flag == 'true')||(flag==true)) {}
          else    {return;}
        var form  = parent.workFrame.frames[setwin.srcframe].document.forms[setwin.srcfrm];
        var k = form.elements.length;
      	var save_action = form.action;
      	var save_target = form.target;
      	form.action = setwin.newurl;
      	form.target = setwin.newframe;
      	form.save_gubn.value    =   '1';
      	if( setwin.popwin == 0 ) {          //frame 으로
              form.submit();
      	} else if ( setwin.popwin == 2 ) {  //add_row().. inter_html 사용....
      	   parent.workFrame.frames[setwin.curframe].add_row();
      	} else if ( setwin.popwin == 3 ) {
      	   parent.workFrame.frames[setwin.curframe].insert_row();
      	} else    {  //pop_up windows........
      	    temp  = setwin.trgurl +'?';
      		for ( i=0 ; i< k ; i++) {
      			temp = temp + form.elements[i].name + '=';
      			temp = temp + form.elements[i].value;
      			temp = temp + '&'    ;
      		}
      		openWinNEW( setwin.win_name, temp, setwin.width , setwin.height, 50,50 )
      		//openWinModal( temp, setwin.width , setwin.height, 50,50 )
      	}
      	form.action = save_action;
      	form.target = save_target;

      	//old_version용.....
      	//if (parent.workFrame.frames[setwin.srcframe].isSubmit != null) {
      	//		  parent.workFrame.frames[setwin.srcframe].valueSubmit();
      	//}
      }
      //--수정 --frame =  curframe
      function b01(){
        var flag  = parent.workFrame.frames[setwin.curframe].modify_chk();
        if ((flag == 'true')||(flag==true)) {}
        else    {return;}
      	var	tempurl = '';
      	form =  parent.workFrame.frames[setwin.curframe].document.forms[setwin.curfrm];
      	var k = form.elements.length;
      	var save_action = form.action;
      	var save_target = form.target;
      	form.action = setwin.newurl;
      	form.target = setwin.newframe;
      	form.save_gubn.value = '2';
      	if( setwin.popwin == 0 )	{	form.submit();}
      	else {
      		tempurl = tempurl + '?';
      		for ( i=0 ; i< k ; i++) {
      			tempurl = tempurl + form.elements[i].name + '='
      			tempurl = tempurl + form.elements[i].value
      			tempurl = tempurl + '&'
      		}
      		openWinNEW( setwin.win_name , setwin.trgurl + tempurl ,setwin.width ,setwin.height,50,50 )
      		//openWinModal( setwin.trgurl + tempurl ,setwin.width ,setwin.height,50,50 )
      	}
      	form.action = save_action;
      	form.target = save_target;
      }
      //--삭제  -- frame = curframe
      function b02(){
      	var chk  = parent.workFrame.frames[setwin.curframe].value_chk();
      	var save_action;
      	var save_target;
      	var tempform = parent.workFrame.frames[setwin.curframe].document.forms[setwin.curfrm];
      	var check = tempform.elements[0].value;
      	if ( chk != 'true' || chk == false) {
      		//alert('삭제 하고자 하는 코드를 선택해 주십시요');
      		return false;
      	}
      	if (confirm('자료를 삭제하시겠습니까?')) {flag = 'T';}
      	else	{flag = 'F';}
      	if (flag == 'T') {
      		tempform.save_gubn.value = '3';
      		save_action = tempform.action;
      		save_target = tempform.target;
      		tempform.action = setwin.delurl;
      		tempform.target = parent.workFrame.frames[setwin.curframe].name;
      		var len =	parent.workFrame.frames.length;
      		for (i=0; i < len; i++) {
      			if ('frame9' == parent.workFrame.frames[i].name) { tempform.target = 'frame9'}
      		}
      		tempform.submit();
      		tempform.action = save_action;
      		tempform.target = save_target;
      	}
      }
      //--저장 -- frame =  curframe
      function b03(){
      	var flag  = parent.workFrame.frames[setwin.curframe].value_chk();
      	var tempform = parent.workFrame.frames[setwin.curframe].document.forms[setwin.curfrm];
      	if ((flag == 'true')||(flag==true)) {
      		if (confirm('자료를 저장하시겠습니까?')){
      			tempform.submit();
      		}
      	}
      	else { /*alert (' 입력자료를 검사 하십시오.');} */}
      }
      //--조회 -- frame = srcframe
      function b04(){
      	top.buttonFrame.frm1.init_indx.value = '';
      	var flag  = parent.workFrame.frames[setwin.srcframe].value_chk();
      	if ((flag == 'true')||(flag==true)) {
      	  	if (parent.workFrame.frames[setwin.srcframe].name == 'frame1') {
      	  		if(parent.workFrame.tab_flag == 0){
      	  				if(setwin.initframe != '') {
      	  					parent.workFrame.frames[setwin.initframe].location.href = setwin.initurl;
      	  				}
      	  		}
      	    }
      	  	parent.workFrame.frames[setwin.srcframe].document.forms[setwin.srcfrm].submit();
      	} else {return;}

      }
      //--실행 -- frame == secframe
      function b05(){
      	var flag  = parent.workFrame.frames[setwin.srcframe].value_chk();
      	if ((flag == 'true')||(flag==true)) {
      	  parent.workFrame.frames[setwin.trgframe].location = '../jsp/loading.jsp';
      	  parent.workFrame.frames[setwin.srcframe].document.forms[setwin.srcfrm].submit();
      	}   else {return;}

      }
      function getXMLHttpRequest() {
      	if (window.ActiveXObject)
      	{
      		try
      		{
      			return new ActiveXObject('Msxml2.XMLHTTP');
      		}
      		catch(e)
      		{
      			try
      			{
      				return new ActiveXObject('Microsoft.XMLHTTP');
      			} catch(e1) { return null; }
      		}
      	} else if (window.XMLHttpRequest) {
      		return new XMLHttpRequest();
      	} else {
      		return null;
      	}
      }
      //--엑셀
      function b06(){
      		top.buttonFrame.frm1.init_indx.value = '';
      	var flag  = parent.workFrame.frames[setwin.srcframe].value_chk();
      	if ((flag == 'true')||(flag==true)) {
      	  	if (parent.workFrame.frames[setwin.srcframe].name == 'frame1') {
      	  		if(parent.workFrame.tab_flag == 0){
      	  				if(setwin.initframe != '') {
      	  					parent.workFrame.frames[setwin.initframe].location.href = setwin.initurl;
      	  				}
      	  		}
      	    }
      	    var httpMethod = 'POST';
      	    httpRequest	= getXMLHttpRequest();
      	    httpUrl = parent.workFrame.frames[setwin.srcframe].document.forms[setwin.srcfrm].action;
      	    httpRequest.open('POST', httpUrl, true);
      	    httpRequest.setRequestHeader('Content-Type', 'application/vnd.ms-excel');
      	    httpRequest.setRequestHeader('Content-Disposition', 'mxls; filename=test.xls');
      	    httpRequest.setRequestHeader('Content-Description', 'JSP Generated Data');
      	    httpRequest.send();
      	  	//parent.workFrame.frames[setwin.srcframe].document.forms[setwin.srcfrm].submit();
      	} else {return;}
      }
      //--출력
      function b07(){
      		//tempform = parent.workFrame.frames[setwin.curframe].document.forms[setwin.curfrm];
      		parent.workFrame.frames[setwin.curframe].print_screen();
      		return;
      }
      //--Help  --  frame ==  srcframe var help_page
      function b08(){
      		helppage  = setwin.help_page + '&func_name=';
      		helppage = helppage + setwin.func_name;
      		openWinModal('../help/help.jsp?inoj_name='+helppage,550,650,50,50);
      		//openWinNEW('help','../help/help.jsp?inoj_name='+helppage,550,650,50,50);
      }
      //--닫기 -- frame = curframe
      function b09(){
      	//parent.workFrame.frames[setwin.curframe].location = setwin.initurl;
      		if (confirm('작업화면을 닫으시겠습니까?')){
      			parent.workFrame.location = '../jsp/content.jsp';
      		}
      }
      function b10(){
      		if (confirm('Log out 하시겠습니까?')){
        		parent.parent.location = '../main/logout.jsp';
      		}
      }
      function    processKey()    {
          if(event.altKey ==   true && event.keyCode == 115) {
                  event.keyCode = 0;
                  event.cancelBubble = true;
                  event.returnValue  = false;

          }
          if((event.ctrlKey == true && (event.keyCode == 78  || event.keyCode ==82)) ||
                  (event.keyCode >=112 && event.keyCode <= 123) ) {
                      event.keyCode = 0;
                      event.cancelBubble = true;
                      event.returnValue  = false;
                  }
          }
      function    mouse_check(e) {
          if(document.all && event.button ==2) {return false;}
          if(document.layer && e.whick==3) {return flase;}
      }
      document.onkeydown = processKey;
      document.onmousedown=mouse_check;
      setwin = new set_win();
    </script>
    <script type="text/JavaScript">
      //button 을 사용하기위한 default
      function downLoad(){
      	parent.workFrame.location.href="../ca/cam5010.jsp";
      }
      function changePWD(){
      	parent.workFrame.location.href="../ca/cam4010.jsp";
      }
      function gotoERP(){
      	window.open("");
      }
      function MM_swapImage() { //v3.0
      	var i,j=0,x,a=MM_swapImage.arguments;
      	if (a[1] == 0)	return;
      	document.MM_sr=new Array;
      	for(i=0;i<(a.length-2);i+=3)	{
      		if ((x=MM_findObj(a[i]))!=null){
      			document.MM_sr[j++]=x;
      			if(!x.oSrc) x.oSrc=x.src;	x.src=a[i+2];
      		}
      	}
      }
       $(document).ready(function(){



      	 var p = 0;
      	 $('#pre').click(function(){
      		 if(p == 0){
      		 	var framc = $("#framc", parent.document).attr('cols','0,*');
      		 	$('#pre').css("background-image","url('./images/button/right.jpg')");
      		 	p = 1;
      		 }else{
      			var framc = $("#framc", parent.document).attr('cols','185,*');
      			$('#pre').css("background-image","url('./images/button/left.jpg')");
      			p = 0;
      		 }
      	 });
      	 var q = 0;
      	 $('#up').click(function(){
      		 if(q == 0){
      		 	var framc = $("#frams", parent.document).attr('rows','0,30,*');
      		 	$('#up').css("background-image","url('./images/button/down.jpg')");
      		 	q = 1;
      		 }else{
      			var framc = $("#frams", parent.document).attr('rows','123,30,*');
      			$('#up').css("background-image","url('./images/button/up.jpg')");
      			q = 0;
      		 }
      	 });

      	 /* $('#up').click(function(){
      		 var frams = $("#frams", parent.document).attr('rows','0,57,*');
      		 $('#up').hide();
      		 $('#down').show(100);
      	 });
      	 $('#down').click(function(){
      		 var frams = $("#frams", parent.document).attr('rows','80,57,*');
      		 $('#down').hide();
      		 $('#up').show(100);
      	 }); */

      	// workFrame 높이를 찾는다.
      	var Height_all = $("#workFrame", parent.document).height();
      	document.frm1.Height_all.value = Height_all;
       });

       $(window).resize(function(){
      	var Height_all = $("#workFrame", parent.document).height();
      	document.frm1.Height_all.value = Height_all;
       });
    </script>
    <!------    end of default value set   ------------------------------->
  </head>
  <!-------------- body and form tag ------------------------------------->
  <body
    style="height: 30px; margin: 0; padding: 0; overflow: hidden;"
    onLoad="MM_preloadImages(
	  				  '../main/images/new.jpg',		'../main/images/modify.jpg',
					  '../main/images/delete.jpg',	'../main/images/save.jpg',
					  '../main/images/search.jpg',	'../main/images/execute.jpg');"
  >
    <form name="frm1">
      <input type="hidden" name="prim_rows" value="" />
      <input type="hidden" name="init_indx" value="" />
      <input type="hidden" name="init_indx2" value="" />
      <input type="hidden" name="bset_stri" value="" />
      <input type="hidden" name="objt_name" value="" />
      <input type="hidden" name="func_name" value="" />
      <input type="hidden" name="Height_all" value="" />

      <div class="button_div" id="btn_div">
        <table style="border: none; height: 30px; margin: 0; padding: 0;">
          <tr class="button_tr" style="height: 30px;">
            <th class="btn_slide1" id="pre"></th>
            <td width="21px"></td>
            <td>
              <img
                src="../main/images/new.jpg"
                name="Image01"
                border="0"
                onMouseOut="MM_swapImgRestore(imgenable[0]);"
                onMouseOver="MM_swapImage('Image01',imgenable[0],'../main/images/new2.jpg',1);"
                onclick="MM_swapImage('Image01',imgenable[0],'../main/images/new2.jpg',1);javascript:exe_check(0);"
              />
            </td>

            <td>
              <img
                src="../main/images/modify.jpg"
                name="Image02"
                border="0"
                onMouseOut="MM_swapImgRestore(imgenable[1]);"
                onMouseOver="MM_swapImage('Image02',imgenable[1],'../main/images/modify2.jpg',1);"
                onclick="MM_swapImage('Image02',imgenable[1],'../main/images/modify2.jpg',1);javascript:exe_check(1);"
              />
            </td>

            <td>
              <img
                src="../main/images/delete.jpg"
                name="Image03"
                border="0"
                onMouseOut="MM_swapImgRestore(imgenable[2]);"
                onMouseOver="MM_swapImage('Image03',imgenable[2],'../main/images/delete2.jpg',1);"
                onclick="MM_swapImage('Image03',imgenable[2],'../main/images/delete2.jpg',1);javascript:exe_check(2);"
              />
            </td>

            <td>
              <img
                src="../main/images/save.jpg"
                name="Image04"
                border="0"
                onMouseOut="MM_swapImgRestore(imgenable[3]);"
                onMouseOver="MM_swapImage('Image04',imgenable[3],'../main/images/save2.jpg',1);"
                onclick="MM_swapImage('Image04',imgenable[3],'../main/images/save2.jpg',1);javascript:exe_check(3);"
              />
            </td>

            <td>
              <img
                src="../main/images/search.jpg"
                name="Image05"
                border="0"
                onMouseOut="MM_swapImgRestore(imgenable[4]);"
                onMouseOver="MM_swapImage('Image05',imgenable[4],'../main/images/search2.jpg',1);"
                onclick="MM_swapImage('Image05',imgenable[4],'../main/images/search2.jpg',1);javascript:exe_check(4);"
              />
            </td>

            <td>
              <img
                src="../main/images/execute.jpg"
                name="Image06"
                border="0"
                onMouseOut="MM_swapImgRestore(imgenable[5]);"
                onMouseOver="MM_swapImage('Image06',imgenable[5],'../main/images/execute2.jpg',1);"
                onclick="MM_swapImage('Image06',imgenable[5],'../main/images/execute2.jpg',1);javascript:exe_check(5);"
              />
            </td>

            <!-- 
	      <td><img src="../main/images/excel_default.gif" name="Image07" border="0" 
			 onMouseOut="MM_swapImgRestore(imgenable[6]);"
	      	onMouseOver="MM_swapImage('Image07',imgenable[6],'../main/images/excel_over.gif',1);" 
	      	onclick="MM_swapImage('Image07',imgenable[6],'../main/images/excel_over.gif',1);javascript:exe_check(6);"></td>

	      <td><img src="../main/images/print_default.gif" name="Image08" border="0" 
			 onMouseOut="MM_swapImgRestore(imgenable[7]);"
	      	onMouseOver="MM_swapImage('Image08',imgenable[7],'../main/images/print_over.gif',1);" 
	      	onclick="MM_swapImage('Image08',imgenable[7],'../main/images/print_over.gif',1);javascript:exe_check(7);"></td>

	      <td><img src="../main/images/help_default.gif" name="Image09" border="0" 
			 onMouseOut="MM_swapImgRestore(imgenable[8]);"
	      	onMouseOver="MM_swapImage('Image09',imgenable[8],'../main/images/help_over.gif',1);"   
	      	onclick="MM_swapImage('Image09',imgenable[8],'../main/images/help_over.gif',1);javascript:exe_check(8);"></td>

	      <td><img src="../main/images/close_default.gif" name="Image10" border="0" 
			 onMouseOut="MM_swapImgRestore(imgenable[9]);"
	      	onMouseOver="MM_swapImage('Image10',imgenable[9],'../main/images/close_over.gif',1);"  
	      	onclick="MM_swapImage('Image10',imgenable[9],'../main/images/close_over.gif',1);javascript:exe_check(9);"></td>

	      <td><img src="../main/images/logout_default.gif" name="Image11" border="0" 
			 onMouseOut="MM_swapImgRestore(imgenable[10]);"
	      	onMouseOver="MM_swapImage('Image11',imgenable[10],'../main/images/logout_over.gif',1);"
	        onclick="MM_swapImage('Image11',imgenable[10],'../main/images/logout_over.gif',1);javascript:exe_check(10);">
	        </td> 
	      -->
            <td class="button_last" style="text-align: right;"></td>
          </tr>
        </table>
      </div>
    </form>
  </body>

  <script type="text/JavaScript">
       //parent.workFrame.location.href="../jsp/notice.jsp";
    bset("default");
  </script>
</html>
