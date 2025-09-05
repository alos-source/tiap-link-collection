
# Prüfen, ob PowerShell als Administrator läuft
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Bitte PowerShell als Administrator ausführen!" -ForegroundColor Red
    exit
}

# Architektur anzeigen
if ([Environment]::Is64BitProcess) {
    Write-Host "PowerShell läuft als 64-Bit" -ForegroundColor Cyan
} else {
    Write-Host "PowerShell läuft als 32-Bit" -ForegroundColor Cyan
}

$regPath = "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager"
$regName = "PendingFileRenameOperations"

try {
    $value = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction Stop
    Remove-ItemProperty -Path $regPath -Name $regName
    Write-Host "Eintrag 'PendingFileRenameOperations' wurde erfolgreich gelöscht." -ForegroundColor Green
} catch {
    Write-Host "Eintrag 'PendingFileRenameOperations' ist nicht vorhanden oder konnte nicht gelesen werden." -ForegroundColor Yellow
    Write-Host "Vorhandene Einträge im Pfad '$regPath':" -ForegroundColor White
    try {
        $allValues = Get-ItemProperty -Path $regPath
        $allValues.PSObject.Properties | ForEach-Object {
            Write-Host "- $($_.Name)" -ForegroundColor Gray
        }
    } catch {
        Write-Host "Fehler beim Auslesen der Registry-Einträge." -ForegroundColor Red
    }
}
