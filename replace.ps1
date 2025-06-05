# �berpr�fen, ob eine Datei per Drag & Drop auf das Skript gezogen wurde 

$timestampPlaceholder = "%%CURRENT_TIMESTAMP%%"
$timestampFormat = "yyyy-MM-dd"      # Format für den Zeitstempel

if ($args.Count -gt 0 -and (Test-Path -Path $args[0] -PathType Leaf)) { 

    # Dateipfad der gezogenen Datei 

    $eingabeDatei = $args[0] 

 

    # Text, der ersetzt werden soll, und der neue Text 

    $zuErsetzen = "%SIOS%" 

    $ersatzText = "https://support.industry.siemens.com/cs/document/" 

 

    # Ausgabedatei (neuer Dateiname, basierend auf der Eingabedatei) 

    $ausgabeDatei = [System.IO.Path]::ChangeExtension($eingabeDatei, ".links.md") 
    $ausgabeDateiHTML = [System.IO.Path]::ChangeExtension($eingabeDatei, ".links.html") 
 

    # Einlesen der Eingabedatei 

    $inhalt = Get-Content -Path $eingabeDatei -Raw 

 

    # Suchen und Ersetzen des Textes 

    $neuerInhalt = $inhalt -replace $zuErsetzen, $ersatzText 

 

    # Speichern des neuen Inhalts in der Ausgabedatei 

    $neuerInhalt | Set-Content -Path $ausgabeDatei 


    # --- Zeitstempel in Quelldatei einfügen ---
    try {
        Write-Verbose "Überprüfe und ersetze Zeitstempel-Platzhalter '$timestampPlaceholder' in '$ausgabeDatei'."
        $fileContent = Get-Content -LiteralPath $ausgabeDatei -Raw -ErrorAction Stop
        
        if ($fileContent -match [regex]::Escape($timestampPlaceholder)) {
            $currentTimestamp = Get-Date -Format $timestampFormat
            $fileContent = $fileContent -replace [regex]::Escape($timestampPlaceholder), $currentTimestamp
            Set-Content -LiteralPath $ausgabeDatei -Value $fileContent -NoNewline -ErrorAction Stop
            Write-Verbose "Zeitstempel '$currentTimestamp' wurde in '$ausgabeDatei' eingefügt."
        }
        else {
            Write-Verbose "Platzhalter '$timestampPlaceholder' nicht in '$ausgabeDatei' gefunden. Kein Zeitstempel eingefügt."
        }
    }
    catch {
        Write-Warning "Fehler beim Einfügen des Zeitstempels in '$ausgabeDatei': $($_.Exception.Message)"
    }


    #pandoc -o $ausgabeDateiHTML $ausgabeDatei --css=pandoc.css --standalone
    pandoc -o $ausgabeDateiHTML $ausgabeDatei --standalone
} 

else { 

    Write-Host "Bitte ziehen Sie eine Datei auf das Skript, um sie zu bearbeiten." 

} 