@echo off
echo GX Style %GMEXT_GX_STYLE_VERSION% - Packaging...
cd %YYprojectDir%
powershell -command "Expand-Archive -Path '%YYtargetFile%' -DestinationPath '%YYoutputFolder%\GX_Style_Output' -Force"

powershell -command ^
cd '%YYprojectDir%'; ^
if (Test-Path -Path '%YYEXTOPT_GX_Style_GXStyleOutputFolder%') { ^
copy-item '%YYEXTOPT_GX_Style_GXStyleOutputFolder%*' '%YYoutputFolder%\GX_Style_Output' -force -recurse -verbose ^
}
	
powershell -command "Compress-Archive  -Update -Path '%YYoutputFolder%\GX_Style_Output\*' -DestinationPath '%YYtargetFile%'"
rmdir "%YYoutputFolder%\GX_Style_Output\"