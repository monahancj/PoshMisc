<#
.SYNOPSIS
   <A brief description of the script>
.DESCRIPTION
   <A detailed description of the script>
.PARAMETER <paramName>
   <Description of script parameter>
.EXAMPLE
   <An example of using the script>
.Notes
   <Information that does not fit easily into the other sections>
.Link
   <Links to other Help topics and Web sites of interest>
#>

Write-Output "`n$(Get-Date)- Starting script $($PSCommandPath) with the parameters:"
Write-Output -InputObject $PSBoundParameters | Format-Table -AutoSize

gc .\statsqrwt.csv | select -skip 1 | out-file statsqrwt_fixed.csv
gc .\statsk.csv    | select -skip 1 | out-file statsk_fixed.csv
gc .\statsd.csv    | select -skip 1 | out-file statsd_fixed.csv

import-csv .\statsqrwt_fixed.csv | ? { $_.Total -gt 15 } | export-csv statsqrwt_stripped.csv
import-csv .\statsk_fixed.csv    | ? { $_.Total -gt 15 } | export-csv statsk_stripped.csv
import-csv .\statsd_fixed.csv    | ? { $_.Total -gt 15 } | export-csv statsd_stripped.csv

$x | Select @{n='Player';e={$x.player.split(' ')[0] + ' ' + $x.player.split(' ')[1] }} `
            @{n='POS';e={ $x.player.split(" ")[($x.player.split(" ") | measure).Count -2] }} `
			@{n='NFL';e={ $x.player.split(" ")[($x.player.split(" ") | measure).Count -3] }} | ft -a

Team     Opp Bye 1 2 3  4 5  6 7 8 avg total

Write-Output "`n$(Get-Date)- Finished script $($PSCommandPath).`n"