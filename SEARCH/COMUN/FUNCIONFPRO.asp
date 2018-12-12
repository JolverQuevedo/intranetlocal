<script ID="clientEventHandlersJS" LANGUAGE="javascript">
function EMAIL()
{	CAD = 'HELP/hlpEMAIL.asp?pro='+trim(thisForm.PPROTO.value);
	CAD = CAD + '&ver=' + trim(thisForm.PVERSION.value);
	CAD = CAD + '&CLI=' + ltrim(thisForm.CLI.options(thisForm.CLI.selectedIndex).innerText);
	CAD = CAD + '&EST=' + trim(thisForm.CODEST.value);
	CAD = CAD + '&TEM=' + trim(thisForm.TEM.value);
	window.open(CAD)
}
</SCRIPT>