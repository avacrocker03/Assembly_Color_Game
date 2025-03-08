@ECHO OFF
rem File: asm_CSE3120.bat
rem Author: Marius Silaghi, 2023
SET IRVINE=C:\Users\avacr\Downloads\Irvine
SET FILEBASE=%~n1
echo Handling Source: %FILEBASE%
setlocal

rem You may use quotes for the whole parameter
set "PATH=C:\Program Files (x86);...;%PATH%"

rem Or you should use quotes only for special
rem characters. Avoid final undesired spaces...
set PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.41.34120\bin\HostX86\x86;C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x86;;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\tools;C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\ide;C:\Program Files (x86)\HTML Help Workshop;;C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin;C:\WINDOWS\Microsoft.NET\Framework\v4.0.30319\;;C:\Python38\Scripts\;C:\Python38\;C:\Program Files\Oculus\Support\oculus-runtime;C:\Program Files\Common Files\Oracle\Java\javapath;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\WINDOWS\System32\WindowsPowerShell\v1.0\;C:\WINDOWS\System32\OpenSSH\;C:\Program Files\Java\jdk-18.0.2\bin;C:\Program Files\PuTTY\;C:\Program Files\Git\cmd;C:\MinGW\bin;C:\Program Files\dotnet\;C:\Program Files\Go\bin;C:\ProgramData\chocolatey\bin;C:\Program Files\nodejs\;C:\Program Files\playit_gg\bin\;C:\Program Files\MATLAB\R2024a\bin;C:\Program Files (x86)\Windows Kits\10\Windows Performance Toolkit\;C:\Program Files\Docker\Docker\resources\bin;C:\Users\avacr\AppData\Local\Microsoft\WindowsApps;C:\Users\avacr\AppData\Local\GitHubDesktop\bin;C:\Users\avacr\Anaconda3\Scripts;C:\Users\avacr\Anaconda3;C:\Users\avacr\Anaconda3\Library\bin;C:\msys64\mingw64\bin;C:\Users\avacr\AppData\Local\Programs\Julia-1.9.2\bin;C:\Users\avacr\go\bin;C:\Users\avacr\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Visual Studio Code;C:\Users\avacr\AppData\Roaming\npm;C:\ProgramData\chocolatey\lib\cunit\lib;C:\ProgramData\chocolatey\lib\tinyxml2\lib;C:\ProgramData\chocolatey\lib\bullet\lib;C:\Program Files\OpenSSL-Win64\bin\;C:\opencv\x64\vc16\bin;C:\xmllint\bin;C:\Program Files\Graphviz\bin;C:\Program Files\CMake\bin;C:\dev\ros2_jazzy\ros2-windows\;C:\Users\avacr\AppData\Local\Programs\Microsoft VS Code\bin;C:\Program Files\Maven\apache-maven-3.9.9\bin;C:\Users\avacr\PMD\pmd-bin-7.8.0\bin;C:\Program Files\MySQL\MySQL Shell 8.0\bin\;C:\Users\avacr\AppData\Local\Programs\Microsoft VS Code\bin;C:\Program Files\apache-maven-3.9.9;;


set LIB=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.41.34120\lib\x86;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.41.34120\atlmfc\lib\x86;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\lib\x86;;C:\Program Files (x86)\Windows Kits\10\lib\10.0.22621.0\ucrt\x86;;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\lib;C:\Program Files (x86)\Windows Kits\10\lib\10.0.22621.0\um\x86;lib\um\x86;


set LIBPATH=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.41.34120\atlmfc\lib\x86;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.41.34120\lib\x86;


set INCLUDE=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.41.34120\include;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC\14.41.34120\atlmfc\include;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\include;;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\ucrt;;;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\VS\UnitTest\include;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\um;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\shared;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\winrt;C:\Program Files (x86)\Windows Kits\10\Include\10.0.22621.0\cppwinrt;Include\um;

rem EXTERNAL_INCLUDE=C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.29.30133\include;;C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Tools\MSVC\14.29.30133\atlmfc\include;;C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\VS\include;;C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\ucrt;;;C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\VS\UnitTest\include;C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\um;C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\shared;C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\winrt;C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\cppwinrt;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.8\Include\um;


rem ml.exe /c /nologo /Sg /Zi /Fo"%FILEBASE%.obj"\
rem /Fl"%FILEBASE%.lst" /I "%IRVINE%" /W3 \
rem /errorReport:prompt /Ta%FILEBASE%.asm


FOR %%F IN (%*) DO (
echo Handling %%~nF
ml.exe /c /nologo /Sg /Zi /Fo"%%~nF.obj" /Fl"%%~nF.lst" /I "%IRVINE%" /W3 /errorReport:prompt /Ta%%~nF.asm
)

link.exe /ERRORREPORT:PROMPT /OUT:"%FILEBASE%.exe" /NOLOGO /LIBPATH:%IRVINE% user32.lib irvine32.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /MANIFEST /MANIFESTUAC:"level='asInvoker' uiAccess='false'" /manifest:embed /DEBUG /SUBSYSTEM:CONSOLE /TLBID:1 /DYNAMICBASE:NO /MACHINE:X86 /SAFESEH:NO %FILEBASE%.obj

endlocal

