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
		    var q_name = "fixa";
		    var q_readonly = ['txtNoa', 'txtWmoney', 'txtCmoney', 'txtDmoney','txtMoney', 'txtTotal','txtWorker','txtWorker2'];
		    var q_readonlys = ['txtTypea','txtMoney'];
		    var bbmNum = new Array(['txtDiscount', 10, 0, 1], ['txtWmoney', 10, 0, 1], ['txtCmoney', 10, 0, 1], ['txtDmoney', 10, 0, 1], ['txtMoney', 10, 0, 1], ['txtTax', 10, 0, 1], ['txtTotal', 10, 0, 1]);
		    var bbsNum = new Array(['txtPrice', 10, 2, 1], ['txtMount', 10, 2, 1], ['txtMoney', 10, 0, 1]);
		    var bbmMask = [];
		    var bbsMask = [];
		    q_sqlCount = 6;
		    brwCount = 6;
		    brwList = [];
		    brwNowPage = 0;
		    brwKey = 'Datea';
		    //ajaxPath = "";
		    aPop = new Array(
		    	['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx'],
		    	['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx'], 
		    	['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtTgg,txtNick', 'tgg_b.aspx'], 
		    	['txtCarplateno', 'lblCarplateno', 'carplate', 'noa,carplate,driver', 'txtCarplateno', 'carplate_b.aspx'], 
		    	['txtProductno_', 'btnProductno_', 'fixucc', 'noa,namea,typea,unit,inprice', 'txtProductno_,txtProduct_,txtTypea_,txtUnit_,txtPrice_', 'fixucc_b.aspx']);
		    q_desc = 1;
		    
		    function currentData() {}
			currentData.prototype = {
				data : [],
				/*新增時複製的欄位*/
				include : ['txtDatea','txtFixadate','txtMon','txtTggno','txtTgg','txtNick'],
				/*記錄當前的資料*/
				copy : function() {
					this.data = new Array();
					for (var i in fbbm) {
						var isInclude = false;
						for (var j in this.include) {
							if (fbbm[i] == this.include[j]) {
								isInclude = true;
								break;
							}
						}
						if (isInclude) {
							this.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in this.data) {
						$('#' + this.data[i].field).val(this.data[i].value);
					}
				}
			};
			var curData = new currentData();
			
		    $(document).ready(function () {
		        bbmKey = ['noa'];
		        bbsKey = ['noa', 'noq'];
		        q_brwCount();
		        q_gt(q_name, q_content, q_sqlCount, 1);
		    });
		    function main() {
		        if (dataErr) {
		            dataErr = false;
		            return;
		        }
		        mainForm(1);

		    } ///  end Main()

		    function pop(form) {
		        b_pop = form;
		    }

		    function mainPost() {
		        q_getFormat();
		        bbmMask = [['txtDatea', r_picd], ['txtMon', r_picm], ['txtFixadate', r_picd]];
		        q_mask(bbmMask);
		        $('#txtTax').change(function () {
		            sum();
		        });
		        $('#txtDiscount').change(function () {
		            sum();
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
                		$('#txtCarno').focus();
                		break;
		            case q_name:
		                if (q_cur == 4)
		                    q_Seek_gtPost();
		                break;
		            default:
		            	break;
		        }  /// end switch
		    }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
		    function btnOk() {
		    	Lock(1,{opacity:0});
	            if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
				if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())){
                    alert(q_getMsg('lblMon') + '錯誤。');
                    Unlock(1);
					return;
				}
	            if($('#txtFixadate').val().length == 0 || !q_cd($('#txtFixadate').val())){
					alert(q_getMsg('lblFixadate')+'錯誤。');
            		Unlock(1);
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
		            q_gtnoa(q_name, replaceAll(q_getPara('sys.key_fixa') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
		        else
		            wrServer(t_noa);
		    }

		    function _btnSeek() {
		        if (q_cur > 0 && q_cur < 4)// 1-3
		            return;
		        q_box('fixa_ds_s.aspx', q_name + '_s', "550px", "560px", q_getMsg("popSeek"));
		    }
		    function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		        	$('#lblNo_'+i).text(i+1);
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		                $('#txtMount_' + i).change(function (e) {
		                    sum();
		                });
		                $('#txtPrice_' + i).change(function (e) {
		                    sum();
		                });
		            }
		        }
		        _bbsAssign();
		    }

		    function btnIns() {
		        curData.copy();
                _btnIns();
                curData.paste();
                $('#txtNoa').val('AUTO');
                if($('#txtDatea').val().length==0)
               		$('#txtDatea').val(q_date());
		        $('#txtCarno').focus();
		    }

		    function btnModi() {
		    	if (emp($('#txtNoa').val()))
                    return;
                Lock(1,{opacity:0});
                t_where=" where=^^ rc2no='"+$('#txtNoa').val()+"'^^";
            	q_gt('paybs', t_where, 0, 0, 0, "btnModi", r_accy);
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
		        if (!as['productno'] && !as['product']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        return true;
		    }
		    function q_popPost(t_id) {
		    	if((q_cur==1  ||  q_cur==2) && t_id.substring(0,13).toUpperCase()=='TXTPRODUCTNO_'){
		    		sum();
		    	}
            }
		    function sum() {
		    	if(!(q_cur==1 || q_cur==2))
		    		return;
		        var t_money=0,t_wmoney = 0, t_cmoney = 0, t_dmoney = 0, t_tax,t_discount;
		        for(var i=0;i<q_bbsCount;i++){
		        	t_money = q_float('txtMount_' + i).mul(q_float('txtPrice_' + i)).round(0);
		        	$('#txtMoney_'+i).val(FormatNumber(t_money));
		        	switch($('#txtTypea_' + i).val()){
		        		case '工資':
		        			t_wmoney = t_wmoney.add(t_money);
		        			break;
		        		case '輪胎':
		        			t_cmoney = t_cmoney.add(t_money);
		        			break;
		        		case '材料':
		        			t_dmoney = t_dmoney.add(t_money);
		        			break;
		        		default:
		        			$('#txtMoney_'+i).val(0);
		        			break;
		        	}
		        }	        
		        t_tax = q_float('txtTax');
		        t_discount = q_float('txtDiscount');
		        $('#txtWmoney').val(FormatNumber(t_wmoney));
		        $('#txtCmoney').val(FormatNumber(t_cmoney));
		        $('#txtDmoney').val(FormatNumber(t_dmoney));
		        $('#txtMoney').val(FormatNumber(t_wmoney.add(t_cmoney).add(t_dmoney)));
		        $('#txtTotal').val(FormatNumber(t_wmoney.add(t_cmoney).add(t_dmoney).add(t_tax).sub(t_discount)));
		    }

		    function refresh(recno) {
		        _refresh(recno);

		    }

		    function readonly(t_para, empty) {
		        _readonly(t_para, empty);
		    }

		    function btnMinus(id) {
		        _btnMinus(id);
		        sum();
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
                width: 470px;
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
                width: 480px;
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
            .tbbm .trX{
                background-color: #FFEC8B;
            }
            .tbbm .trY{
                background-color: #DAA520;
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
						<td align="center" style="width:80px; color:black;"><a id="vewDatea"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewFixadate"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewCarno"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewDriver"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewCarplateno"> </a></td>
						<td align="center" style="width:70px; color:black;"><a id="vewNick"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="fixadate" style="text-align: center;">~fixadate</td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="driver" style="text-align: center;">~driver</td>
						<td id="carplateno" style="text-align: center;">~carplateno</td>
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
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblFixadate" class="lbl"> </a></td>
						<td><input id="txtFixadate" type="text" class="txt c1"/></td>	
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>				
					</tr>
					
					<tr>
						<td><span> </span><a id="lblCarno" class="lbl btn"> </a></td>
						<td><input id="txtCarno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtDriverno" type="text" style="float:left;width:50%;"/>
							<input id="txtDriver" type="text" style="float:left;width:50%;"/>
						</td> 
					</tr>
					<tr style="display:none;">
						<td><span> </span><a id="lblCarplateno" class="lbl btn"> </a></td>
						<td><input id="txtCarplateno" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td colspan="5">
						<input id="txtTggno" type="text" class="txt"  style="width:25%;"/>
						<input id="txtTgg" type="text" class="txt" style="width:75%;"/>
						<input id="txtNick" type="text" class="txt" style="display: none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWmoney" class="lbl"> </a></td>
						<td><input id="txtWmoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblCmoney" class="lbl"> </a></td>
						<td><input id="txtCmoney" type="text" class="txt num c1" /></td>
						<td><span> </span><a id="lblDmoney" class="lbl"> </a></td>
						<td><input id="txtDmoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblInvono" class="lbl"> </a></td>
						<td colspan="3"><input id="txtInvono" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTax" class="lbl"> </a></td>
						<td><input id="txtTax" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblDiscount" class="lbl"> </a></td>
						<td><input id="txtDiscount" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblTotal" class="lbl"> </a></td>
						<td><input id="txtTotal" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="5"><input id="txtMemo" type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1" /></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:200px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblTypea_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*"  style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input id="btnProductno.*" type="button" value="" style="width: 1%;" />
						<input id="txtProductno.*" type="text" style="width:30%;"/>
						<input id="txtProduct.*"type="text" style="width:55%;"/>
					</td>
					<td><input class="txt" id="txtUnit.*" type="text" style="text-align: center;width:95%;"/></td>
					<td><input class="txt num" id="txtPrice.*" type="text"  style="width:95%;text-align:right;"/></td>
					<td><input class="txt num" id="txtMount.*" type="text"  style="width:95%;text-align:right;"/></td>
					<td><input id="txtMoney.*" type="text"  style="width:95%;text-align:right;"/></td>
					<td><input id="txtTypea.*" type="text" style="width:95%;"/></td>
					<td><input id="txtMemo.*" type="text" style="width:95%;"/></td>
				</tr>
				
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
