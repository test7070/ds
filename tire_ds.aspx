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

            q_desc = 1;
            q_tables = 's';
            var q_name = "tire";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtCmoney','txtPosition'];
            var q_readonlys = [];
            var bbmNum = [['txtMiles',10,0,1],['txtWmoney',10,0,1],['txtCmoney',10,0,1],['txtDmoney',10,0,1]];
            var bbsNum = [['txtPrice',10,0,1]];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 6;
            //ajaxPath = "";
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa','txtCarno', 'car2_b.aspx'],
            		['txtCarplateno', 'lblCarplateno', 'carplate', 'noa,carplate', 'txtCarplateno', 'carplate_b.aspx'],
            		['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtTgg,txtNick', 'tgg_b.aspx'],
            		['txtEtireno_', '', 'view_tirestk', 'noa,price,product','txtEtireno_,txtPrice_', 'tirestk_b.aspx']);
			function tire_dsData(){}
			tire_dsData.prototype = {
				carkind : new Array(),
				combRefresh : function(){
					q_gt('car2', "where=^^ carno='"+$.trim($('#txtCarno').val())+"'^^", 0, 0, 0, "combRefresh", r_accy);
				}
			}
			var tire_ds = new tire_dsData();
			        
            $(document).ready(function() {
            	q_gt('carkind', "", 0, 0, 0, "", r_accy);
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }
            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbAction", q_getMsg('action').replace(/\&/g,','),'s');
            }
			function q_popPost(id) {
				switch(id) {
					case 'txtCarno':
                    	var t_carno = $.trim($('#txtCarno').val());
                    	if(t_carno.length>0){
                    		var t_where = "where=^^carno='"+t_carno+"' and len(isnull(carplateno,''))=0^^";
                    		q_gt('view_tirestatus', t_where, 0, 0, 0, "tirestatus_carno", r_accy);
                    	}
                    	break;
                    case 'txtCarplateno':
                    	var t_carplateno = $.trim($('#txtCarplateno').val());
                    	if(t_carplateno.length>0){
                    		var t_where = "where=^^carplateno='"+t_carplateno+"'^^";
                    		q_gt('view_tirestatus', t_where, 0, 0, 0, "tirestatus_carplateno", r_accy);
                    	}
                    	break;
					case 'txtEtireno_':
						sum();
						break;
				}
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
                	case 'carkind':
                		var as = _q_appendData("carkind", "", true);
                		var ass = _q_appendData("carkinds", "", true);
                		if (as[0] != undefined && ass[0] != undefined){
                			for(var i = 0;i<as.length;i++){
                				t_item = new Array();
                				for(var j = 0;j<ass.length;j++){
                					if(ass[j].noa==as[i].noa && ass[j].position.length>0){
                						t_item.push({position:ass[j].position,namea:ass[j].namea})
                					}
                				}
                				tire_ds.carkind.push({noa:as[i].noa,kind:as[i].kind,img:as[i].img,item:t_item});
                			}
                		}
                		bbmKey = ['noa'];
		                bbsKey = ['noa', 'noq'];
		                q_brwCount();
		                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
                		break;
                	case 'combRefresh':
                		var as = _q_appendData("car2", "", true);
                		var t_index = -1;
                		$('#img').attr('src','');
                		if (as[0] != undefined){
                			for(var i=0;i<tire_ds.carkind.length;i++){
                				if(tire_ds.carkind[i].noa==as[0].carkindno){
                					$('#img').attr('src','../image/'+tire_ds.carkind[i].img);
                					t_index = i;
                					string = '<option></option>';
                					for(var j=0;j<tire_ds.carkind[i].item.length;j++){
                						string += '<option value="'+tire_ds.carkind[i].item[j].position+'">'+tire_ds.carkind[i].item[j].namea+'</option>';
                					}
                					$('.position').html(string);
                					if(q_cur==1 || q_cur==2){
					                	$('.position').removeAttr('disabled');
					                }else{
					                	$('.position').attr('disabled','disabled');
					                }
                					break;
                				}
                			}
                		}else{
                			$('.position').html('');
                		}
                		for(var i=0;i<q_bbsCount;i++){
                			$('#combPosition_'+i).val('');
                			if(t_index!=-1){
                				t_position = $.trim($('#txtPosition_'+i).val());
                				for(var j=0;j<tire_ds.carkind[t_index].item.length;j++){
                					if(tire_ds.carkind[t_index].item[j].position==t_position){
                						$('#combPosition_'+i).val(t_position);
                						break;
                					}
                				}
                			}
                		}
                		break;
                	case 'tirestatus_carno':
                        var as = _q_appendData("view_tirestatus", "", true);
                        q_gridAddRow(bbsHtm, 'tbbs', 'txtBtireno,txtPosition', as.length, as, 'noa,position', '', '');
                       	tire_ds.combRefresh();
                       	sum();
                        break;
                    case 'tirestatus_carplateno':
                        var as = _q_appendData("view_tirestatus", "", true);
                        q_gridAddRow(bbsHtm, 'tbbs', 'txtBtireno,txtPosition', as.length, as, 'noa,position', '', '');
                        sum();
                        break;   
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        break;
                }
            }

            function q_stPost() {
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
            	if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
				if($.trim($('#txtNick')).length==0){
					$('#txtNick').val($('#txtTgg').val().substring(0,4));
				}
                if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }else{
                	alert("error: btnok!")
                }   
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tire') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('tire_ds_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
            }
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                		$('#txtPrice_'+i).change(function(){
                			sum();
                		});
                		$('#combPosition_'+i).change(function(){
                			var n = $(this).attr('id').replace('combPosition_','');
                			$('#txtPosition_'+n).val($(this).attr('value'));
                		});
                    }
                }
                _bbsAssign();
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtDatea').focus();
            }

            function btnPrint() {
				q_box("z_fixa_ds.aspx?;;;;"+r_accy, 'z_fixa_ds', "95%", "95%", q_getMsg("popFixa"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['btireno'] && !as['etireno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
                var t_money = 0;
                for (var i = 0; i < q_bbsCount; i++) {
                	if($.trim($('#txtEtireno_'+i).val).length==0)
                		$('#txtPrice_'+i).val(0);
					t_money += q_float('txtPrice_'+i);
                }
                $('#txtCmoney').val(FormatNumber(t_money));
            }

            function refresh(recno) {
                _refresh(recno);
                tire_ds.combRefresh();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur==1 || q_cur==2){
                	$('.position').removeAttr('disabled');
                }else{
                	$('.position').attr('disabled','disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                tire_ds.combRefresh();
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
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
            function FormatNumber(n) {
            	var xx = "";
            	if(n<0){
            		n = Math.abs(n);
            		xx = "-";
            	}     		
                n += "";
                var arr = n.split(".");
                var re = /(\d{1,3})(?=(\d{3})+$)/g;
                return xx+arr[0].replace(re, "$1,") + (arr.length == 2 ? "." + arr[1] : "");
            }
			Number.prototype.round = function(arg) {
			    return Math.round(this * Math.pow(10,arg))/ Math.pow(10,arg);
			}
			Number.prototype.div = function(arg) {
			    return accDiv(this, arg);
			}
            function accDiv(arg1, arg2) {
			    var t1 = 0, t2 = 0, r1, r2;
			    try { t1 = arg1.toString().split(".")[1].length } catch (e) { }
			    try { t2 = arg2.toString().split(".")[1].length } catch (e) { }
			    with (Math) {
			        r1 = Number(arg1.toString().replace(".", ""))
			        r2 = Number(arg2.toString().replace(".", ""))
			        return (r1 / r2) * pow(10, t2 - t1);
			    }
			}
			Number.prototype.mul = function(arg) {
			    return accMul(arg, this);
			}
			function accMul(arg1, arg2) {
			    var m = 0, s1 = arg1.toString(), s2 = arg2.toString();
			    try { m += s1.split(".")[1].length } catch (e) { }
			    try { m += s2.split(".")[1].length } catch (e) { }
			    return Number(s1.replace(".", "")) * Number(s2.replace(".", "")) / Math.pow(10, m)
			}
			Number.prototype.add = function(arg) {
		   		return accAdd(arg, this);
			}
			function accAdd(arg1, arg2) {
			    var r1, r2, m;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2))
			    return (arg1 * m + arg2 * m) / m
			}
			Number.prototype.sub = function(arg) {
			    return accSub(this,arg);
			}
			function accSub(arg1, arg2) {
			    var r1, r2, m, n;
			    try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
			    try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
			    m = Math.pow(10, Math.max(r1, r2));
			    n = (r1 >= r2) ? r1 : r2;
			    return parseFloat(((arg1 * m - arg2 * m) / m).toFixed(n));
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
                width: 450px;
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
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
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
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }

		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewDatea"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewCarno"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewTgg"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="nick" style="text-align: center;">~nick</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td><input id="txtNoa"type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td><input id="txtCarno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCarplate" class="lbl" style="display:none;"> </a></td>
						<td><input id="txtCarplateno"  type="text" class="txt c1" style="display:none;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn" > </a></td>
						<td colspan="3">
							<input id="txtTggno" type="text" style="float:left;width:40%;"/>
							<input id="txtTgg" type="text" style="float:left;width:60%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMiles" class="lbl"> </a></td>
						<td><input id="txtMiles"type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWmoney" class="lbl"> </a></td>
						<td><input id="txtWmoney"type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCmoney" class="lbl"> </a></td>
						<td><input id="txtCmoney"type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDmoney" class="lbl"> </a></td>
						<td><input id="txtDmoney"type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo"type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker"type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2"type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
			<div style="width:200px;height:200px;float:left;background:gray;">
				<img id="img" style="width:100%;height:100%;">
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:80px;"><a id='lblPosition_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblBtireno_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblAction_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblEtireno_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input type="text" id="txtPosition.*" style="width:20%;"/>
						<select id="combPosition.*" class="position" style="width:70%;"> </select>
					</td>
					<td><input type="text" id="txtBtireno.*" style="width:95%;"/></td>
					<td><select id="cmbAction.*" style="width:95%;"> </select></td>
					<td><input type="text" id="txtEtireno.*" style="width:95%;"/></td>
					<td><input type="text" id="txtPrice.*" style="width:95%;text-align: right;"/></td>
					<td><input type="text" id="txtMemo.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		
		<input id="q_sys" type="hidden" />
	</body>
</html>
