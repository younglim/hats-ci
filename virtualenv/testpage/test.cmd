pushd %~dp0
REM @echo off

rmdir %TEMP%\testpage /s /q
mkdir %TEMP%\testpage
xcopy "%CD%" "%TEMP%\testpage" /E
cd %TEMP%\testpage

set CHROME_WIN_X86="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
set CHROME_WIN="C:\Program Files\Google\Chrome\Application\Chrome.exe"
set IE_WIN_X86="C:\Program Files\Internet Explorer\iexplore.exe"
set IE_WIN="C:\Program Files (x86)\Internet Explorer\iexplore.exe"
set FF_WIN_X86="C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
set FF_WIN="C:\Program Files\Mozilla Firefox\firefox.exe"
set EDGE_WIN="C:\Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe"

set edgepath=NUL
IF EXIST %EDGE_WIN% (
  set edgepath=%EDGE_WIN%
)

set chromepath=NUL
IF EXIST %CHROME_WIN_X86% (
  set chromepath=%CHROME_WIN_X86%
)
IF EXIST %CHROME_WIN% (
  set chromepath=%CHROME_WIN%
)

set iepath=NUL
IF EXIST %IE_WIN_X86% (
  set iepath=%IE_WIN_X86%
)
IF EXIST %IE_WIN% (
  set iepath=%IE_WIN%
)

set ffpath=NUL
IF EXIST %FF_WIN_X86% (
  set ffpath=%FF_WIN_X86%
)
IF EXIST %FF_WIN% (
  set ffpath=%FF_WIN%
)

IF %chromepath%==NUL (
  echo no chromepath
  set chrome_exist=False
) ELSE (
  set chrome_exist=True
)

IF %iepath%==NUL (
  echo no ie
  set ie_exist=False
) ELSE (
  set ie_exist=True
)

IF %ffpath%==NUL (
  echo no ff
  set ff_exist=False
) ELSE (
  set ff_exist=True
)

IF %edgepath%==NUL (
  echo no edge
  set edge_exist=False
) ELSE (
  set edge_exist=True
)

call python -m robot -x report.xml --variable CHROME_EXISTS:%chrome_exist% --variable IE_EXISTS:%ie_exist% --variable FF_EXISTS:%ff_exist% --variable EDGE_EXISTS:%edge_exist% --name hats test.robot

if [%1]==[] goto :blank

IF NOT %chromepath%==NUL (
echo chromepath not null
  start %chromepath% %TEMP%/testpage/report.html
) ELSE (
  echo chromepath null
  IF NOT %iepath%==NUL (
    echo iepath not null
    start %iepath% %TEMP%/testpage/report.html
  ) ELSE (
    echo iepath null
    IF NOT %ffpath%==NUL (
      echo ffpath not null
      start %ffpath% %TEMP%/testpage/report.html
    )
  )

)

:blank
