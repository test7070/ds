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
            var q_name = "custchg";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2', 'txtTrdno'];
            var bbmNum = new Array(['txtMinusmoney', 10, 0], ['txtPlusmoney', 10, 0]);
            var bbmMask = [['txtDatea', '999/99/99']];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            q_copy = 1;
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx']
            , ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
            , ['txtCustno2', 'lblCust2', 'cust', 'noa,comp', 'txtCustno2,txtCust2', 'cust_b.aspx']
            , ['txtCno', 'lblAcomp', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
            , ['txtMinusitemno', 'lblMinusitem', 'chgitem', 'noa,item,acc1,acc2', 'txtMinusitemno,txtMinusitem,txtAcc1,txtAcc2', 'chgitem_b.aspx']
            , ['txtPlusitemno', 'lblPlusitem', 'chgitem', 'noa,item,acc1,acc2', 'txtPlusitemno,txtPlusitem,txtAcc1,txtAcc2', 'chgitem_b.aspx']
            , ['txtAcc1', 'lblAcc1', 'acc', 'acc1,acc2', 'txtAcc1,txtAcc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]
            ,['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno', 'car2_b.aspx']);
           	q_xchg = 1;
            brwCount2 = 20;
           
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                q_mask(bbmMask);
                $('#txtAcc1').change(function() {
                     var patt = /^(\d{4})([^\.,.]*)$/g;
                    $(this).val($(this).val().replace(patt,"$1.$2"));
                });
                $('#txtMinusitemno').blur(function(e) {
					$('#txtMinusitem').focus();
				});
				$('#txtPlusitemno').blur(function(e) {
					$('#txtPlusitem').focus();
				});
            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }   /// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'btnDele':
                		var as = _q_appendData("paybs", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "";
                        	for(var i=0;i<as.length;i++){
                    			t_msg += String.fromCharCode(13)+'立帳單號【'+as[i].noa+'】 ';
                        	}
                        	if(t_msg.length>0){
                        		alert('已立帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
                    	_btnDele();
                    	Unlock(1);
                		break;
                	case 'btnModi':
                		var as = _q_appendData("paybs", "", true);
                        if (as[0] != undefined) {
                        	var t_msg = "";
                        	for(var i=0;i<as.length;i++){
                    			t_msg += String.fromCharCode(13)+'立帳單號【'+as[i].noa+'】 ';
                        	}
                        	if(t_msg.length>0){
                        		alert('已立帳:'+ t_msg);
                        		Unlock(1);
                        		return;
                        	}
                        }
	                	_btnModi();
				        sum();
	                	Unlock(1);
                		$('#txtDatea').focus();
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }
            function q_popPost(id) {
				switch(id) {
					case 'txtMinusitemno':
						if(q_cur==1 || q_cur==2){
							$('#txtMinusitem').focus();
						}
						break;
					case 'txtPlusitemno':
						if(q_cur==1 || q_cur==2){
							$('#txtPlnusitem').focus();
						}
						break;
				}
			}
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('custchg_ds_s.aspx', q_name + '_s', "530px", "500px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
                $('#txtTrdno').val('');//複製時排除
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                Lock(1,{opacity:0});
                t_where=" where=^^ rc2no='"+$('#txtNoa').val()+"'^^";
            	q_gt('paybs', t_where, 0, 0, 0, "btnModi", r_accy);
            }
            function btnPrint() {
				q_box('z_custchg_ds.aspx?;;;'+r_accy, '', "95%", "95%", q_getMsg("popPrint"));
            }
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            function btnOk() {
            	Lock(1,{opacity:0});
            	$('#txtDatea').val($.trim($('#txtDatea').val()));
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock();
                    return;
                }
                sum();
                if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                	$('#txtWorker2').val(r_name);
                }else{
                	alert("error: btnok!")
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_custchg') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function sum() {
            }

            function wrServer(key_value) {
                var i;
                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);

            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(q_cur==1 || q_cur==2){
                    $('#txtDatea').datepicker();
                }
                else{
                    $('#txtDatea').datepicker('destroy');
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
                Lock(1,{opacity:0});
                t_where=" where=^^ rc2no='"+$('#txtNoa').val()+"'^^";
            	q_gt('paybs', t_where, 0, 0, 0, "btnDele", r_accy);
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
                width: 950px; 
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
                width: 950px;
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
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
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
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:140px; color:black;"><a id='vewComp'> </a></td>
						<td align="center" style="width:300px; color:black;"><a id='vewItem'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewMinusmoney'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewPlusmoney'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewTrdno'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" /></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="comp,4" style="text-align: center;">~comp,4</td>
						<td id="minusitem plusitem" style="text-align: left;">~minusitem ~plusitem</td>
						<td id="minusmoney,0,1" style="text-align: right;">~minusmoney,0,1</td>
						<td id="plusmoney,0,1" style="text-align: right;">~plusmoney,0,1</td>
						<td id="trdno" style="text-align: left;">~trdno</td>
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
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcomp" class="lbl btn" > </a></td>
						<td colspan="4">
						<input id="txtCno"  type="text"  class="txt"  style="float:left;width:20%;"/>
						<input id="txtAcomp"  type="text"  class="txt" style="float:left;width:80%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn" > </a></td>
						<td colspan="4">
						<input id="txtCustno"  type="text"  class="txt" style="float:left;width:25%;"/>
						<input id="txtComp"  type="text"  class="txt" style="float:left;width:75%;"/>
						</td>
						<td style="display:none;"><span> </span><a id="lblCarno" class="lbl btn" > </a></td>
						<td style="display:none;"><input id="txtCarno"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMinusitem" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtMinusitemno"  type="text" style="float:left;width:30%;"/>
						<input id="txtMinusitem"  type="text"  style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblMinusmoney" class="lbl"> </a></td>
						<td><input id="txtMinusmoney"  type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust2" class="lbl btn" style="text-align: left;display:none;"> </a></td>
						<td colspan="3">
							<input id="txtCustno2"  type="text" style="float:left;width:30%;display:none;"/>
							<input id="txtCust2"  type="text" style="float:left;width:70%;display:none;"/>
						</td>
						<td><a class="lbl" style="text-align: left;display:none;">(應收立帳匯入)</a></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPlusitem" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtPlusitemno"  type="text" style="float:left;width:30%;"/>
						<input id="txtPlusitem"  type="text" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblPlusmoney" class="lbl"> </a></td>
						<td><input id="txtPlusmoney"  type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno"  type="text" style="float:left;width:30%;"/>
							<input id="txtTgg"  type="text" style="float:left;width:70%;"/>
						</td>
						<td><a class="lbl" style="text-align: left;">(應付立帳匯入)</a></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblAcc1" class="lbl btn"> </a></td>
						<td colspan="3">
						<input id="txtAcc1" type="text" style="float:left;width:30%;"/>
						<input id="txtAcc2" type="text" style="float:left;width:70%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text" class="txt c1" /></td>
						<td><span> </span><a id='lblTrdno' class="lbl"> </a></td>
						<td><input id="txtTrdno"  type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>