;--------------------------------
;Include Modern UI

	!include "MUI2.nsh"
	!include "Library.nsh"
	!include "WordFunc.nsh"
	!include "x64.nsh"
	!include "FileFunc.nsh"  
	!include "LogicLib.nsh" 
	!include "WordFunc.nsh"

	!define LIBRARY_X64

;--------------------------------
; 编译选项

	; 设置覆盖标记
	SetOverwrite on
	; 设置压缩选项
	SetCompress auto
	; 选择压缩方式
	SetCompressor bzip2
	; 设置数据块优化
	SetDatablockOptimize on
	; 设置数据写入时间
	SetDateSave on

;--------------------------------
	!define PRODUCT_NAME "app" ;英文产品名字
	!define PRODUCT_NAME_CN "我的app" ;产品名字
	!define PRODUCT_NAME_DIR "app"
	!define PRODUCT_VERSION "1.0.0" ;版本号
	!define PRODUCT_EXE "app.exe" ;主程序(exe)
	!define BUILD_PATH "./OutApp/app-win32-x64" ;编译路径

;--------------------------------
; MUI 预定义常量
!define MUI_ABORTWARNING ;当用户要关闭安装程序时, 显示一个警告消息框
!define MUI_UNABORTWARNING ;当用户要关闭卸载程序时, 显示一个警告消息框
;!define MUI_ICON "ming.ico" ;安装程序图标
;!define MUI_UNICON "ming.ico" ;卸载程序图标
;!define MUI_FINISHPAGE_NOAUTOCLOSE ;不自动跳到完成页面, 允许用户检查安装记录
;!define MUI_UNFINISHPAGE_NOAUTOCLOSE ;不自动跳到完成页面, 允许用户检查卸载记录
;!define MUI_WELCOMEFINISHPAGE_BITMAP "welcome.bmp" ;用于欢迎页面和完成页面的位图(推荐尺寸: 164x314 象素).
;!define MUI_UNWELCOMEFINISHPAGE_BITMAP "welcome.bmp" ;用于卸载页面的位图(推荐尺寸: 164x314 象素).
;!define MUI_COMPONENTSPAGE_SMALLDESC ;较小的页面底部的描述区域
;!define MUI_COMPONENTSPAGE_TEXT_DESCRIPTION_INFO "鼠标移到组件上可查看相应说明" ;当没有选择区段时, 显示于描述框中的文本
;!define MUI_WELCOMEPAGE_TITLE "欢迎使用 ${PRODUCT_NAME} ${PRODUCT_VERSION}"
;!define MUI_WELCOMEPAGE_TEXT "该处定义欢迎界面说明信息\r\n\r\n   杠R杠N表示强制换行，不\r\n\r\n   加入则该行满后自动换行\r\n \r\n\r\n   $_CLICK"
;!define MUI_HEADERIMAGE ;标题图片，可放产品/公司的图片。
;!define MUI_HEADERIMAGE_LEFT ;标题图片所在位置，左/右。
;!define MUI_HEADERIMAGE_BITMAP "header.bmp"   ;标题图片，设置绝对路径，不定义则为安装包图标
;!define MUI_PAGE_HEADER_TEXT "许可页面最上面一行文本，原文为许可证协议"       ;未定义则为默认文本
;!define MUI_PAGE_HEADER_SUBTEXT "许可页面第二行文本，原文为在安装XX之前,请阅读协议"     ;未定义则为默认文本
;!define MUI_LICENSEPAGE_TEXT_TOP "阅读协议的其余部分，请按<PgDn>往下滚动页面。" #协议显示界面
;!define MUI_LICENSEPAGE_TEXT_BOTTOM "如果同意协议中的条款，请选择“接受协议中的条款”并$_CLICK"
;!define MUI_LICENSEPAGE_RADIOBUTTONS #协议条款接受选择，也有别的协议接受方式，看个人爱好。
;!define MUI_LICENSEPAGE_RADIOBUTTONS_TEXT_ACCEPT "接受协议中的条款"
;!define MUI_LICENSEPAGE_RADIOBUTTONS_TEXT_DECLINE "不接受协议中的条款"
;DirText "安装程序将安装 $(^NameDA) 在下列文件夹。$\r$\n$\r$\n要安装到不同文件夹，单击 [浏览(B)] 并选择其他的文件夹。$\r$\n$\r$\n$_CLICK" ;定义路径选择窗口第三行文本

;--------------------------------
;Pages
	; 欢迎页面
	!insertmacro MUI_PAGE_WELCOME
	; 许可协议页面
	;!define MUI_LICENSEPAGE_CHECKBOX
	;!insertmacro MUI_PAGE_LICENSE ".\License.txt"
	; 选择安装组件页面
	;!insertmacro MUI_PAGE_COMPONENTS
	;!define MUI_COMPONENTSPAGE_CHECKBITMAP   "1.bmp" ;(96x16,256色)
	; 安装目录选择页面
	!insertmacro MUI_PAGE_DIRECTORY

	; 安装过程页面
	!insertmacro MUI_PAGE_INSTFILES
	; 安装完成页面
	!define MUI_FINISHPAGE_RUN "$INSTDIR\${PRODUCT_EXE}"
	;!define MUI_FINISHPAGE_RUN_TEXT "运行 ${PRODUCT_EXE}"
	;!define MUI_FINISHPAGE_RUN_NOTCHECKED ;默认不选中 '运行程序' 复选框
	;!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\Readme.txt"
	;!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED ;默认不选中 '自述文件' 复选框
	;!define MUI_FINISHPAGE_LINK_LOCATION "${PRODUCT_WEB_URL}"
	;!define MUI_FINISHPAGE_LINK "${PRODUCT_WEB_NAME}"
	!insertmacro MUI_PAGE_FINISH

	; 卸载欢迎界面
	;!insertmacro MUI_UNPAGE_WELCOME 
	; 卸载确认页面
	!insertmacro MUI_UNPAGE_CONFIRM
	; 卸载过程页面
	!insertmacro MUI_UNPAGE_INSTFILES
	; 卸载完成界面
	!insertmacro MUI_UNPAGE_FINISH
  
;--------------------------------
;Languages
 
; 安装界面包含的语言设置
	!insertmacro MUI_LANGUAGE "SimpChinese"
;--------------------------------
;字符串
	!insertmacro WordReplace
;--------------------------------
;General

	; 标题栏显示文字
	Name "${PRODUCT_NAME_CN} ${PRODUCT_VERSION}"
	; 输出文件名
	OutFile "${PRODUCT_NAME}_setup.exe"

	; 程序安装路径
	InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"

	;Request application privileges for Windows Vista
	RequestExecutionLevel Admin
	;RequestExecutionLevel user

	;安装时显示信息
	ShowInstDetails SHOW

	;卸载时显示信息
	ShowUnInstDetails SHOW

	;修改“NullSoft Install System vX.XX”处文字
	BrandingText "${PRODUCT_CMP_NAME}"

	
Section "主程序" SecCore
	SectionIn RO

	SetAutoClose true

	SetOutPath "$INSTDIR"
	SetOverwrite on

	SetDetailsPrint textonly
	DetailPrint "正在复制文件..."
	SetDetailsPrint listonly

	SetOutPath $INSTDIR
	File /r "${BUILD_PATH}\*.*"

	SetShellVarContext all ;全部用户开始菜单
	SetShellVarContext current ;当前用户开始菜单

	SetDetailsPrint textonly
	DetailPrint "正在创建快捷方式..."
	SetDetailsPrint listonly
	; 创建开始菜单快捷方式
	CreateShortCut "$DESKTOP\${PRODUCT_NAME_CN}.lnk" "$INSTDIR\${PRODUCT_EXE}" "" "$INSTDIR\${PRODUCT_EXE}" 0
	;CreateShortCut "$QUICKLAUNCH\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_EXE}" "" "$INSTDIR\${PRODUCT_EXE}" 0
	CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME_DIR}"  
	;CreateShortCut "$SMPROGRAMS\${PRODUCT_DIR_NAME}\${PRODUCT_LNK_NAME}.lnk" "$INSTDIR\Bin\${PRODUCT_EXE}" "" "$INSTDIR\Bin\${PRODUCT_EXE}" 0
	CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME_DIR}\${PRODUCT_NAME_CN}.lnk" "$INSTDIR\${PRODUCT_EXE}" "" "$INSTDIR\${PRODUCT_EXE}" 0
	CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME_DIR}\卸载.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\uninstall.exe" 0

	SetDetailsPrint textonly
	DetailPrint "正在添加注册表信息..."
	SetDetailsPrint listonly
  
    ;软件安装目录
    ;WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\${PRODUCT_EXE}" "" "$INSTDIR\Bin\${PRODUCT_EXE}"
    ;WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\${PRODUCT_EXE}" "Path" "$INSTDIR\Bin"
  
	;写注册表，以便在“添加/删除程序”中显示
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayName" "${PRODUCT_NAME} ${PRODUCT_VERSION}" ;应用程序的名称
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
    WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayIcon" "$INSTDIR\Bin\${PRODUCT_EXE}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayVersion" "${PRODUCT_VERSION}"
	;WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\NBCShare" "Path" "$INSTDIR\Bin\"

    ;写卸载程序
	WriteUninstaller $INSTDIR\Uninstall.exe 

	SetDetailsPrint textonly
	DetailPrint "安装完成"
	SetDetailsPrint listonly
SectionEnd

;--------------------------------
;Descriptions

	;Language strings
	LangString DESC_SecCore ${LANG_SIMPCHINESE} "安装${PRODUCT_NAME_CN}主程序。"

	;Assign language strings to sections
	!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${SecCore} $(DESC_SecCore)
	!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section
var UninstallProgram
Var version

Section "Uninstall"
	SetAutoClose true

	SetDetailsPrint textonly
	DetailPrint "正在卸载$(^Name)..."
	SetDetailsPrint listonly

	ExecShell "taskbarunpin" "$DESKTOP\${PRODUCT_NAME_CN}.lnk"

	;ADD YOUR OWN FILES HERE...
	RMDir /r "$INSTDIR\*"

	SetShellVarContext current ;当前用户开始菜单
	Delete "$SMPROGRAMS\${PRODUCT_NAME_DIR}\${PRODUCT_NAME_CN}.lnk"   
	Delete "$SMPROGRAMS\${PRODUCT_NAME_DIR}\卸载.lnk"   
	RMDir "$SMPROGRAMS\${PRODUCT_NAME_DIR}"  
	Delete "$DESKTOP\${PRODUCT_NAME_CN}.lnk"   
	Delete "$QUICKLAUNCH\${PRODUCT_NAME_CN}.lnk"   

	SetShellVarContext all ;全部用户开始菜单
	Delete "$SMPROGRAMS\${PRODUCT_NAME_DIR}\${PRODUCT_NAME_CN}.lnk"   
	Delete "$SMPROGRAMS\${PRODUCT_NAME_DIR}\卸载.lnk"   
	RMDir "$SMPROGRAMS\${PRODUCT_NAME_DIR}"  
	Delete "$DESKTOP\${PRODUCT_NAME_CN}.lnk"
	Delete "$QUICKLAUNCH\${PRODUCT_NAME_CN}.lnk"   

	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\${PRODUCT_EXE}"
	;DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\App Paths\${PRODUCT_NAME}"
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
	
	SetDetailsPrint textonly
	DetailPrint "卸载完成"
	SetDetailsPrint listonly
SectionEnd

;开始安装时检查是否正在运行
Function .onInit

FunctionEnd

;开始卸载时检查：
Function un.onInit

FunctionEnd
