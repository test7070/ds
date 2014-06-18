<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
			q_tables = 's';
            var q_name = "carkind";
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
			var bbsNum = [['txtPosition',2,0]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = [];
			brwCount2 = 10;
			
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }
            function mainPost() {
                q_mask(bbmMask);
                $('#txtNoa').change(function(e) {
                    $(this).val($.trim($(this).val()).toUpperCase());
                    if ($(this).val().length > 0) {
                        //if ((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())) {
                            t_where = "where=^^ noa='" + $(this).val() + "'^^";
                            q_gt('carkind', t_where, 0, 0, 0, "checkCarkindno_change", r_accy);
                        /*} else {
                            Lock();
                            alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
                            Unlock();
                        }*/
                    }
                });
                $('input[name="img"]').click(function(){
                	$('#img').attr('src','../image/'+$(this).attr('value'));
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                } 
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'checkCarkindno_change':
                        var as = _q_appendData("carkind", "", true);
                        if (as[0] != undefined) {
                            alert('已存在 ' + as[0].noa + ' ' + as[0].kind);
                        }
                        break;
                    case 'checkCarkindno_btnOk':
                        var as = _q_appendData("carkind", "", true);
                        if (as[0] != undefined) {
                            alert('已存在 ' + as[0].noa + ' ' + as[0].kind);
                            Unlock();
                            return;
                        } else {
                            wrServer($('#txtNoa').val());
                        }
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('carkind_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                $('#txtKind').focus();
            }

            function btnPrint() {

            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }

            function btnOk() {
                Lock();
                $('#txtNoa').val($.trim($('#txtNoa').val()));
                /*if ((/^(\w+|\w+\u002D\w+)$/g).test($('#txtNoa').val())) {
                } else {
                    alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。' + String.fromCharCode(13) + 'EX: A01、A01-001');
                    Unlock();
                    return;
                }*/
                for(var i=0; i<$('input[name="img"]').length;i++)
            		if($('input[name="img"]').eq(i).prop('checked'))
            			$('#txtImg').val($('input[name="img"]').eq(i).attr('value'));
                for(var i=0;i<q_bbsCount;i++){
                	n = q_float($('txtPosition_'+i).val());
                	if(n<10){
                		$('txtPosition_'+i).val('0'+n);
                	}
                }
                
                if (q_cur == 1) {
                    t_where = "where=^^ noa='" + $('#txtNoa').val() + "'^^";
                    q_gt('carkind', t_where, 0, 0, 0, "checkCarkindno_btnOk", r_accy);
                } else {
                    wrServer($('#txtNoa').val());
                }
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }
			function bbsSave(as) {
                if (!as['position']) {
                    as[bbsKey[1]] = '';
                    return;
                }

                q_nowf();
                return true;
            }
            function sum() {
            	
            }
            function refresh(recno) {
                _refresh(recno);
                $('#img').removeAttr('src');
                for(var i=0; i<$('input[name="img"]').length;i++){
                	$('input[name="img"]').eq(i).prop('checked',false);
                	if($('input[name="img"]').eq(i).val()==$('#txtImg').val()){
                		$('input[name="img"]').eq(i).prop('checked',true);
                		$('#img').attr('src','../image/'+$('#txtImg').val());
                	}
                }
                refreshBbm();
            }

            function refreshBbm() {
                if (q_cur == 1) {
                    $('#txtNoa').css('color', 'black').css('background', 'white').removeAttr('readonly');
                } else {
                    $('#txtNoa').css('color', 'green').css('background', 'RGB(237,237,237)').attr('readonly', 'readonly');
                }
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur==1 || q_cur==2){
                	$('input[name="img"]').removeAttr('disabled');
                }else{
                	$('input[name="img"]').attr('disabled','disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }
			function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {

                }
                _bbsAssign();
            }
            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 300px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 300px;
                /*margin: -1px;        
                border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 20%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size:medium;
            }
            .dbbs {
                width: 950px;
            }
            .tbbs a {
                font-size: medium;
            }
            
            .num {
                text-align: right;
            }
			input[type="text"],input[type="button"] {
                font-size:medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:200px; color:black;"><a id='vewKind'> </a></td>			
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" /></td>
						<td style="text-align: center;" id='noa'>~noa</td>
						<td style="text-align: left;" id='kind'>~kind</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td colspan="4"><input id="txtKind" type="text" class="txt c1" /></td>
					</tr>	
					<tr>
						<td><input type="text" id="txtImg" style="display:none;"/></td>
						<td colspan="3">
							<input type="radio" name="img" style="float:left;width:5%;" value="car6.png">
							<a style="float:left;width:25%;color:black;">車-六輪</a>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="3">	
							<input type="radio" name="img" style="float:left;width:5%;" value="car8.png">
							<a style="float:left;width:25%;color:black;">車-八輪</a>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="3">	
							<input type="radio" name="img" style="float:left;width:5%;" value="car10.png">
							<a style="float:left;width:25%;color:black;">車-十輪</a>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="3">
							<input type="radio" name="img" style="float:left;width:5%;" value="ben8.png">
							<a style="float:left;width:25%;color:black;">板-八輪</a>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="3">
							<input type="radio" name="img" style="float:left;width:5%;" value="ben10.png">
							<a style="float:left;width:25%;color:black;">板-十輪</a>	
						</td>	
					</tr>
				</table>
			</div>
			<div style="width:200px;height:200px;float:left;background:gray;">
				<img id="img" style="width:100%;height:100%;">
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:80px;"><a id='lblPosition_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblNamea_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><input type="text" id="txtPosition.*" style="width:95%;"/></td>
					<td><input type="text" id="txtNamea.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
