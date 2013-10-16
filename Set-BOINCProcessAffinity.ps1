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

$cpus = 1,2,4,8,16,32,64,128,255,255,255,255
$i = 0
#get-process | ? { ($_.path -match 'boinc') -and ($_.priorityclass -ne 'Normal') -and ($_.Name -notmatch "hadcm3n_6.07_windows_intelx86") } | select name,cpu,priorityclass,processoraffinity,userprocessortime | ft -a
get-process | ? { ($_.path -match 'boinc') -and ($_.priorityclass -ne 'Normal') -and ($_.Name -notmatch "hadcm3n_6.07_windows_intelx86") } | % { `
    $_.ProcessorAffinity = $cpus[$i++]
}
#get-process | ? { ($_.path -match 'boinc') -and ($_.priorityclass -ne 'Normal') -and ($_.Name -notmatch "hadcm3n_6.07_windows_intelx86") } | select name,cpu,priorityclass,processoraffinity,userprocessortime | ft -a

Write-Output "`n$(Get-Date)- Finished script $($PSCommandPath).`n"