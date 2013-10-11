$cpus = 1,2,4,8,16,32,64,128,255,255,255,255
$i = 0
#get-process | ? { ($_.path -match 'boinc') -and ($_.priorityclass -ne 'Normal') -and ($_.Name -notmatch "hadcm3n_6.07_windows_intelx86") } | select name,cpu,priorityclass,processoraffinity,userprocessortime | ft -a
get-process | ? { ($_.path -match 'boinc') -and ($_.priorityclass -ne 'Normal') -and ($_.Name -notmatch "hadcm3n_6.07_windows_intelx86") } | % { `
    $_.ProcessorAffinity = $cpus[$i++]
}
#get-process | ? { ($_.path -match 'boinc') -and ($_.priorityclass -ne 'Normal') -and ($_.Name -notmatch "hadcm3n_6.07_windows_intelx86") } | select name,cpu,priorityclass,processoraffinity,userprocessortime | ft -a
