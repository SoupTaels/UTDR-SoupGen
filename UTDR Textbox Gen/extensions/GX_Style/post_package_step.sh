#!/usr/bin/env bash
cd "$YYprojectDir"
if [ -d "$YYEXTOPT_GX_Style_GXStyleOutputFolder" ]; then
	cd "$YYEXTOPT_GX_Style_GXStyleOutputFolder"
	zip -ur "$YYtargetFile" "./"
fi
