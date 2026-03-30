; -------------------------- Core ASCII Encoding Configuration --------------------------
!pragma encoding "ASCII"
!define __ASCII__ 1
Unicode False

; Import Required Libraries
!include "MUI2.nsh"
!include "FileFunc.nsh"
!include "LogicLib.nsh"
!include "x64.nsh"


; Product Information (ASCII Only)
!define PRODUCT_NAME "Electron Demo"
!define PRODUCT_FULL_NAME "${PRODUCT_NAME} Application"
!define PRODUCT_EXEC_APP "electron-demo.exe"
!define PRODUCT_VERSION "1.0.0"
!define PRODUCT_PUBLISHER "electron"
!define PRODUCT_WEB_SITE "https://electronjs.org"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"


OutFile "${PRODUCT_NAME}_${PRODUCT_VERSION}_Setup.exe"


; -------------------------- Fix: Default Install Directory (Never Empty) --------------------------
!define DEFAULT_INSTALL_DIR "$PROGRAMFILES\${PRODUCT_NAME}"
; Force default path (override empty registry value)
InstallDir "${DEFAULT_INSTALL_DIR}"
; Only read registry if path exists (avoid empty value)
InstallDirRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "InstallDir"

; -------------------------- Fix: MUI Finish Page Configuration (No Blank Page) --------------------------
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\orange-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\orange-uninstall.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Header\orange.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\orange.bmp"

!define MUI_FINISHPAGE_RUN "$INSTDIR\${PRODUCT_EXEC_APP}"
!define MUI_FINISHPAGE_CLOSE
!define MUI_FINISHPAGE_BUTTON "Close"
!define MUI_FINISHPAGE_NOREBOOTSUPPORT

!define MUI_DIRECTORYPAGE_VERIFYONLEAVE
!define MUI_DIRECTORYPAGE_NOREGISTRY

!define MUI_WINDOWTITLE "${PRODUCT_FULL_NAME} - Installer"
!define MUI_UNWINDOWTITLE "${PRODUCT_FULL_NAME} - Uninstaller"
Caption "${PRODUCT_FULL_NAME} - Installer"
UninstallCaption "${PRODUCT_FULL_NAME} - Uninstaller"

!define MUI_WELCOMEPAGE_TITLE "${PRODUCT_FULL_NAME}"
!define MUI_WELCOMEPAGE_TEXT "Welcome to the ${PRODUCT_FULL_NAME} Installer$\n$\nVersion: ${PRODUCT_VERSION}$\nPublisher: ${PRODUCT_PUBLISHER}$\n$\nClick Next to continue with the installation."
!define MUI_DIRECTORYPAGE_TITLE "Choose Installation Directory"
!define MUI_DIRECTORYPAGE_TEXT "Select the folder where ${PRODUCT_FULL_NAME} will be installed.$\nClick Next to continue."
!define MUI_INSTFILESPAGE_TITLE "Installing ${PRODUCT_FULL_NAME}"
!define MUI_INSTFILESPAGE_TEXT_TOP "Please wait while ${PRODUCT_FULL_NAME} is being installed."
!define MUI_INSTFILESPAGE_TEXT_BOTTOM "This may take a few moments."
!define MUI_FINISHPAGE_TITLE "Installation Complete"
!define MUI_FINISHPAGE_TEXT_TOP "${PRODUCT_FULL_NAME} has been installed successfully!$\nInstallation Path: $INSTDIR"
!define MUI_FINISHPAGE_TEXT_BOTTOM "Click Close to exit the installer."


!define MUI_UNTEXT_UNINSTALLING_TITLE "Confirm Uninstallation"
!define MUI_UNTEXT_UNINSTALLING_SUBTITLE "Are you sure you want to remove ${PRODUCT_FULL_NAME} from your computer?$\n$\nAll installed files, drivers and background services will be deleted.$\nThis action cannot be undone."
!define MUI_UNTEXT_FINISH_TITLE "Uninstalling ${PRODUCT_FULL_NAME}"
!define MUI_UNTEXT_FINISH_SUBTITLE "Please wait while ${PRODUCT_FULL_NAME} is being uninstalled."


; Language (ASCII-Only English)
;!insertmacro MUI_LANGUAGE "English"

; -------------------------- Installation Permissions --------------------------
RequestExecutionLevel admin
;XPStyle on
;ShowInstDetails show
;ShowUnInstDetails show

; -------------------------- Page Definition (No Component Page) --------------------------
;!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
;!insertmacro MUI_PAGE_FINISH

; Uninstall Pages (Fix: Add Uninstall Finish Page Configuration)
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
;!define MUI_UNFINISHPAGE_TEXT "Uninstallation completed successfully.$\nAll files and processes have been cleaned up."
;!insertmacro MUI_UNPAGE_FINISH

; -------------------------- Pre-Install Check (Uninstall Existing Version) --------------------------
Function .onInit
  ${If} ${RunningX64}
    ${DisableX64FSRedirection}
  ${EndIf}
  
  ReadRegStr $0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString"
  ${If} $0 != ""
    MessageBox MB_YESNO|MB_ICONQUESTION "${PRODUCT_NAME} is already installed.$\nDo you want to uninstall the existing version first?" IDYES UninstallExisting
    ${EndIf}
  Goto DoneInit

  UninstallExisting:
    nsExec::ExecToLog '"$0"'
    Sleep 2000
    DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  
  DoneInit:
  ${If} ${RunningX64}
    ${EnableX64FSRedirection}
  ${EndIf}
FunctionEnd

; -------------------------- Installation Process --------------------------
Section "MainProgram" SEC01
  ${If} ${RunningX64}
    ${DisableX64FSRedirection}
  ${EndIf}
  
  IfFileExists "$INSTDIR" +2
  CreateDirectory "$INSTDIR"
  SetOutPath "$INSTDIR"
  
  ; Copy root files
  File /r "${PRODUCT_EXEC_APP}"
  File /r "*.dll"
  File /r "*.pak"
  File /r "*.dat"
  File /r "*.json"
  ;File /r "*.yml"

  File /r "*.bin"

  ; Copy subdirectories (preserve structure)

  CreateDirectory "$INSTDIR\locales"
  SetOutPath "$INSTDIR\locales"
  File /r "locales\*.*"

  CreateDirectory "$INSTDIR\resources"
  SetOutPath "$INSTDIR\resources"
  File /r "resources\*.*"

  ; Install drivers
  SetOutPath "$INSTDIR"
  nsExec::ExecToStack 'echo install SEC01'

  ; Configure auto-start
  StrCpy $0 "$INSTDIR\${PRODUCT_EXEC_APP}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Run" "${PRODUCT_NAME}" $0
  
  ; Start background service
  ;nsExec::ExecToLog 'start "" /B "$INSTDIR\resources\service.exe" --background'

  ; Write uninstall info
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "${PRODUCT_NAME}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "InstallDir" "$INSTDIR"
  
  ${If} ${RunningX64}
    ${EnableX64FSRedirection}
  ${EndIf}
SectionEnd

; -------------------------- Post-Installation --------------------------
Section -Post
  WriteUninstaller "$INSTDIR\uninstall.exe"
  CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_EXEC_APP}" "" "$INSTDIR\resources\icon.ico" 0
  ;CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  ;CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_EXEC_APP}" "" "$INSTDIR\resources\icon.ico" 0
  ;CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\resources\icon.ico" 0
SectionEnd

; -------------------------- Uninstallation Process --------------------------
Section Uninstall
  ${If} ${RunningX64}
    ${DisableX64FSRedirection}
  ${EndIf}
  
  ; Terminate all processes
  nsExec::ExecToLog 'taskkill /F /IM "${PRODUCT_EXEC_APP}"'
  
  ; Remove auto-start
  DeleteRegValue HKLM "Software\Microsoft\Windows\CurrentVersion\Run" "${PRODUCT_NAME}"

  ; Uninstall drivers
  nsExec::ExecToLog '"$SYSDIR\pnputil.exe" /delete-driver "$INSTDIR\apo\flow_apo.inf" /uninstall'

  ; Clean up files
  RMDir /r "$INSTDIR\resources"
  RMDir /r "$INSTDIR\locales"
  Delete "$INSTDIR\${PRODUCT_EXEC_APP}"
  Delete "$INSTDIR\*.dll"
  Delete "$INSTDIR\*.pak"
  Delete "$INSTDIR\*.dat"
  Delete "$INSTDIR\*.json"
  ;Delete "$INSTDIR\*.yml"
  Delete "$INSTDIR\*.bin"
  Delete "$INSTDIR\uninstall.exe"
  RMDir "$INSTDIR"

  ; Remove shortcuts
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  ;RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"

  ; Clean registry
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Software\Microsoft\Windows\CurrentVersion\Uninstall"
  
  ${If} ${RunningX64}
    ${EnableX64FSRedirection}
  ${EndIf}
SectionEnd

; -------------------------- Fix: Simple Success Messages (No Blank Page) --------------------------
Function .onInstSuccess
  ; Show success message and auto-close (compatible with all NSIS versions)
  MessageBox MB_ICONINFORMATION|MB_OK "${PRODUCT_NAME} installed successfully!$\nInstallation Path: $INSTDIR$\nClick OK to exit."
  Quit ; Force exit after message (critical fix for blank page)
FunctionEnd

Function .onUnInstSuccess
  ; Show uninstall success message and auto-close
  MessageBox MB_ICONINFORMATION|MB_OK "${PRODUCT_NAME} uninstalled successfully!$\nAll files and processes cleaned up.$\nClick OK to exit."
  Quit ; Force exit after message
FunctionEnd