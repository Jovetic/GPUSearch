$CardList = Get-Content $PSScriptRoot\CardList.csv
$pattern = 'FREE Delivery Available'

Do{
Foreach ($Card in $CardList){
$cards = Invoke-RestMethod -Uri $Card -TimeoutSec 10
Write-Host "Testing Card at "$card"" -ForegroundColor Yellow
If ($cards -match $pattern) 
{Start-Process $Card; Write-Host "Found a card on $(get-date) at"$Card"" -ForegroundColor Green }}
}While ($cards -match $pattern -eq $False) 
