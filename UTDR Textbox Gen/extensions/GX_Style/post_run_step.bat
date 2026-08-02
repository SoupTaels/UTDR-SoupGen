@echo off
echo GX Style %GMEXT_GX_STYLE_VERSION%  - Injecting...

powershell -command ^
cd '%YYprojectDir%'; ^
if (Test-Path -Path '%YYEXTOPT_GX_Style_GXStyleOutputFolder%') { ^
copy-item '%YYEXTOPT_GX_Style_GXStyleOutputFolder%*' '%YYoutputFolder%\runner\' -force -recurse -verbose ^
}
