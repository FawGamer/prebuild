if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit}
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
Set-ExecutionPolicy RemoteSigned -Force

# VARIEAVEIS EXTERNOS
$DownloadOffice = 'https://mega.nz/file/JsIzlIaZ#y_73rzBceeD12ePfBxkLomWuZWVSSfAuVOSrsAIKBTQ'
$DownloadAtivador = 'https://mega.nz/file/484AVaLC#ccIQT0rY1ckw6-7i7s5kLgRakp-PPwKw9BDAK-Oo4sM'

# VARIAVEIS INTERNAS
$DATA = date

# Informaçoes da Maquina
$Host = Get-ComputerInfo -Property CsCaption
$WindowsInfo = Get-ComputerInfo -Property WindowsProductName
$WindowsVersion = Get-ComputerInfo -Property OsArchitecture
$WindowsLanguage = Get-ComputerInfo -Property OsLanguage
$Processador = Get-ComputerInfo -Property CsProcessors
#$Memoria = Get-ComputerInfo -Property 
$Graphics = wmic path win32_VideoController get name

Start-Transcript >> C:\$Host.$DATA.log
Write-Host "Inventario do Computador"
$Host
$WindowsInfo
$WindowsVersion
$WindowsLanguage
$Processador
#$Memoria
$Graphics

$RedeEXT = (Test-Connection 8.8.8.8 -Count 3 -Quiet)
if ($RedeEXT -eq "true"){
    Write-Host "Maquina conectada com a Internet" -ForegroundColor Green
    Write-Host "Efetuando Download do Conteudo Atualizado!"
#               Instalacao usando o Chocolaty como Repositorio
    Write-Host "Instalando Chocolaty Apps Manager"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Host "Iniciando Instalacao de Aplicativos"
# SET  ACCEPT PERMISSION IN CHOCO
    choco feature enable -n=allowGlobalConfirmation

    choco install anydesk.install -dvfy
    choco install silverlight -dvfy
    choco install dotnet4.7.2 -dvfy
    choco install vcredist2005 -dvfy
    choco install vcredist2008 -dvfy
    choco install vcredist2012 -dvfy
    choco install vcredist2013 -dvfy
    choco install vcredist2015 -dvfy
    choco install vcredist2017 -dvfy
    choco install vcredist140 -dvfy
    choco install googlechrome -dvfy 
    choco install adobereader -dvfy
    choco install 7zip.install -dvfy
    choco install winrar -dvfy
    choco install jre8 -dvfy
    choco install lightshot.install -dvfy
    choco install vlc -dvfy

    Start-Process microsoftedge $DownloadOffice
    Start-Process microsoftedge $DownloadAtivador

}else{
    Write-Host "Maquina sem acesso a internet!" -ForegroundColor Red
}
Stop-Transcript

