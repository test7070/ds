<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
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
            var q_name = "fixout";
            var q_readonly = ['txtNoa', 'txtWmoney', 'txtCmoney', 'txtDmoney', 'txtMoney', 'txtWorker', 'txtWorker2'];
            var q_readonlys = ['txtTypea','txtMoney'];
            var bbmNum = new Array(['txtWmoney', 10, 0, 1],['txtCmoney', 10, 0, 1],['txtDmoney', 10, 0, 1],['txtMoney', 10, 0, 1], ['txtMiles', 10, 0, 1]);
            var bbsNum = new Array(['txtPrice', 10, 2, 1], ['txtMount', 10, 2, 1], ['txtMoney', 10, 0, 1]);
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            aPop = new Array(['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
            , ['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', '0txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
            , ['txtCarplateno', 'lblCarplateno', 'carplate', 'noa,carplate,driver', 'txtCarplateno', 'carplate_b.aspx']
            , ['txtProductno_', 'btnProductno_', 'fixucc', 'noa,namea,typea,brand,unit,inprice', 'txtProductno_,txtProduct_,txtTypea_,txtBrand_,txtUnit_,txtPrice_', 'fixucc_b.aspx']
            , ['txtTireno_', 'btnTirestk_', 'view_tirestk', 'noa,productno,product,brandno,brand,price', 'txtTireno_,txtProductno_,txtProduct_,txtBrandno_,txtBrand_,txtPrice_', 'tirestk_b.aspx']);

            function currentData() {
            }

            currentData.prototype = {
                data : [],
                /*新增時複製的欄位*/
                include : ['txtDatea', 'txtOutdate', 'txtMon', 'cmbTypea'],
                /*記錄當前的資料*/
                copy : function() {
                    curData.data = new Array();
                    for (var i in fbbm) {
                        var isInclude = false;
                        for (var j in curData.include) {
                            if (fbbm[i] == curData.include[j]) {
                                isInclude = true;
                                break;
                            }
                        }
                        if (isInclude) {
                            curData.data.push({
                                field : fbbm[i],
                                value : $('#' + fbbm[i]).val()
                            });
                        }
                    }
                },
                /*貼上資料*/
                paste : function() {
                    for (var i in curData.data) {
                        $('#' + curData.data[i].field).val(curData.data[i].value);
                    }
                }
            };
            var curData = new currentData();
            function fixout_dsData(){}
			fixout_dsData.prototype = {
				carkind : new Array(),
				combRefresh : function(){
					q_gt('car2', "where=^^ carno='"+$.trim($('#txtCarno').val())+"'^^", 0, 0, 0, "combRefresh", r_accy);
				}
			}
			var fixout_ds = new fixout_dsData();
			
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
                bbmMask = [['txtDatea', r_picd], ['txtOutdate', r_picd], ['txtMon', r_picm]];
                q_mask(bbmMask);
            }
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }/// end Switch
                b_pop = '';
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
                				fixout_ds.carkind.push({noa:as[i].noa,kind:as[i].kind,img:as[i].img,item:t_item});
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
                			for(var i=0;i<fixout_ds.carkind.length;i++){
                				if(fixout_ds.carkind[i].noa==as[0].carkindno){
                					$('#img').attr('src','../image/'+fixout_ds.carkind[i].img);
                					t_index = i;
                					string = '<option></option>';
                					for(var j=0;j<fixout_ds.carkind[i].item.length;j++){
                						string += '<option value="'+fixout_ds.carkind[i].item[j].position+'">'+fixout_ds.carkind[i].item[j].namea+'</option>';
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
                				for(var j=0;j<fixout_ds.carkind[t_index].item.length;j++){
                					if(fixout_ds.carkind[t_index].item[j].position==t_position){
                						$('#combPosition_'+i).val(t_position);
                						break;
                					}
                				}
                			}
                		}
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	if(t_name.substring(0,10)=="getProduct"){
                    		var n = parseFloat(t_name.split('_')[1]); 
                    		var as = _q_appendData("fixucc", "", true);
                       		if (as[0] != undefined) {
                       			$('#txtTypea_'+n).val(as[0].typea);
                       		}
	                    	refreshBbs();
	                    	var t_tireno = $.trim($('#txtTireno_'+n).val());
	                    	if(t_tireno.length>0){
	                    		var t_mount = q_float('txtMount_' + n);
	                    		var t_price = q_float('txtPrice_' + n);
	                    		$('#txtMoney_'+n).val(FormatNumber(t_mount.mul(t_price).round(0)));
	                    	}
	                    	var t_datea = $.trim($('#txtOutdate').val());
	                    	var t_noa = $.trim($('#txtNoa').val());
	                    	var t_productno = $.trim($('#txtProductno_'+n).val());
	                    	if(t_datea.length==0){
	                    		Lock(1,{opacity:0});
	                    		alert('請輸入'+q_getMsg('lblOutdate'));
	                    		Unlock(1);
	                        }else if(t_productno.length>0){
	                    		var t_where = " where=^^ a.noa='"+t_productno+"' ^^"
									+ " where[1]=^^a.productno='"+t_productno+"' and b.indate>=ISNULL(c.begindate,'')^^"
									+ " where[2]=^^a.noa!='"+t_noa+"' and a.productno='"+t_productno+"' and b.outdate>=ISNULL(c.begindate,'')^^";
								q_gt('fixuccstk', t_where, 0, 0, 0, "checkStk_change_"+t_datea +"_"+t_productno +"_"+n, r_accy);
	                    	}
                    	}else if(t_name.substring(0,15)=="checkStk_change"){
                    		var t_datea = t_name.split('_')[2];
                    		var t_productno = t_name.split('_')[3];
                    		var t_sel = parseFloat(t_name.split('_')[4]);
                    		var t_stkmount = 0;
                    		var t_mount = 0;
                    		var as = _q_appendData("fixucc", "", true);
                       		if (as[0] != undefined) {
                       			if(as[0].begindate > t_datea){
                       				//異動日期<期初日期的資料不允許修改
                       				alert('日期異常:'+t_productno+q_getMsg('lblOutdate')+'【'+t_datea+'】小於期初日期【'+as[0].begindate+'】 。');
	                    			Unlock(1);
	                    			$('#txtMount_'+t_sel).focus();
	                    			return;
                       			}
                       			t_stkmount = parseFloat(as[0].mount.length==0?"0":as[0].mount);
                       		}
                       		for (var i = 0; i < q_bbsCount; i++) {
                       			if($('#txtProductno_'+i).val()==t_productno){
                       				t_mount += q_float('txtMount_'+i);
                       			}
                       		}
                    		if($('#txtTypea_'+t_sel).val()!='工資' && t_stkmount-t_mount<0){
                    			alert(t_productno+'庫存不足，當前庫存 '+t_stkmount+'。');
                    			Unlock(1);
                    			$('#txtMount_'+t_sel).focus();
                    			return;
                    		}
                    	}if(t_name.substring(0,14)=="checkStk_btnOk"){
                    		var t_datea = t_name.split('_')[2];
                    		var t_productno = t_name.split('_')[3];
                    		var t_sel = parseFloat(t_name.split('_')[4]);
                    		var t_stkmount = 0;
                    		var t_mount = 0;
                    		var as = _q_appendData("fixucc", "", true);
                       		if (as[0] != undefined) {
                       			if(as[0].begindate > t_datea){
                       				//異動日期<期初日期的資料不允許修改
                       				alert('日期異常:'+t_productno+q_getMsg('lblOutdate')+'【'+t_datea+'】小於期初日期【'+as[0].begindate+'】 。');
	                    			Unlock(1);
	                    			$('#txtMount_'+t_sel).focus();
	                    			return;
                       			}
                       			t_stkmount = parseFloat(as[0].mount.length==0?"0":as[0].mount);
                       		}
                       		for (var i = 0; i < q_bbsCount; i++) {
                       			if($('#txtProductno_'+i).val()==t_productno){
                       				t_mount += q_float('txtMount_'+i);
                       			}
                       		}
                    		if($('#txtTypea_'+t_sel).val()!='工資' && t_stkmount-t_mount<0){
                    			alert(t_productno+'庫存不足，當前庫存 '+t_stkmount+'。');
                    			Unlock(1);
                    			$('#txtMount_'+t_sel).focus();
                    			return;
                    		}else{
                    			checkStkBtnOk(t_sel-1);
                    		}
                    	}
                    	break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }

            function btnOk() {
                Lock(1,{opacity:0});
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
                if ($('#txtOutdate').val().length == 0 || !q_cd($('#txtOutdate').val())) {
                    alert(q_getMsg('lblOutdate') + '錯誤。');
                    Unlock(1);
                    return;
                }
                $('#txtMon').val($.trim($('#txtMon').val()));
                if ($('#txtMon').val().length > 0 && !(/^[0-9]{3}\/(?:0?[1-9]|1[0-2])$/g).test($('#txtMon').val())) {
                    alert(q_getMsg('lblMon') + '錯誤。');
                    Unlock(1);
                    return;
                }
                for (var i = 0; i < q_bbsCount; i++) {
                	if($('#txtProductno_'+i).val().length>0){
                		if((/^(\w+|\w+\u002D\w+)$/g).test($('#txtProductno_'+i).val())){
						}else{
							alert('編號只允許 英文(A-Z)、數字(0-9)及連字號(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock(1);
							return;
						}
                	}
                    for (var j = 0; j < q_bbsCount; j++) {
                        if (i != j && $('#txtTireno_' + i).val() == $('#txtTireno_' + j).val() && $('#txtTireno_' + i).val() != '' && $('#txtTireno_' + j).val()) {
                            alert('胎號重複，請修改');
                            Unlock(1);
                            return;
                        }
                    }
                }
                sum();
                checkStkBtnOk(q_bbsCount-1);
            }
            function checkStkBtnOk(n){
            	if(n<0){
            		if (q_cur == 1) {
	                    $('#txtWorker').val(r_name);
	                } else if (q_cur == 2) {
	                    $('#txtWorker2').val(r_name);
	                } else {
	                    alert("error: btnok!")
	                }
	                var t_noa = trim($('#txtNoa').val());
	                var t_date = trim($('#txtDatea').val());
	                if (t_noa.length == 0 || t_noa == "AUTO")
	                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_fixout') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
	                else
	                    wrServer(t_noa);
            	}else{
            		var t_datea = $.trim($('#txtOutdate').val());
            		var t_noa = $.trim($('#txtNoa').val());
                	var t_productno = $.trim($('#txtProductno_'+n).val());
                	if(t_productno.length>0){
                		var t_where = " where=^^ a.noa='"+t_productno+"' ^^"
							+ " where[1]=^^a.productno='"+t_productno+"' and b.indate>=ISNULL(c.begindate,'')^^"
							+ " where[2]=^^a.noa!='"+t_noa+"' and a.productno='"+t_productno+"' and b.outdate>=ISNULL(c.begindate,'')^^";
						q_gt('fixuccstk', t_where, 0, 0, 0, "checkStk_btnOk_"+t_datea +"_"+t_productno +"_"+n, r_accy);
                	}else{
                		checkStkBtnOk(n-1)
                	}
            	}
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('fixout_ds_s.aspx', q_name + '_s', "520px", "500px", q_getMsg("popSeek"));
            }

            function q_popPost(s1) {
                switch (s1) {
                	case 'txtCarno':
                    	fixout_ds.combRefresh();
                    	break;
                    case 'txtTireno_':
                    	var n = b_seq;
                    	var t_where = "where=^^ noa='"+$.trim($('#txtProductno_'+n).val())+"' ^^"
                    	q_gt('fixucc', t_where, 0, 0, 0, "getProduct_"+n, r_accy);
                        break;
                }
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	$('#txtProductno_'+i).change(function(e){
		                	$(this).val($.trim($(this).val()).toUpperCase());    	
							if($(this).val().length>0){
								if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
								}else{
									Lock(1,{opacity:0});
									alert('編號只允許 英文(A-Z)、數字(0-9)及連字號(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
									Unlock(1);
								}
							}
		                });
                        $('#txtMount_' + i).change(function(e) {
                        	var n = $(this).attr('id').replace('txtMount_','');
                        	var t_datea = $.trim($('#txtOutdate').val());
                        	var t_noa = $.trim($('#txtNoa').val());
                        	var t_productno = $.trim($('#txtProductno_'+n).val());
                        	if(t_datea.length==0){
                        		Lock(1,{opacity:0});
                        		alert('請輸入'+q_getMsg('lblOutdate'));
                        		Unlock(1);
                        	}else if(t_productno.length>0 && (/^(\w+|\w+\u002D\w+)$/g).test(t_productno)){
								var t_where = " where=^^ a.noa='"+t_productno+"' ^^"
									+ " where[1]=^^a.productno='"+t_productno+"' and b.indate>=ISNULL(c.begindate,'')^^"
									+ " where[2]=^^a.noa!='"+t_noa+"' and a.productno='"+t_productno+"' and b.outdate>=ISNULL(c.begindate,'')^^";
								q_gt('fixuccstk', t_where, 0, 0, 0, "checkStk_change_"+t_datea +"_"+t_productno +"_"+n, r_accy);
							}else{
								sum();
							}                        	
                        });
                        $('#txtPrice_' + i).change(function(e) {
                            sum();
                        });
                        $('#txtMoney_' + i).change(function(e) {
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
                curData.copy();
                _btnIns();
                curData.paste();
                $('#txtNoa').val('AUTO');
                if ($('#txtDatea').val().length == 0)
                    $('#txtDatea').val(q_date());
                if ($('#txtMon').val().length == 0)
                    $('#txtMon').val(q_date().substring(0, 6));
                refreshBbs();
                $('#txtCarno').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbs();
                sum();
                $('#txtOutdate').focus();
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
                if (!as['productno'] && !as['product'] ) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
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
		        $('#txtWmoney').val(FormatNumber(t_wmoney));
		        $('#txtCmoney').val(FormatNumber(t_cmoney));
		        $('#txtDmoney').val(FormatNumber(t_dmoney));
		        $('#txtMoney').val(FormatNumber(t_wmoney.add(t_cmoney)));
            }

            function refresh(recno) {
                _refresh(recno);
                fixout_ds.combRefresh();
                refreshBbs();
            }
            function refreshBbs(){
            	if(q_cur==1 || q_cur==2)
	            	for (var i = 0; i < q_bbsCount; i++) {
	            		if($.trim($('#txtTireno_'+i).val()).length>0){
	            			$('#btnProductno_'+i).attr('disabled','disabled');
	            			$('#txtProductno_'+i).attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
	            			$('#txtProduct_'+i).attr('readonly','readonly').css('color','green').css('background','rgb(237,237,237)');
	            		}else{
	            			$('#btnProductno_'+i).removeAttr('disabled');
	            			$('#txtProductno_'+i).removeAttr('readonly').css('color','black').css('background','white');
	            			$('#txtProduct_'+i).removeAttr('readonly').css('color','black').css('background','white');
	            		}	
	            	}
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
            }
            function btnPlus2() {
			    fixout_ds.combRefresh();
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
                width: 400px;
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
                width: 400px;
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
            .tbbm .trX {
                background-color: #FFEC8B;
            }
            .tbbm .trY {
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
						<td align="center" style="width:80px; color:black;"><a id="vewOutdate"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewCarno"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewDriver"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewCarplate"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="outdate" style="text-align: center;">~outdate</td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="driver" style="text-align: center;">~driver</td>
						<td id="carplateno" style="text-align: center;">~carplateno</td>
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
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblOutdate" class="lbl"> </a></td>
						<td><input id="txtOutdate" type="text" class="txt c1"/></td>	
						<td><span> </span><a id="lblMon" class="lbl"> </a></td>
						<td><input id="txtMon" type="text" class="txt c1"/></td>			
					</tr>
					<tr>
						<td><span> </span><a id="lblCarno" class="lbl btn"> </a></td>
						<td><input id="txtCarno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtDriverno" type="text" style="float:left; width:50%;"/>
							<input id="txtDriver" type="text" style="float:left; width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCarplate" class="lbl btn" style="display:none;"> </a></td>
						<td><input id="txtCarplateno" type="text" class="txt c1" style="display:none;"/></td>
						<td><span> </span><a id="lblMiles" class="lbl"> </a></td>
						<td><input id="txtMiles" type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblWmoney" class="lbl"> </a></td>
						<td><input id="txtWmoney" type="text" class="txt num c1" /></td>
					</tr>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblCmoney" class="lbl"> </a></td>
						<td><input id="txtCmoney" type="text" class="txt num c1" /></td>

					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblDmoney" class="lbl"> </a></td>
						<td><input id="txtDmoney" type="text" class="txt num c1" /></td>
					</tr>
					<tr>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblMoney" class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1" /></td>
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
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:100px;"><a id='lblTireno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblProductno_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblProduct_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblBrand_s'> </a></td>
					<td align="center" style="width: 60px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width: 70px;"><a id='lblPrice_s'> </a></td>
					<td align="center" style="width: 70px;"><a id='lblMount_s'> </a></td>
					<td align="center" style="width: 70px;"><a id='lblMoney_s'> </a></td>
					<td align="center" style="width: 40px;"><a id='lblTypea_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:180px;"><a id='lblPosition_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input id="txtTireno.*" type="text" style="width: 95%;"/></td>
					<td>
						<input id="btnProductno.*" type="button" style="width: 10%;font-size: medium;"/>
						<input id="txtProductno.*" type="text" style="width: 80%;" />
					</td>
					<td><input id="txtProduct.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtBrand.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtUnit.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtPrice.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtMount.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtMoney.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtTypea.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtMemo.*" type="text" style="width: 95%;"/></td>
					<td>
						<input type="text" id="txtPosition.*" style="width:20%;"/>
						<select id="combPosition.*" class="position" style="width:70%;"> </select>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
