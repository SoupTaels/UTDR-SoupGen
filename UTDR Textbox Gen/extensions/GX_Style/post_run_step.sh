#!/usr/bin/env bash
cd "$YYprojectDir"
if [ -d "$YYEXTOPT_GX_Style_GXStyleOutputFolder" ]; then
  cp -a "$YYEXTOPT_GX_Style_GXStyleOutputFolder." "$YYoutputFolder/runner/"
fi