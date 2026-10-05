# Installe Claude Code et branche Claude à Roblox Studio et Blender (Windows, PowerShell).
# Lancer : clic droit sur le fichier > "Exécuter avec PowerShell"
# ou dans PowerShell : powershell -ExecutionPolicy Bypass -File .\install.ps1
#
# Ce que fait le script :
#   1. installe Claude Code (installeur officiel claude.ai)
#   2. installe uv (installeur officiel astral.sh), requis par le connecteur Blender
#   3. enregistre le connecteur Roblox Studio (intégré à Studio)
#   4. enregistre le connecteur Blender (ahujasid/blender-mcp)
#   5. télécharge l'addon Blender dans le dossier Téléchargements
# Il ne modifie ni Studio ni Blender : les deux dernières étapes sont à faire à la main (voir la fin).

$ErrorActionPreference = 'Stop'
function Step($t) { Write-Host "`n==> $t" -ForegroundColor Cyan }

Write-Host "Ce script va installer Claude Code et configurer 2 connecteurs (Roblox Studio, Blender)."
$ok = Read-Host "Continuer ? (o/n)"
if ($ok -notin @('o','O','oui','y','Y')) { Write-Host "Annulé."; exit }

$claudeBin = Join-Path $env:USERPROFILE '.local\bin'
$uvBin     = Join-Path $env:USERPROFILE '.local\bin'
$env:Path  = "$claudeBin;$env:Path"

Step "1/5 Claude Code"
if (Get-Command claude -ErrorAction SilentlyContinue) {
  Write-Host "Déjà installé."
} else {
  Invoke-RestMethod https://claude.ai/install.ps1 | Invoke-Expression
  $env:Path = "$claudeBin;$env:Path"
}
if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
  Write-Host "Claude Code est installé mais introuvable dans ce terminal." -ForegroundColor Yellow
  Write-Host "Fermez cette fenêtre, ouvrez-en une nouvelle et relancez le script."
  Read-Host "Entrée pour quitter"; exit 1
}

Step "2/5 uv (pour Blender)"
if (Get-Command uvx -ErrorAction SilentlyContinue) {
  Write-Host "Déjà installé."
} else {
  Invoke-RestMethod https://astral.sh/uv/install.ps1 | Invoke-Expression
  $env:Path = "$uvBin;$env:Path"
}

Step "3/5 Connecteur Roblox Studio"
try { claude mcp add roblox-studio --transport http http://localhost:3004/mcp }
catch { Write-Host "Peut-être déjà ajouté : $($_.Exception.Message)" -ForegroundColor Yellow }

Step "4/5 Connecteur Blender"
try { claude mcp add blender uvx blender-mcp }
catch { Write-Host "Peut-être déjà ajouté : $($_.Exception.Message)" -ForegroundColor Yellow }

Step "5/5 Addon Blender"
$dest = Join-Path $env:USERPROFILE 'Downloads\blender_mcp_addon.py'
try {
  Invoke-WebRequest https://raw.githubusercontent.com/ahujasid/blender-mcp/main/addon.py -OutFile $dest
  Write-Host "Téléchargé : $dest"
} catch {
  Write-Host "Téléchargement impossible. Prenez addon.py à la main sur https://github.com/ahujasid/blender-mcp" -ForegroundColor Yellow
}

Write-Host "`n==================== À FAIRE À LA MAIN ====================" -ForegroundColor Green
Write-Host "A) Roblox Studio : File > Studio Settings > Beta Features > activer 'MCP Server'."
Write-Host "B) Blender : Edit > Preferences > Add-ons > Install... > choisir $dest, puis cocher l'addon."
Write-Host "   Dans Blender, ouvrez le panneau latéral (touche N) > onglet BlenderMCP > 'Connect'."
Write-Host "C) Ouvrez Studio (avec votre jeu) et Blender, puis dans un terminal tapez : claude"
Write-Host "D) Tapez /mcp pour vérifier que 'roblox-studio' et 'blender' sont connectés."
Write-Host "==========================================================="
Read-Host "`nEntrée pour fermer"
