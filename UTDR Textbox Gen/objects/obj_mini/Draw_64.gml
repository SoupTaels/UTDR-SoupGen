///@desc 
//if ( live_call() ) { return live_result; } 
draw();

if ( SYSTEMUI.dial_text_page != page || SYSTEMUI.ui_paused || SYSTEMUI.record.enabled || SYSTEMUI.screenshot || SYSTEMUI.ui_tab > 0 || !SYSTEMUI.bord_visible ) { exit; }
var ww_ = sprite_get_width(face), hh_ = sprite_get_height(face), xx_ = x - ( ww_/ 2 ), yy_ = y - ( hh_/ 2 );
var textx = ( xx_ + ww_ ) + 10, texty = yy_ + hh_, bbox = scrib.get_bbox(textx, texty);
//draw_rectangle(xx_, yy_, textx + real(bbox.width), texty + ( real(bbox.height)/ 2 ), true);
var linebox = CleanRectangle(round(xx_ - 2), round(yy_ - 2), round(textx + real(bbox.width) + 2), round(texty + ( real(bbox.height)/ 2 ) + 2))
.Blend(c_white, 0).Border(2, ( near || drag ) ? c_white : c_gray, 1).Draw();

if ( !destroying ) { exit; }
var finalx = xx_ - 2, prog_ = Range(soupy_alarm_get("destroy", "timer"), 0, 60, finalx, ( textx + real(bbox.width) + 2 ));
var linebox = CleanRectangle(round(finalx), round(yy_ - 2), round(prog_), round(texty + ( real(bbox.height)/ 2 ) + 2))
.Blend(c_red, 0.5).Draw();