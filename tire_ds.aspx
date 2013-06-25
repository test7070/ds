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
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [['txtMiles',10,0,1],['txtWmoney',10,0,1],['txtCmoney',10,0,1],['txtDmoney',10,0,1]];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'Datea';
            //ajaxPath = "";
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa','txtCarno', 'car2_b.aspx'],
            		['txtTggno', 'lblTgg', 'tgg', 'noa,comp,nick', 'txtTggno,txtTgg,txtNick', 'tgg_b.aspx'],
            		['txtEtireno_', '', 'tirestk', 'noa,product','txtEtireno_', 'tirestk_b.aspx']);
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                brwCount2 = 6;
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
            });
      
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }///  end Main()

            function pop(form) {
                b_pop = form;
            }

            function mainPost() {
                q_getFormat();
                bbmMask = [['txtDatea', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbPosition", q_getPara('tire.position'),'s');
                q_cmbParse("cmbAction", q_getPara('tire.action'),'s');
            }
			function q_popFunc(id,key_value){
            	switch(id) {
                    case 'txtCarno':
                    	var t_where = "where=^^carno='"+key_value+"'^^order=^^position^^";
                    	q_gt('tirestk', t_where, 0, 0, 0, "");
                    	break;
                }
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
                	case 'tirestk':
                        var as = _q_appendData("tirestk", "", true);

                        q_gridAddRow(bbsHtm, 'tbbs', 'txtBtireno,cmbPosition', as.length, as, 'noa,position', '', '');

                        /*for( i = 0; i < q_bbsCount; i++) {
                            _btnMinus("btnMinus_" + i);
                            if(i < as.length) {
                                $('#txtOrdeno_' + i).val(as[i].ordeno);
                               
                            }
                        }*/
                        break;
                        
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();

                        if (q_cur == 1 || q_cur == 2)
                            q_changeFill(t_name, ['txtGrpno', 'txtGrpname'], ['noa', 'comp']);

                        break;
                }  /// end switch
            }

            function btnOk() {
                t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')]]);
                if (t_err.length > 0) {
                    alert(t_err);
                    return;
                }
                $('#txtWorker').val(r_name)
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
                q_box('tire_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
            }
            function bbsAssign() {
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
			q_box('z_tire.aspx', '', "800px", "600px", q_getMsg("popPrint"));
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
                var t1 = 0, t_unit, t_mount, t_weight = 0;
                for (var j = 0; j < q_bbsCount; j++) {

                }// j
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
						<td><span> </span><a id="lblCarplate" class="lbl"> </a></td>
						<td><input id="txtCarplateno"  type="text" class="txt c1"/></td>
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
			<div style="width:150px;float:left;">
				<img src="../image/car.jpg"/>
				<img src="../image/ben.jpg"/>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs' style=' text-align:center'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:50px;"><a id='lblPosition_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblBtireno_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblAction_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblEtireno_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblMemo_s'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><select id="cmbPosition.*" style="width:95%;"> </select></td>
					<td><input type="text" id="txtBtireno.*" style="width:95%;"/></td>
					<td><select id="cmbAction.*" style="width:95%;"> </select></td>
					<td><input type="text" id="txtEtireno.*" style="width:95%;"/></td>
					<td><input type="text" id="txtMemo.*" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		
		<input id="q_sys" type="hidden" />
	</body>
</html>
