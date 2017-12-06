<#
    .SYNOPSIS
        A brief description of the function or script. This keyword can be used
        only once in each topic.

    .DESCRIPTION
        A detailed description of the function or script. This keyword can be
        used only once in each topic.

    .PARAMETER  <Parameter-Name>
        The description of a parameter. Add a .PARAMETER keyword for
        each parameter in the function or script syntax.

    .EXAMPLE
        A sample command that uses the function or script, optionally followed
        by sample output and a description. Repeat this keyword for each example.

    .INPUTS
        The Microsoft .NET Framework types of objects that can be piped to the
        function or script. You can also include a description of the input 
        objects.

    .OUTPUTS
        The .NET Framework type of the objects that the cmdlet returns. You can
        also include a description of the returned objects.

    .NOTES
        Additional information about the function or script.

		Created by:   	cmonahan
		Organization: 	Monster Worldwide, GTI

		Recent Comment History
		----------------------
		YYYMMDD username- 1st comment.
		YYYMMDD username- 2nd comment.
		YYYMMDD username- 3rd comment.

ToDo
----------------------
-Make move to decom folder work when connected to multiple vCenters.

	.LINK
        The name of a related topic. The value appears on the line below
        the .LINK keyword and must be preceded by a comment symbol (#) or
        included in the comment block. 

        Repeat the .LINK keyword for each related topic.

        This content appears in the Related Links section of the help topic.

        The Link keyword content can also include a Uniform Resource Identifier
        (URI) to an online version of the same help topic. The online version 
        opens when you use the Online parameter of Get-Help. The URI must begin
        with "http" or "https".

#>



Function Get-PSScriptAnalyzerViolationsAndReport
{
	
	[cmdletbinding(SupportsShouldProcess = $true)]
	param (
		[Parameter(Position = 0, Mandatory = $false, ValueFromPipeline = $true) ] $Directory = (Get-Location),
		[Parameter(Position = 1, Mandatory = $false, ValueFromPipeline = $true) ] [switch]$Recurse,
		[Parameter(Position = 2, Mandatory = $false, ValueFromPipeline = $false)] $OutputPath = (Get-Location),
		[Parameter(Position = 3, Mandatory = $false, ValueFromPipeline = $false)] $OutputFile = "default.csv",
		[Parameter(Position = 4, Mandatory = $false, ValueFromPipeline = $false)] [switch]$SubmitTicket
		
	)
	
	begin
	{
		
		# code to be executed once BEFORE the pipeline is processed goes here
		# Test if PSScriptAnalyzer module is loaded.  If not attempt to install.  If install fails write an error and break.
		Import-Module PSScriptAnalyzer
		
	} # end begin block
	
	process
	{
		<#
		gci $Directory | select -First 1
		$Recurse
		gci $OutputPath | Select-Object -First 1
		$OutputFile
		#>
		
		$p = "C:\psaoutput\c.csv"
		
		# code to be executed against every object in the pipeline goes here
		# Run analyzer and save output to output path
		# Scan CSVs to create consolidate report filtering on severity, rules, other?
		# Optionally submit a ticket with the consolidated report attached.  
		
		if ($Recurse)
		{
			Invoke-ScriptAnalyzer -Path $Directory -Recurse | export-csv -Path $p -NoTypeInformation -Force
		}
		else
		{
			Invoke-ScriptAnalyzer -Path $Directory | export-csv -Path $p -NoTypeInformation -Force
		}
		
		# add switch to put multiple severity levels in the report.  Info includes info and above, etc.
		Import-Csv $p | Where-Object { $_.Severity -match "Error|Warning" } | Select-Object Severity, Line, Column, ScriptName, RuleName, RuleSuppressionID, Message,ScriptPath | Export-Csv $OutputPath\$OutputFile -NoTypeInformation -Force
		# add option to overwrite existing csv or not
		
		# stub for the option to creat a support ticket
		
	} #end of the process block
	
	end
	{
		# code to be executed once AFTER the pipeline is processed goes here
		
		Remove-Variable Directory, Recurse, OutputPath, SubmitTicket
		[System.GC]::Collect()  # Memory cleanup
		
	} #end of the end block
	
} # end function

<# Comment History
YYYMMDD username- 3rd comment.
YYYMMDD username- 2nd comment.
YYYMMDD username- 1st comment.
#>