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

            var q_name = "tirestk";
            var q_readonly = ['txtIndate','txtOutdate','txtFixinno'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            aPop = new Array(['txtBrandno', 'lblBrand', 'carbrand', 'noa,brand', 'txtBrandno,txtBrand', 'carbrand_b.aspx'], 
            ['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx'], 
            ['txtCarno', 'lblCarno', 'car2', 'a.noa','txtCarno', 'car2_b.aspx'],
            ['txtFixtggno', 'lblFixtgg', 'tgg', 'noa,comp', 'txtFixtggno,txtFixtgg', 'tgg_b.aspx']);
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
                mainForm(0);
            }

            function mainPost() {
            	bbmMask = [['txtIndate', r_picd],['txtOutdate', r_picd],['txtDeldate', r_picd]];
                q_mask(bbmMask);
                q_cmbParse("cmbPosition", q_getPara('tire.position'));
                q_cmbParse("cmbTypea", q_getPara('tire.typea'));
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }  
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                } 
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('tirestk_s.aspx', q_name + '_s', "500px", "380px", q_getMsg("popSeek"));
            }

            function btnIns() {
            	alert('請由輪胎進貨作業輸入。');
            }

            function btnModi() {
            	alert('請由輪胎進貨作業輸入。');
            }

            function btnPrint() {

            }

            function btnOk() {
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
                alert('禁止刪除。');
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
                width: 380px; 
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
                width: 570px;
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
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
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
						<td align="center" style="width:150px; color:black;"><a id="vewNoa"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewCarno"> </a></td>
						<td align="center" style="width:100px; color:black;"><a id="vewCarplate"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="noa" style="text-align: center;">~noa</td>
						<td id="carno" style="text-align: center;">~carno</td>
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
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td colspan="2"><input id="txtNoa"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNamea' class="lbl"> </a></td>
						<td colspan="4">
							<input id="txtProductno"  type="text"  class="txt" style="width: 25%;"/>
							<input id="txtProduct"  type="text"  class="txt" style="width: 75%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBrand' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtBrandno"  type="text"  class="txt" style="width: 25%;"/>
							<input id="txtBrand"  type="text"  class="txt" style="width: 75%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCarno' class="lbl"> </a></td>
						<td><input id="txtCarno"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblCarplate' class="lbl"> </a></td>
						<td><input id="txtCarplateno"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPosition' class="lbl"> </a></td>
						<td><select id="cmbPosition" class="txt c1"> </select></td>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td><input id="txtPrice"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIndate' class="lbl"> </a></td>
						<td><input id="txtIndate"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblOutdate' class="lbl"> </a></td>
						<td><input id="txtOutdate"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblDeldate' class="lbl"> </a></td>
						<td><input id="txtDeldate"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTgg' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtTggno"  type="text"  class="txt" style="width: 25%;"/>
							<input id="txtTgg"  type="text"  class="txt" style="width: 75%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFixtgg' class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtFixtggno" type="text"  class="txt" style="width: 25%;"/>
							<input id="txtFixtgg" type="text"  class="txt" style="width: 75%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblFixinno' class="lbl"> </a></td>
						<td colspan="2"><input id="txtFixinno"  type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
