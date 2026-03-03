function Invoke-Spinner {
    param(
        [Parameter(Mandatory=$true)]
        [scriptblock]$Command,
        [Parameter(Mandatory=$false)]
        [string]$Message = "Processing"
    )

    $spinner = @('|','/','-','\')
    $i = 0

    $job = Start-Job -ScriptBlock $Command

    while ((Get-Job -Id $job.Id).State -eq 'Running') {
        Write-Host -NoNewline "`r$($spinner[$i % $spinner.Length]) $Message..."
        Start-Sleep -Milliseconds 100
        $i++
    }

    Receive-Job -Id $job.Id -Wait -AutoRemoveJob
    Write-Host "`rDone!                   "
}
