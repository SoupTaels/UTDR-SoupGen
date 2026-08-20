// Generated at 2026-07-23 18:01:44 (597ms) for v2.3+
/// @lint nullToAny true
// Feather disable all
globalvar __lnc__std_haxe_type_markerValue;if(live_enabled)__lnc__std_haxe_type_markerValue=[];
globalvar mt___lnc__std_haxe_class;
globalvar mt___lnc__std_haxe_Exception;
if(live_enabled)then(function(){
mt___lnc__std_haxe_class=new __lnc__std_haxe_class(-1,"__lnc__std_haxe_class");
mt___lnc__std_haxe_Exception=new __lnc__std_haxe_class(-1,"__lnc__std_haxe_Exception");
})();

if(live_enabled)
function __lnc__std_haxe_class(l_id,l_name)constructor{
	static superClass=undefined; /// @is {haxe_class<any>}
	static marker=undefined; /// @is {any}
	static index=undefined; /// @is {int}
	static name=undefined; /// @is {string}
	self.superClass=undefined;
	self.marker=__lnc__std_haxe_type_markerValue;
	self.index=l_id;
	self.name=l_name;
	static __class__="class";
}

if(live_enabled)
function __lnc__std_gml_NativeTypeHelper_isNumber(l_v){
	return (is_real(l_v)||is_bool(l_v)||is_int32(l_v))||is_int64(l_v);
}

if(live_enabled)
function __lnc__std_haxe_Exception(l_message,l_previous,l_native)constructor{
	static native=undefined; /// @is {any}
	if(false)show_debug_message(argument[2]);
	self.native=(l_native!=undefined?l_native:self);
	static __class__=mt___lnc__std_haxe_Exception;
}

if(live_enabled)
function __lnc__std_haxe_Exception_caught(l_value){
	if(is_struct(l_value)&&variable_struct_get(l_value,"__exception__")==true)return l_value;
	var l_e={
		value:l_value,
		message:string(l_value),
		longMessage:"",
		script:"",
		stacktrace:debug_get_callstack(),
		__exception__:true
	}
	l_e.native=l_e;
	return l_e;
}

if(live_enabled)
function live_preinit_init_funcs(){
	live_function_add("gml_pragma(setting, ...)",function(){});
	var l_fm=ds_map_create();
	var l_fl=ds_list_create();
	var l_isJS=os_browser!=browser_not_a_browser;
	var l_func;
	if(!l_isJS)for(var l_i=0;l_i<10000;l_i++){
		var l_scr=l_i;
		var l_name=script_get_name(l_scr);
		if(string_ord_at(l_name,1)==60)break;
		if(string_length(l_name)>=64)l_name=string_copy(l_name,1,64);
		var l_fc=string_ord_at(l_name,1);
		if(l_fc==60)break;
		if(!(l_fc==95||l_fc>=97&&l_fc<=122||l_fc>=65&&l_fc<=90))continue;
		l_func=method(undefined,l_scr);
		var l_m={name:l_name,func:l_func,used:false}
		l_fm[?l_name]=l_m;
		ds_list_add(l_fl,l_m);
	}
	var l_jsDummy=(l_isJS?function(){}:undefined);
	var l_jsIndex=0;
	var l_lines=file_text_open_from_string("nameof=(name)\n"
		+ "is_real=(val)#:bool\n"
		+ "is_numeric=(val):\n"
		+ "is_string=(val)#:bool\n"
		+ "is_array=(val)#:bool\n"
		+ "is_undefined=(val)#:bool\n"
		+ "is_int32=(val)#:bool\n"
		+ "is_int64=(val)#:bool\n"
		+ "is_ptr=(val)#:bool\n"
		+ "is_bool=(val)#:bool\n"
		+ "is_nan=(val):\n"
		+ "is_infinity=(val):\n"
		+ "is_struct=(val):\n"
		+ "is_method=(val):\n"
		+ "is_instanceof=(struct, constructor_name):\n"
		+ "is_callable=(val):\n"
		+ "is_handle=(val):\n"
		+ "static_get=(struct_or_func_name):\n"
		+ "static_set=(struct, struct)\n"
		+ "typeof=(val)#:bool\n"
		+ "instanceof=(any)#:string\n"
		+ "exception_unhandled_handler=(user_handler)\n"
		+ "variable_global_exists=(name):\n"
		+ "variable_global_get=(name):\n"
		+ "variable_global_set=(name,val)\n"
		+ "variable_instance_exists=(id,name):\n"
		+ "variable_instance_get=(id,name):\n"
		+ "variable_instance_set=(id,name,val)\n"
		+ "variable_instance_get_names=(id):\n"
		+ "variable_instance_names_count=(:any):int\n"
		+ "variable_struct_exists=(struct,name):\n"
		+ "variable_struct_get=(struct,name):\n"
		+ "variable_struct_set=(struct,name,val)\n"
		+ "variable_struct_get_names=(struct):\n"
		+ "variable_struct_names_count=(struct):int\n"
		+ "variable_struct_remove=(struct,name)\n"
		+ "variable_get_hash=(name):\n"
		+ "variable_clone=(var,[depth])\n"
		+ "struct_exists=(struct,name):\n"
		+ "struct_exists_from_hash=(struct,hash):\n"
		+ "struct_get=(struct,name):\n"
		+ "struct_set=(struct,name,val)\n"
		+ "struct_get_names=(struct):\n"
		+ "struct_names_count=(struct)\n"
		+ "struct_remove=(struct,name) \n"
		+ "struct_remove_from_hash=(struct,hash) \n"
		+ "struct_foreach=(struct,func)\n"
		+ "struct_get_from_hash=(struct,hash):\n"
		+ "struct_set_from_hash=(struct,hash,val)\n"
		+ "array_length=(value):int\n"
		+ "array_equals=(one, two):\n"
		+ "array_create=(size:number, ?value:any):array\n"
		+ "array_copy=(dest,dest_index,src,src_index,length)\n"
		+ "array_resize=(variable,newsize)\n"
		+ "array_get=(variable,index):\n"
		+ "array_set=(variable,index,val)\n"
		+ "array_push=(array,val,...)\n"
		+ "array_pop=(array)\n"
		+ "array_shift=(array)\n"
		+ "array_insert=(array,index,val,...)\n"
		+ "array_delete=(array,index,number)\n"
		+ "array_sort=(array,sortType_or_function)\n"
		+ "array_shuffle=(array,[offset],[length])\n"
		+ "array_shuffle_ext=(array,[offset],[length])\n"
		+ "array_get_index=(array,value,[offset],[length]):\n"
		+ "array_contains=(array,value,[offset],[length])\n"
		+ "array_contains_ext=(array,values,[matchAll],[offset],[length])\n"
		+ "array_first=(array)\n"
		+ "array_last=(array)\n"
		+ "array_create_ext=(size,function):\n"
		+ "array_find_index=(array,function,[offset],[length]):\n"
		+ "array_any=(array,function,[offset],[length])\n"
		+ "array_all=(array,function,[offset],[length])\n"
		+ "array_foreach=(array,function,[offset],[length])\n"
		+ "array_reduce=(array,function,[init_value],[offset],[length])\n"
		+ "array_filter=(array,function,[offset],[length])\n"
		+ "array_filter_ext=(array,function,[offset],[length])\n"
		+ "array_map=(array,function,[offset],[length])\n"
		+ "array_map_ext=(array,function,[offset],[length])\n"
		+ "array_copy_while=(array,function,[offset],[length])\n"
		+ "array_unique=(array,[offset],[length])\n"
		+ "array_unique_ext=(array,[offset],[length])\n"
		+ "array_reverse=(array,[offset],[length])\n"
		+ "array_reverse_ext=(array,[offset],[length])\n"
		+ "array_concat=(...)\n"
		+ "array_union=(...)\n"
		+ "array_intersection=(...)\n"
		+ "random=(x:number):number\n"
		+ "random_range=(:number,:number):number\n"
		+ "irandom=(x:number):int\n"
		+ "irandom_range=(:number,:number):int\n"
		+ "random_set_seed=(seed, [fixRangeBug])\n"
		+ "random_get_seed=():\n"
		+ "randomize=():number\n"
		+ "randomise=():number\n"
		+ "abs=(x:number)#:number\n"
		+ "round=(x:number)#:int\n"
		+ "floor=(x:number)#:int\n"
		+ "ceil=(x:number)#:int\n"
		+ "sign=(x:number)#:int\n"
		+ "frac=(x:number)#:number\n"
		+ "sqrt=(x:number)#:number\n"
		+ "sqr=(x:number)#:number\n"
		+ "exp=(x:number)#:number\n"
		+ "ln=(x:number)#:number\n"
		+ "log2=(x:number)#:number\n"
		+ "log10=(x:number)#:number\n"
		+ "sin=(radian_angle:number)#:number\n"
		+ "cos=(radian_angle:number)#:number\n"
		+ "tan=(radian_angle:number)#:number\n"
		+ "arcsin=(x:number)#:number\n"
		+ "arccos=(x:number)#:number\n"
		+ "arctan=(x:number)#:number\n"
		+ "arctan2=(y:number, x:number)#:number\n"
		+ "dsin=(degree_angle:number)#:number\n"
		+ "dcos=(degree_angle:number)#:number\n"
		+ "dtan=(degree_angle:number)#:number\n"
		+ "darcsin=(x:number)#:number\n"
		+ "darccos=(x:number)#:number\n"
		+ "darctan=(x:number)#:number\n"
		+ "darctan2=(y:number, x:number)#:number\n"
		+ "degtorad=(x:number)#:number\n"
		+ "radtodeg=(x:number)#:number\n"
		+ "power=(x:number, n:number)#:number\n"
		+ "logn=(n:number, x:number)#:number\n"
		+ "mean=(...:number)#:number\n"
		+ "median=(...:any)#:any\n"
		+ "clamp=(val:number, min:number, max:number)#:number\n"
		+ "lerp=(val1:number, val2:number, amount:number)#:number\n"
		+ "dot_product=(x1:number, y1:number, x2:number, y2:number)#:\n"
		+ "dot_product_3d=(x1:number, y1:number, z1:number, x2:number, y2:number, z2:number)#:\n"
		+ "dot_product_normalised=(x1:number, y1:number, x2:number, y2:number)£#:\n"
		+ "dot_product_3d_normalised=(x1:number, y1:number, z1:number, x2:number, y2:number, z2:number)£#:\n"
		+ "dot_product_normalized=(x1:number, y1:number, x2:number, y2:number)$#:\n"
		+ "dot_product_3d_normalized=(x1:number, y1:number, z1:number, x2:number, y2:number, z2:number)$#:\n"
		+ "math_set_epsilon=(eps):\n"
		+ "math_get_epsilon=():\n"
		+ "angle_difference=(src:number, dest:number)#:number\n"
		+ "point_distance_3d=(x1:number, y1:number, z1:number, x2:number, y2:number, z2:number)#:number\n"
		+ "point_distance=(x1:number, y1:number, x2:number, y2:number)#:number\n"
		+ "point_direction=(x1:number, y1:number, x2:number, y2:number)#:number\n"
		+ "lengthdir_x=(len:number, dir:number)#:number\n"
		+ "lengthdir_y=(len:number, dir:number)#:number\n"
		+ "real=(val)#:number\n"
		+ "bool=(val):\n"
		+ "string=(val_or_template, ...)\n"
		+ "int64=(val)#:int\n"
		+ "ptr=(val):bool\n"
		+ "handle_parse=(val_string)\n"
		+ "string_format=(val:number,total:number,dec:number)#:string\n"
		+ "chr=(val:int)#:string\n"
		+ "ansi_char=(val)#:\n"
		+ "ord=(char:string)#:int\n"
		+ "method=(struct_ref_or_instance_id, func):\n"
		+ "method_get_index=(method):\n"
		+ "method_get_self=(method):\n"
		+ "string_length=(str:string)#:int\n"
		+ "string_byte_length=(str:string)#:int\n"
		+ "string_pos=(substr:string, str:string)#:int\n"
		+ "string_pos_ext=(substr:string, str:string, start:int)#:int\n"
		+ "string_last_pos=(substr:string, str:string)#:int\n"
		+ "string_last_pos_ext=(substr:string, str:string, start:int)#:int\n"
		+ "string_copy=(str:string, index:int, count:int)#:string\n"
		+ "string_char_at=(str:string, index:int)#:string\n"
		+ "string_ord_at=(str:string, index:int)#:int\n"
		+ "string_byte_at=(str:string, index:int)#:int\n"
		+ "string_set_byte_at=(str:string, index:int, val:int)#:string\n"
		+ "string_delete=(str:string, index:int, count:int)#:string\n"
		+ "string_insert=(substr:string, str:string, index:int)#:string\n"
		+ "string_lower=(str:string)#:string\n"
		+ "string_upper=(str:string)#:string\n"
		+ "string_repeat=(str:string, count:int)#:string\n"
		+ "string_letters=(str:string)#:string\n"
		+ "string_digits=(str:string)#:string\n"
		+ "string_lettersdigits=(str:string)#:string\n"
		+ "string_replace=(str:string, substr:string, newstr:string)#:string\n"
		+ "string_replace_all=(str:string, substr:string, newstr:string)#:string\n"
		+ "string_count=(substr:string, str:string)#:int\n"
		+ "string_hash_to_newline=(:string)#:string\n"
		+ "string_ext=(format,arg_array)\n"
		+ "string_trim_start=(str, [substrs])\n"
		+ "string_trim_end=(str, [substrs])\n"
		+ "string_trim=(str, [substrs])\n"
		+ "string_starts_with=(str,substr)\n"
		+ "string_ends_with=(str,substr)\n"
		+ "string_split=(str,delim,[remove_empty],[max_splits])\n"
		+ "string_split_ext=(str,delim_array,[remove_empty],[max_splits])\n"
		+ "string_join=(delim,...)\n"
		+ "string_join_ext=(delim,val_array)\n"
		+ "string_concat=(...)\n"
		+ "string_concat_ext=(val_array,[offset],[length])\n"
		+ "string_foreach=(str,func,[pos],[length])\n"
		+ "clipboard_has_text=():\n"
		+ "clipboard_set_text=(str)\n"
		+ "clipboard_get_text=():\n"
		+ "date_current_datetime=():date\n"
		+ "date_create_datetime=(year,month,day,hour,minute,second):\n"
		+ "date_valid_datetime=(year:int,month:int,day:int,hour:int,minute:int,second:int):date\n"
		+ "date_inc_year=(:date,amount):date\n"
		+ "date_inc_month=(:date,amount):date\n"
		+ "date_inc_week=(:date,amount):date\n"
		+ "date_inc_day=(:date,amount):date\n"
		+ "date_inc_hour=(:date,amount):date\n"
		+ "date_inc_minute=(:date,amount):date\n"
		+ "date_inc_second=(:date,amount):date\n"
		+ "date_get_year=(date):\n"
		+ "date_get_month=(date):\n"
		+ "date_get_week=(date):\n"
		+ "date_get_day=(date):\n"
		+ "date_get_hour=(date):\n"
		+ "date_get_minute=(date):\n"
		+ "date_get_second=(date):\n"
		+ "date_get_weekday=(date):\n"
		+ "date_get_day_of_year=(date):\n"
		+ "date_get_hour_of_year=(date):\n"
		+ "date_get_minute_of_year=(date):\n"
		+ "date_get_second_of_year=(date):\n"
		+ "date_year_span=(date1:date,date2:date):number\n"
		+ "date_month_span=(date1:date,date2:date):number\n"
		+ "date_week_span=(date1:date,date2:date):number\n"
		+ "date_day_span=(date1:date,date2:date):number\n"
		+ "date_hour_span=(date1:date,date2:date):number\n"
		+ "date_minute_span=(date1:date,date2:date):number\n"
		+ "date_second_span=(date1:date,date2:date):number\n"
		+ "date_compare_datetime=(date1:date,date2:date):number\n"
		+ "date_compare_date=(date1:date,date2:date):number\n"
		+ "date_compare_time=(date1:date,date2:date):number\n"
		+ "date_date_of=(:date):date\n"
		+ "date_time_of=(:date):date\n"
		+ "date_datetime_string=(:date):string\n"
		+ "date_date_string=(:date):string\n"
		+ "date_time_string=(:date):string\n"
		+ "date_days_in_month=(:date):int\n"
		+ "date_days_in_year=(:date):int\n"
		+ "date_leap_year=(:date):bool\n"
		+ "date_is_today=(:date):bool\n"
		+ "date_set_timezone=(timezone)\n"
		+ "date_get_timezone=():\n"
		+ "game_set_speed=(value,type)\n"
		+ "game_get_speed=(type):\n"
		+ "motion_set=:(dir:number, speed:number)\n"
		+ "motion_add=:(dir:number, speed:number)\n"
		+ "place_free=:(x:number, y:number):bool\n"
		+ "place_empty=:(x:number, y:number):bool\n"
		+ "place_meeting=:(x:number, y:number, obj:index):\n"
		+ "place_snapped=:(hsnap:number, vsnap:number):bool\n"
		+ "move_random=:(hsnap:number, vsnap:number)\n"
		+ "move_snap=:(hsnap:number, vsnap:number)\n"
		+ "move_towards_point=:(x:number, y:number, sp:number)\n"
		+ "move_contact_solid=:(dir:number, maxdist:number)\n"
		+ "move_contact_all=:(dir:number, maxdist:number)\n"
		+ "move_outside_solid=:(dir:number, maxdist:number)\n"
		+ "move_outside_all=:(dir:number, maxdist:number)\n"
		+ "move_bounce_solid=:(advanced:bool)\n"
		+ "move_bounce_all=:(advanced:bool)\n"
		+ "move_wrap=:(hor:bool, vert:bool, margin:number)\n"
		+ "move_and_collide=:(dx,dy,obj,[num_iterations], [xoff],[yoff],[max_x_move],[max_y_move])\n"
		+ "distance_to_point=:(x:number, y:number):number\n"
		+ "distance_to_object=:(obj:index):number\n"
		+ "position_empty=:(x:number, y:number):bool\n"
		+ "position_meeting=:(x:number, y:number, obj:index):bool\n"
		+ "sphere_is_visible=(x,y,z,radius):\n"
		+ "path_start=:(path,speed,endaction,absolute)\n"
		+ "path_end=:()\n"
		+ "mp_linear_step=:(x:number,y:number,speed:number,checkall:bool):\n"
		+ "mp_potential_step=:(x:number,y:number,speed:number,checkall:bool):\n"
		+ "mp_linear_step_object=:(x:number,y:number,speed:number,obj:index):\n"
		+ "mp_potential_step_object=:(x:number,y:number,speed:number,obj:index):\n"
		+ "mp_potential_settings=:(maxrot,rotstep,ahead,onspot)\n"
		+ "mp_linear_path=:(path:index,x:number,y:number,step:number,checkall:bool):\n"
		+ "mp_potential_path=:(path:index,x:number,y:number,step:number,factor:number,checkall:bool):\n"
		+ "mp_linear_path_object=:(path:index,x:number,y:number,step:number,obj:index):\n"
		+ "mp_potential_path_object=:(path:index,x:number,y:number,step:number,factor:number,obj:index):\n"
		+ "mp_grid_create=(left,top,hcells,vcells,cellwidth,cellheight):\n"
		+ "mp_grid_destroy=(id)\n"
		+ "mp_grid_clear_all=(id)\n"
		+ "mp_grid_clear_cell=(id,h,v)\n"
		+ "mp_grid_clear_rectangle=(id,left,top,right,bottom)\n"
		+ "mp_grid_add_cell=(id,h,v)\n"
		+ "mp_grid_get_cell=(id,h,v):\n"
		+ "mp_grid_add_rectangle=(id,left,top,right,bottom)\n"
		+ "mp_grid_add_instances=:(id,obj,prec)\n"
		+ "mp_grid_path=:(:index,path:index,xstart:number,ystart:number,xgoal:number,ygoal:number,allowdiag:bool):\n"
		+ "mp_grid_draw=(id)\n"
		+ "mp_grid_to_ds_grid=(src_mp_grid:index, dest_ds_grid:index):bool\n"
		+ "collision_point=:(x:number, y:number, obj:index, prec:bool, notme:bool):\n"
		+ "collision_rectangle=:(x1:number, y1:number, x2:number, y2:number, obj:index, prec, notme):\n"
		+ "collision_circle=:(x1:number, y1:number, radius, obj:index, prec, notme):\n"
		+ "collision_ellipse=:(x1:number, y1:number, x2:number, y2:number, obj:index, prec, notme):\n"
		+ "collision_line=:(x1:number, y1:number, x2:number, y2:number, obj:index, prec, notme):\n"
		+ "collision_point_list=(x,y,obj,prec,notme,list,ordered):\n"
		+ "collision_rectangle_list=(x1,y1,x2,y2,obj,prec,notme,list,ordered):\n"
		+ "collision_circle_list=(x1,y1,radius,obj,prec,notme,list,ordered):\n"
		+ "collision_ellipse_list=(x1,y1,x2,y2,obj,prec,notme,list,ordered):\n"
		+ "collision_line_list=(x1,y1,x2,y2,obj,prec,notme,list,ordered):\n"
		+ "instance_position_list=:(x:number, y:number, obj:index, list, ordered:bool):\n"
		+ "instance_place_list=:(x:number, y:number, obj:index, list, ordered:bool):\n"
		+ "point_in_rectangle=(px, py, x1:number, y1:number, x2:number, y2:number):\n"
		+ "point_in_triangle=(px, py, x1:number, y1:number, x2:number, y2:number, x3:number, y3:number):\n"
		+ "point_in_circle=(px, py, cx, cy, rad):\n"
		+ "rectangle_in_rectangle=(sx1:number, sy1:number, sx2:number, sy2:number, dx1:number, dy1:number, dx2:number, dy2:number):\n"
		+ "rectangle_in_triangle=(sx1:number, sy1:number, sx2:number, sy2:number, x1:number, y1:number, x2:number, y2:number, x3:number, y3:number):\n"
		+ "rectangle_in_circle=(sx1:number, sy1:number, sx2:number, sy2:number, cx:number, cy:number, rad:number):\n"
		+ "instance_find=(obj:id, n:int):any\n"
		+ "instance_exists=(obj:any):bool\n"
		+ "instance_number=(obj:any):int\n"
		+ "instance_position=(x:number, y:number, obj:any):any\n"
		+ "instance_nearest=:(x:number, y:number, obj:any):any\n"
		+ "instance_furthest=:(x:number, y:number, obj:any):any\n"
		+ "instance_place=:(x:number, y:number, obj:any):any\n"
		+ "instance_create_depth=(x:number, y:number, depth:number, obj:id, ?obj):any\n"
		+ "instance_create_layer=(x:number, y:number, layer, obj:id, ?obj):any\n"
		+ "instance_copy=:(performevent:bool):any\n"
		+ "instance_change=:(obj,performevents)\n"
		+ "instance_destroy=:(?what:any, ?performevent:bool)\n"
		+ "position_destroy=:(x,y)\n"
		+ "position_change=:(x,y,obj,performevents)\n"
		+ "instance_id_get=(index):\n"
		+ "instance_deactivate_all=:(notme,[collision_space])\n"
		+ "instance_deactivate_object=:(obj,[collision_space])\n"
		+ "instance_deactivate_region=:(left,top,width,height,inside,notme,[collision_space])\n"
		+ "instance_activate_all=:([collision_space])\n"
		+ "instance_activate_object=:(obj,[collision_space])\n"
		+ "instance_activate_region=:(left,top,width,height,inside,[collision_space])\n"
		+ "room_goto=(numb)\n"
		+ "room_goto_previous=()\n"
		+ "room_goto_next=()\n"
		+ "room_previous=(numb):\n"
		+ "room_next=(numb):\n"
		+ "room_restart=()\n"
		+ "game_end=()\n"
		+ "game_restart=()\n"
		+ "game_load=(filename):\n"
		+ "game_save=(filename)\n"
		+ "game_save_buffer=(buffer)\n"
		+ "game_load_buffer=(buffer):\n"
		+ "game_change=(working_directory,launch_parameters)\n"
		+ "scheduler_resolution_set=(milliseconds)\n"
		+ "scheduler_resolution_get=():\n"
		+ "event_perform=:(type,numb)\n"
		+ "event_perform_async=(type,ds_map)\n"
		+ "event_user=:(numb)\n"
		+ "event_perform_object=:(obj,type,numb)\n"
		+ "event_inherited=:()\n"
		+ "show_debug_message=(val_or_format, ...)\n"
		+ "show_debug_message_ext=(format,array_value)\n"
		+ "show_debug_overlay=(enable,[minimised],[scale],[alpha],[gamepad_enable],[gamepad_index]...)\n"
		+ "is_debug_overlay_open=():\n"
		+ "is_mouse_over_debug_overlay=():\n"
		+ "is_keyboard_used_debug_overlay=():\n"
		+ "show_debug_log=(enable)\n"
		+ "debug_event=(str,...)\n"
		+ "debug_get_callstack=([maxdepth],...):\n"
		+ "alarm_get=:(:int):\n"
		+ "alarm_set=:(:int, value:int)\n"
		+ "dbg_view=(name,visible,[x],[y],[width],[height],...)\n"
		+ "dbg_section=(name,[open])\n"
		+ "dbg_view_delete=(viewPTR)\n"
		+ "dbg_view_exists=(viewPTR):\n"
		+ "dbg_set_view=(viewPTR)\n"
		+ "dbg_section_delete=(sectionPTR)\n"
		+ "dbg_section_exists=(sectionPTR):\n"
		+ "dbg_set_section=(sectionPTR)\n"
		+ "dbg_control_delete=(controlPTR)\n"
		+ "dbg_control_exists=(controlPTR):\n"
		+ "dbg_slider=(dbgRefOrArrayOfDbgRef,[minimum],[maximum],[label],[step]...)\n"
		+ "dbg_slider_int=(dbgRefOrArrayOfDbgRef,[minimum],[maximum],[label],[step]...)\n"
		+ "dbg_drop_down=(dbgRefOrArrayOfDbgRef,specifierOrArrayValues,[labelOrArrayLabels],[label]...)\n"
		+ "dbg_watch=(dbgRefOrArrayOfDbgRef,[label],...)\n"
		+ "dbg_text=(dbgRefOrArrayOfDbgRefOrString)\n"
		+ "dbg_text_separator=(dbgRefOrArrayOfDbgRefOrString,[align])\n"
		+ "dbg_sprite=(dbgRefSpriteOrArrayOfDbgRef,dbgRefSpriteIndexOrArrayOfDbgRef,[label],[width],[height]...)\n"
		+ "dbg_text_input=(dbgRefOrArrayOfDbgRef,[label],[type]...)\n"
		+ "dbg_checkbox=(dbgRefOrArrayOfDbgRef,[label],...)\n"
		+ "dbg_colour=(dbgRefOrArrayOfDbgRef,[label],...)£\n"
		+ "dbg_color=(dbgRefOrArrayOfDbgRef,[label],...)$\n"
		+ "dbg_button=(label,dbgRef,[width],[height]...)\n"
		+ "dbg_sprite_button=(dbgRef,dbgRefSprite,dbgRefSpriteIndex,[width],[height],[xoffset],[yoffset],[widthSprite],[heightSprite]...)\n"
		+ "dbg_same_line=()\n"
		+ "dbg_add_font_glyphs=(filenameTTF,[size],[fontRange]...)\n"
		+ "dbg_get_gamepad_input=():\n"
		+ "ref_create=(dbgrefOrStruct,dbgrefOrName,[index],...):\n"
		+ "debug_input_record=(filter)\n"
		+ "debug_input_save=(filename)\n"
		+ "debug_input_playback=(filename)\n"
		+ "keyboard_set_map=(key1, key2):bool\n"
		+ "keyboard_get_map=(key):\n"
		+ "keyboard_unset_map=()\n"
		+ "keyboard_check=(key:index):\n"
		+ "keyboard_check_pressed=(key:index):\n"
		+ "keyboard_check_released=(key:index):\n"
		+ "keyboard_check_direct=(key:index):\n"
		+ "keyboard_get_numlock=():\n"
		+ "keyboard_set_numlock=(on)\n"
		+ "keyboard_key_press=(key)\n"
		+ "keyboard_key_release=(key)\n"
		+ "keyboard_clear=(key:index)\n"
		+ "io_clear=()\n"
		+ "mouse_check_button=(button:index):\n"
		+ "mouse_check_button_pressed=(button:index):\n"
		+ "mouse_check_button_released=(button:index):\n"
		+ "mouse_wheel_up=():\n"
		+ "mouse_wheel_down=():\n"
		+ "mouse_clear=(button)\n"
		+ "draw_self=:()\n"
		+ "draw_sprite=:(sprite,subimg,x,y)\n"
		+ "draw_sprite_pos=:(sprite,subimg,x1,y1,x2,y2,x3,y3,x4,y4,alpha)\n"
		+ "draw_sprite_ext=:(sprite,subimg,x,y,xscale,yscale,rot,col,alpha)\n"
		+ "draw_sprite_stretched=:(sprite,subimg,x,y,w,h)\n"
		+ "draw_sprite_stretched_ext=:(sprite,subimg,x,y,w,h,col,alpha)\n"
		+ "draw_sprite_tiled=:(sprite,subimg,x,y)\n"
		+ "draw_sprite_tiled_ext=:(sprite,subimg,x,y,xscale,yscale,col,alpha)\n"
		+ "draw_sprite_part=:(sprite,subimg,left,top,width,height,x,y)\n"
		+ "draw_sprite_part_ext=:(sprite,subimg,left,top,width,height,x,y,xscale,yscale,col,alpha)\n"
		+ "draw_sprite_general=:(sprite,subimg,left,top,width,height,x,y,xscale,yscale,rot,c1,c2,c3,c4,alpha)\n"
		+ "draw_clear=(col)\n"
		+ "draw_clear_alpha=(col,alpha)\n"
		+ "draw_clear_depth=(depth)\n"
		+ "draw_clear_stencil=(stencil)\n"
		+ "draw_clear_ext=([col],[alpha],[depth],[stencil])\n"
		+ "draw_point=(x,y)\n"
		+ "draw_line=(x1,y1,x2,y2)\n"
		+ "draw_line_width=(x1,y1,x2,y2,w)\n"
		+ "draw_rectangle=(x1,y1,x2,y2,outline)\n"
		+ "draw_roundrect=(x1,y1,x2,y2,outline)\n"
		+ "draw_roundrect_ext=(x1,y1,x2,y2,radiusx,radiusy,outline)\n"
		+ "draw_triangle=(x1,y1,x2,y2,x3,y3,outline)\n"
		+ "draw_circle=(x,y,r,outline)\n"
		+ "draw_ellipse=(x1,y1,x2,y2,outline)\n"
		+ "draw_set_circle_precision=(precision)\n"
		+ "draw_get_circle_precision=():\n"
		+ "draw_arrow=(x1,y1,x2,y2,size)\n"
		+ "draw_button=(x1,y1,x2,y2,up)\n"
		+ "draw_path=(path,x,y,absolute)\n"
		+ "draw_healthbar=(x1,y1,x2,y2,amount,backcol,mincol,maxcol,direction,showback,showborder)\n"
		+ "draw_getpixel=(x,y):\n"
		+ "draw_getpixel_ext=(x,y):\n"
		+ "draw_set_colour=(:color)\n"
		+ "draw_set_color=(:color)\n"
		+ "draw_set_alpha=(alpha:number)\n"
		+ "draw_get_colour=():color\n"
		+ "draw_get_color=():color\n"
		+ "draw_get_alpha=():number\n"
		+ "merge_colour=(col1:color, col2:color, amount:number)#:color\n"
		+ "make_colour_rgb=(red:number, green:number, blue:number)#:color\n"
		+ "make_colour_hsv=(hue:number, saturation:number, value:number)#:color\n"
		+ "colour_get_red=(:color)#:int\n"
		+ "colour_get_green=(:color)#:int\n"
		+ "colour_get_blue=(:color)#:int\n"
		+ "colour_get_hue=(:color)#:number\n"
		+ "colour_get_saturation=(:color)#:number\n"
		+ "colour_get_value=(:color)#:number\n"
		+ "merge_color=(col1:color, col2:color, amount:number)#:color\n"
		+ "make_color_rgb=(red:number, green:number, blue:number)#:color\n"
		+ "make_color_hsv=(hue:number, saturation:number, value:number)#:color\n"
		+ "color_get_red=(:color)#:int\n"
		+ "color_get_green=(:color)#:int\n"
		+ "color_get_blue=(:color)#:int\n"
		+ "color_get_hue=(:color)#:number\n"
		+ "color_get_saturation=(:color)#:number\n"
		+ "color_get_value=(:color)#:number\n"
		+ "screen_save=(fname)\n"
		+ "screen_save_part=(fname,x,y,w,h)\n"
		+ "gif_open=(width:int, height:int, ?color:int):int\n"
		+ "gif_add_surface=(gif:int, surf, delay:number, ?xoffset:number, ?yoffset:number, ?quant:number):int\n"
		+ "gif_save=(gif:int, fname:string):int\n"
		+ "gif_save_buffer=(gif:int):int\n"
		+ "draw_set_font=(:font)\n"
		+ "draw_get_font=():\n"
		+ "draw_set_halign=(halign:int)\n"
		+ "draw_get_halign=():\n"
		+ "draw_set_valign=(valign:int)\n"
		+ "draw_get_valign=():\n"
		+ "draw_text=(x,y,string)\n"
		+ "draw_text_ext=(x,y,string,sep,w)\n"
		+ "string_width=(:string):number\n"
		+ "string_height=(:string):number\n"
		+ "string_width_ext=(:string, sep:number, w:number):number\n"
		+ "string_height_ext=(:string, sep:number, w:number):number\n"
		+ "draw_text_transformed=(x,y,string,xscale,yscale,angle)\n"
		+ "draw_text_ext_transformed=(x,y,string,sep,w,xscale,yscale,angle)\n"
		+ "draw_text_colour=(x,y,string,c1,c2,c3,c4,alpha)£\n"
		+ "draw_text_ext_colour=(x,y,string,sep,w,c1,c2,c3,c4,alpha)£\n"
		+ "draw_text_transformed_colour=(x,y,string,xscale,yscale,angle,c1,c2,c3,c4,alpha)£\n"
		+ "draw_text_ext_transformed_colour=(x,y,string,sep,w,xscale,yscale,angle,c1,c2,c3,c4,alpha)£\n"
		+ "draw_text_color=(x,y,string,c1,c2,c3,c4,alpha)$\n"
		+ "draw_text_ext_color=(x,y,string,sep,w,c1,c2,c3,c4,alpha)$\n"
		+ "draw_text_transformed_color=(x,y,string,xscale,yscale,angle,c1,c2,c3,c4,alpha)$\n"
		+ "draw_text_ext_transformed_color=(x,y,string,sep,w,xscale,yscale,angle,c1,c2,c3,c4,alpha)$\n"
		+ "draw_point_colour=(x,y,col1)£\n"
		+ "draw_line_colour=(x1,y1,x2,y2,col1,col2)£\n"
		+ "draw_line_width_colour=(x1,y1,x2,y2,w,col1,col2)£\n"
		+ "draw_rectangle_colour=(x1,y1,x2,y2,col1,col2,col3,col4,outline)£\n"
		+ "draw_roundrect_colour=(x1,y1,x2,y2,col1,col2,outline)£\n"
		+ "draw_roundrect_colour_ext=(x1,y1,x2,y2,radiusx,radiusy,col1,col2,outline)£\n"
		+ "draw_triangle_colour=(x1,y1,x2,y2,x3,y3,col1,col2,col3,outline)£\n"
		+ "draw_circle_colour=(x,y,r,col1,col2,outline)£\n"
		+ "draw_ellipse_colour=(x1,y1,x2,y2,col1,col2,outline)£\n"
		+ "draw_point_color=(x,y,col1)$\n"
		+ "draw_line_color=(x1,y1,x2,y2,col1,col2)$\n"
		+ "draw_line_width_color=(x1,y1,x2,y2,w,col1,col2)$\n"
		+ "draw_rectangle_color=(x1,y1,x2,y2,col1,col2,col3,col4,outline)$\n"
		+ "draw_roundrect_color=(x1,y1,x2,y2,col1,col2,outline)$\n"
		+ "draw_roundrect_color_ext=(x1,y1,x2,y2,radiusx,radiusy,col1,col2,outline)$\n"
		+ "draw_triangle_color=(x1,y1,x2,y2,x3,y3,col1,col2,col3,outline)$\n"
		+ "draw_circle_color=(x,y,r,col1,col2,outline)$\n"
		+ "draw_ellipse_color=(x1,y1,x2,y2,col1,col2,outline)$\n"
		+ "draw_primitive_begin=(kind)\n"
		+ "draw_vertex=(x,y)\n"
		+ "draw_vertex_colour=(x,y,col,alpha)£\n"
		+ "draw_vertex_color=(x,y,col,alpha)$\n"
		+ "draw_primitive_end=()\n"
		+ "sprite_get_uvs=(spr:index, subimg:number):\n"
		+ "font_get_uvs=(font:index):\n"
		+ "font_get_info=(font):\n"
		+ "font_cache_glyph=(font,glyphIndex)\n"
		+ "sprite_get_texture=(spr:index, subimg:number):\n"
		+ "font_get_texture=(font:index):\n"
		+ "texture_get_width=(texid):\n"
		+ "texture_get_height=(texid):\n"
		+ "texture_get_uvs=(texid):\n"
		+ "draw_primitive_begin_texture=(kind,texid)\n"
		+ "draw_vertex_texture=(x,y,xtex,ytex)\n"
		+ "draw_vertex_texture_colour=(x,y,xtex,ytex,col,alpha)£\n"
		+ "draw_vertex_texture_color=(x,y,xtex,ytex,col,alpha)$\n"
		+ "texture_global_scale=(pow2integer)\n"
		+ "surface_create=(w,h,[format]):\n"
		+ "surface_create_ext=(name,w,h):\n"
		+ "surface_resize=(id,width,height)\n"
		+ "surface_free=(id)\n"
		+ "surface_exists=(id):\n"
		+ "surface_get_width=(id):\n"
		+ "surface_get_height=(id):\n"
		+ "surface_get_texture=(id):\n"
		+ "surface_get_texture_depth=(id):\n"
		+ "surface_get_format=(id):\n"
		+ "surface_set_target=(id)\n"
		+ "surface_set_target_ext=(index:int, surf):bool\n"
		+ "surface_get_target=():\n"
		+ "surface_get_target_depth=():\n"
		+ "surface_get_target_ext=(index):\n"
		+ "surface_reset_target=()\n"
		+ "surface_depth_disable=(disable)\n"
		+ "surface_get_depth_disable=():\n"
		+ "surface_has_depth=(id)\n"
		+ "surface_format_is_supported=(format):\n"
		+ "draw_surface=(id,x,y)\n"
		+ "draw_surface_stretched=(id,x,y,w,h)\n"
		+ "draw_surface_tiled=(id,x,y)\n"
		+ "draw_surface_part=(id,left,top,width,height,x,y)\n"
		+ "draw_surface_ext=(id,x,y,xscale,yscale,rot,col,alpha)\n"
		+ "draw_surface_stretched_ext=(id,x,y,w,h,col,alpha)\n"
		+ "draw_surface_tiled_ext=(id,x,y,xscale,yscale,col,alpha)\n"
		+ "draw_surface_part_ext=(id,left,top,width,height,x,y,xscale,yscale,col,alpha)\n"
		+ "draw_surface_general=(id,left,top,width,height,x,y,xscale,yscale,rot,c1,c2,c3,c4,alpha)\n"
		+ "surface_getpixel=(id,x,y):\n"
		+ "surface_getpixel_ext=(id,x,y):\n"
		+ "surface_save=(id,fname)\n"
		+ "surface_save_part=(id,fname,x,y,w,h)\n"
		+ "surface_copy=(destination,x,y,source)\n"
		+ "surface_copy_part=(destination,x,y,source,xs,ys,ws,hs)\n"
		+ "application_surface_draw_enable=(on_off)\n"
		+ "application_get_position=():\n"
		+ "application_surface_enable=(enable)\n"
		+ "application_surface_is_enabled=():\n"
		+ "application_surface_is_draw_enabled=():\n"
		+ "video_open=(path)\n"
		+ "video_close=()\n"
		+ "video_set_volume=(vol)\n"
		+ "video_draw=()\n"
		+ "video_pause=()\n"
		+ "video_resume=()\n"
		+ "video_enable_loop=(enable)\n"
		+ "video_seek_to=(milliseconds)\n"
		+ "video_get_duration=():\n"
		+ "video_get_position=():\n"
		+ "video_get_status=():\n"
		+ "video_get_format=():\n"
		+ "video_is_looping=():\n"
		+ "video_get_volume=():\n"
		+ "display_get_width=():\n"
		+ "display_get_height=():\n"
		+ "display_get_orientation=():\n"
		+ "display_get_gui_width=():\n"
		+ "display_get_gui_height=():\n"
		+ "display_get_frequency=():\n"
		+ "display_reset=(aa, vsync):\n"
		+ "display_mouse_get_x=():\n"
		+ "display_mouse_get_y=():\n"
		+ "display_mouse_set=(x,y)\n"
		+ "display_set_ui_visibility=(flags)\n"
		+ "window_set_showborder=(show)\n"
		+ "window_get_showborder=():\n"
		+ "window_set_fullscreen=(full)\n"
		+ "window_get_fullscreen=():\n"
		+ "window_set_caption=(caption)\n"
		+ "window_set_min_width=(minwidth)\n"
		+ "window_set_max_width=(maxwidth)\n"
		+ "window_set_min_height=(minheight)\n"
		+ "window_set_max_height=(maxheight)\n"
		+ "window_get_visible_rects=(startx,starty,endx,endy):\n"
		+ "window_get_caption=():\n"
		+ "window_set_cursor=(curs)\n"
		+ "window_enable_borderless_fullscreen=(enable)\n"
		+ "window_get_borderless_fullscreen=():\n"
		+ "window_minimise=()£\n"
		+ "window_minimize=()$\n"
		+ "window_restore=()\n"
		+ "window_get_cursor=():\n"
		+ "window_set_colour=(colour)£\n"
		+ "window_get_colour=()£:\n"
		+ "window_set_color=(color)$\n"
		+ "window_get_color=()$:\n"
		+ "window_set_position=(x,y)\n"
		+ "window_set_size=(w,h)\n"
		+ "window_set_rectangle=(x,y,w,h)\n"
		+ "window_center=()\n"
		+ "window_get_x=():\n"
		+ "window_get_y=():\n"
		+ "window_get_width=():\n"
		+ "window_get_height=():\n"
		+ "window_mouse_get_x=():\n"
		+ "window_mouse_get_y=():\n"
		+ "window_mouse_set=(x,y)\n"
		+ "window_mouse_set_locked=(enable)\n"
		+ "window_mouse_get_locked=():\n"
		+ "window_mouse_get_delta_x=():\n"
		+ "window_mouse_get_delta_y=():\n"
		+ "window_view_mouse_get_x=(id):\n"
		+ "window_view_mouse_get_y=(id):\n"
		+ "window_views_mouse_get_x=():\n"
		+ "window_views_mouse_get_y=():\n"
		+ "audio_listener_position=(x,y,z)\n"
		+ "audio_listener_velocity=(vx,vy,vz)\n"
		+ "audio_listener_orientation=(lookat_x,lookat_y,lookat_z,up_x,up_y,up_z)\n"
		+ "audio_emitter_position=(emitterid,x,y,z)\n"
		+ "audio_emitter_create=():\n"
		+ "audio_emitter_free=(emitterid)\n"
		+ "audio_emitter_exists=(emitterid):\n"
		+ "audio_emitter_pitch=(emitterid,pitch)\n"
		+ "audio_emitter_velocity=(emitterid,vx,vy,vz)\n"
		+ "audio_emitter_falloff=(emitterid, falloff_ref_dist,falloff_max_dist,falloff_factor)\n"
		+ "audio_emitter_gain=(emitterid,gain,[time])\n"
		+ "audio_play_sound=(soundid:index,priority:number,loops:bool):\n"
		+ "audio_play_sound_on=(em:index,soundid:index,priority:number,loops:bool):\n"
		+ "audio_play_sound_at=(soundid:index,x:number,y:number,z:number, falloff_ref_dist:number,falloff_max_dist:number,falloff_factor:number,loops:bool, priority:number):\n"
		+ "audio_play_sound_ext=(params)\n"
		+ "audio_stop_sound=(soundid)\n"
		+ "audio_resume_sound=(soundid)\n"
		+ "audio_pause_sound=(soundid)\n"
		+ "audio_channel_num=(numchannels)\n"
		+ "audio_sound_length=(sound:index):\n"
		+ "audio_get_type=(soundid):\n"
		+ "audio_falloff_set_model=(falloffmode)\n"
		+ "audio_master_gain=(gain)\n"
		+ "audio_sound_gain=(index,level,[time])\n"
		+ "audio_sound_pitch=(index,pitch)\n"
		+ "audio_stop_all=()\n"
		+ "audio_resume_all=()\n"
		+ "audio_pause_all=()\n"
		+ "audio_is_playing=(soundid):\n"
		+ "audio_is_paused=(soundid):\n"
		+ "audio_exists=(soundid):\n"
		+ "audio_system_is_available=():\n"
		+ "audio_system_is_initialised=():\n"
		+ "audio_sound_is_playable=(soundid):\n"
		+ "audio_emitter_get_gain=(emitterid):\n"
		+ "audio_emitter_get_pitch=(emitterid):\n"
		+ "audio_emitter_get_x=(emitterid):\n"
		+ "audio_emitter_get_y=(emitterid):\n"
		+ "audio_emitter_get_z=(emitterid):\n"
		+ "audio_emitter_get_vx=(emitterid):\n"
		+ "audio_emitter_get_vy=(emitterid):\n"
		+ "audio_emitter_get_vz=(emitterid):\n"
		+ "audio_listener_set_position=(index, x,y,z)\n"
		+ "audio_listener_set_velocity=(index, vx,vy,vz)\n"
		+ "audio_listener_set_orientation=(index, lookat_x,lookat_y,lookat_z,up_x,up_y,up_z)\n"
		+ "audio_listener_get_data=(index):\n"
		+ "audio_set_master_gain=(listenerIndex, gain)\n"
		+ "audio_get_master_gain=(listenerIndex):\n"
		+ "audio_sound_get_gain=(index):\n"
		+ "audio_sound_get_pitch=(index):\n"
		+ "audio_get_name=(index):\n"
		+ "audio_sound_get_asset=(voiceIndex):\n"
		+ "audio_sound_set_track_position=(index, time)\n"
		+ "audio_sound_get_track_position=(index):\n"
		+ "audio_sound_loop=(voiceIndex, loopState)\n"
		+ "audio_sound_get_loop=(voiceIndex):\n"
		+ "audio_sound_loop_start=(index, time)\n"
		+ "audio_sound_get_loop_start=(index):\n"
		+ "audio_sound_loop_end=(index, time)\n"
		+ "audio_sound_get_loop_end=(index):\n"
		+ "audio_create_stream=(filename)!:\n"
		+ "audio_destroy_stream=(stream_sound_id)!\n"
		+ "audio_create_sync_group=(looping):\n"
		+ "audio_destroy_sync_group=(sync_group_id)\n"
		+ "audio_play_in_sync_group=(sync:index, snd:index):\n"
		+ "audio_start_sync_group=(sync_group_id)\n"
		+ "audio_stop_sync_group=(sync_group_id)\n"
		+ "audio_pause_sync_group=(sync_group_id)\n"
		+ "audio_resume_sync_group=(sync_group_id)\n"
		+ "audio_sync_group_get_track_pos=(sync_group_id):\n"
		+ "audio_sync_group_debug=(sync_group_id)\n"
		+ "audio_sync_group_is_playing=(sync_group_id):\n"
		+ "audio_sync_group_is_paused=(sync_group_id):\n"
		+ "audio_debug=(enable)\n"
		+ "audio_throw_on_error=(enable)\n"
		+ "audio_group_load=(groupId):\n"
		+ "audio_group_unload=(ind:int):bool\n"
		+ "audio_group_is_loaded=(groupId):\n"
		+ "audio_group_load_progress=(groupId):\n"
		+ "audio_group_name=(group:index):\n"
		+ "audio_group_stop_all=(groupId)\n"
		+ "audio_group_set_gain=(groupId, volume, [time])\n"
		+ "audio_group_get_gain=(groupId):\n"
		+ "audio_group_get_assets=(groupId):\n"
		+ "audio_sound_get_audio_group=(index):\n"
		+ "audio_create_buffer_sound=(bufferId, format, rate, offset, length, channels)!:\n"
		+ "audio_free_buffer_sound=(soundId)!\n"
		+ "audio_create_play_queue=(bufferFormat, sampleRate, channels)!:\n"
		+ "audio_free_play_queue=(queueId)!\n"
		+ "audio_queue_sound=(queueId, buffer_id, offset, length)!\n"
		+ "audio_get_recorder_count=():\n"
		+ "audio_get_recorder_info=(recorder_num):\n"
		+ "audio_start_recording=(rec:number):\n"
		+ "audio_stop_recording=(channel_index)\n"
		+ "audio_sound_get_listener_mask=(soundid):\n"
		+ "audio_emitter_get_listener_mask=(emitterid):\n"
		+ "audio_get_listener_mask=():\n"
		+ "audio_sound_set_listener_mask=(soundid,mask)\n"
		+ "audio_emitter_set_listener_mask=(emitterid,mask)\n"
		+ "audio_set_listener_mask=(mask)\n"
		+ "audio_get_listener_count=():\n"
		+ "audio_get_listener_info=(index):\n"
		+ "show_message=(str)\n"
		+ "show_message_async=(:string):int\n"
		+ "clickable_add=(x,y,spritetpe,URL,target,params):\n"
		+ "clickable_add_ext=(x,y,spritetpe,URL,target,params,scale,alpha):\n"
		+ "clickable_change=(buttonid,spritetpe,x,y)\n"
		+ "clickable_change_ext=(buttonid,spritetpe,x,y,scale,alpha)\n"
		+ "clickable_delete=(buttonid)\n"
		+ "clickable_exists=(index):\n"
		+ "clickable_set_style=(buttonid,map)\n"
		+ "show_question=(str:string):\n"
		+ "show_question_async=(:string):\n"
		+ "get_integer=(:string,:number):\n"
		+ "get_string=(:string,:string):\n"
		+ "get_integer_async=(:string,:number):\n"
		+ "get_string_async=(:string,:string):\n"
		+ "get_login_async=(:string,:string):\n"
		+ "get_open_filename=(:string,:string):\n"
		+ "get_save_filename=(:string,:string):\n"
		+ "get_open_filename_ext=(:string,:string,:string,:string):\n"
		+ "get_save_filename_ext=(:string,:string,:string,:string):\n"
		+ "show_error=(str,abort)\n"
		+ "highscore_clear=()\n"
		+ "highscore_add=(str,numb)\n"
		+ "highscore_value=(:index):\n"
		+ "highscore_name=(:index):\n"
		+ "draw_highscore=(x1,y1,x2,y2)\n"
		+ "sprite_exists=(ind):\n"
		+ "sprite_get_name=(ind):\n"
		+ "sprite_get_number=(ind):\n"
		+ "sprite_get_width=(ind):\n"
		+ "sprite_get_height=(ind):\n"
		+ "sprite_get_xoffset=(ind):\n"
		+ "sprite_get_yoffset=(ind):\n"
		+ "sprite_get_bbox_mode=(ind):\n"
		+ "sprite_get_bbox_left=(ind):\n"
		+ "sprite_get_bbox_right=(ind):\n"
		+ "sprite_get_bbox_top=(ind):\n"
		+ "sprite_get_bbox_bottom=(ind):\n"
		+ "sprite_get_convex_hull=(ind,[max_pts],[subimg]):\n"
		+ "sprite_set_bbox_mode=(ind,mode)\n"
		+ "sprite_set_bbox=(ind,left,top,right,bottom)\n"
		+ "sprite_save=(ind,subimg,fname)\n"
		+ "sprite_save_strip=(ind,fname)\n"
		+ "sprite_set_cache_size=(ind, max)\n"
		+ "sprite_set_cache_size_ext=(ind, image, max)\n"
		+ "sprite_get_tpe=(index,subindex):\n"
		+ "sprite_prefetch=(ind)\n"
		+ "sprite_prefetch_multi=(indarray)\n"
		+ "sprite_flush=(ind)\n"
		+ "sprite_flush_multi=(indarray)\n"
		+ "sprite_set_speed=(ind,speed,type)\n"
		+ "sprite_get_speed_type=(ind):\n"
		+ "sprite_get_speed=(ind):\n"
		+ "sprite_get_info=(ind):\n"
		+ "sprite_get_nineslice=(ind):\n"
		+ "sprite_set_nineslice=(ind,nineslice)\n"
		+ "sprite_nineslice_create=():\n"
		+ "texture_is_ready=(tex_id):\n"
		+ "texture_prefetch=(tex_id_or_groupname)\n"
		+ "texture_flush=(tex_id_or_groupname)\n"
		+ "texturegroup_get_textures=(groupname):\n"
		+ "texturegroup_get_sprites=(groupname):\n"
		+ "texturegroup_get_fonts=(groupname):\n"
		+ "texturegroup_get_tilesets=(groupname):\n"
		+ "texturegroup_get_names=():\n"
		+ "texturegroup_load=(groupname,[prefetch]):\n"
		+ "texturegroup_unload=(groupname)\n"
		+ "texturegroup_get_status=(groupname):\n"
		+ "texturegroup_set_mode=(explicit,debug,default_sprite)\n"
		+ "texturegroup_exists=(groupname):\n"
		+ "texturegroup_add=(groupname,filename_or_buffer_or_array_of_filenames_or_buffers,struct_of_asset_descriptions)\n"
		+ "texturegroup_delete=(groupname)\n"
		+ "texture_debug_messages=(debug_level)\n"
		+ "font_exists=(ind):\n"
		+ "font_get_name=(ind):\n"
		+ "font_get_fontname=(ind):\n"
		+ "font_get_bold=(ind):\n"
		+ "font_get_italic=(ind):\n"
		+ "font_get_first=(ind):\n"
		+ "font_get_last=(ind):\n"
		+ "font_get_size=(ind):\n"
		+ "font_set_cache_size=(font,max)\n"
		+ "path_exists=(ind):\n"
		+ "path_get_name=(ind):\n"
		+ "path_get_length=(ind):\n"
		+ "path_get_kind=(ind):\n"
		+ "path_get_closed=(ind):\n"
		+ "path_get_precision=(ind):\n"
		+ "path_get_number=(ind):\n"
		+ "path_get_point_x=(ind,n):\n"
		+ "path_get_point_y=(ind,n):\n"
		+ "path_get_point_speed=(ind,n):\n"
		+ "path_get_x=(ind,pos):\n"
		+ "path_get_y=(ind,pos):\n"
		+ "path_get_speed=(ind,pos):\n"
		+ "script_exists=(ind):\n"
		+ "script_get_name=(:id):string;\n"
		+ "timeline_add=()!:\n"
		+ "timeline_delete=(ind)!\n"
		+ "timeline_clear=(ind)\n"
		+ "timeline_exists=(ind):\n"
		+ "timeline_get_name=(ind):\n"
		+ "timeline_moment_clear=(ind,step)\n"
		+ "timeline_moment_add_script=(ind,step,script)\n"
		+ "timeline_size=(ind):\n"
		+ "timeline_max_moment=(:index):\n"
		+ "object_exists=(ind):\n"
		+ "object_get_name=(o:id):string\n"
		+ "object_get_sprite=(ind):\n"
		+ "object_get_solid=(ind):\n"
		+ "object_get_visible=(ind):\n"
		+ "object_get_persistent=(ind):\n"
		+ "object_get_mask=(ind):\n"
		+ "object_get_parent=(ind):\n"
		+ "object_get_physics=(ind):\n"
		+ "object_is_ancestor=(ind_child,ind_parent):\n"
		+ "room_exists=(ind):\n"
		+ "room_get_name=(ind):\n"
		+ "room_get_info=(ind,[views],[instances],[layers],[layer_elements],[tilemap_data],[live]):\n"
		+ "sprite_set_offset=(ind,xoff,yoff)\n"
		+ "sprite_duplicate=(:index):\n"
		+ "sprite_assign=(ind,source)\n"
		+ "sprite_merge=(ind1,ind2)\n"
		+ "sprite_add=(fname:string,imgnumb:int,removeback:bool,smooth:bool,xorig:number,yorig:number)!:\n"
		+ "sprite_add_ext=(fname,imgnumb,xorig,yorig,prefetch)!\n"
		+ "sprite_replace=(ind,fname,imgnumb,removeback,smooth,xorig,yorig)!\n"
		+ "sprite_create_from_surface=(:index,x:number,y:number,w:number,h:number,removeback:bool,smooth:bool,xorig:number,yorig:number)!:\n"
		+ "sprite_add_from_surface=(ind:index,id:index,x:number,y:number,w:number,h:number,removeback:bool,smooth:bool)!:\n"
		+ "sprite_delete=(ind)!\n"
		+ "sprite_set_alpha_from_sprite=(ind,spr)\n"
		+ "sprite_collision_mask=(ind,sepmasks,bboxmode,bbleft,bbtop,bbright,bbbottom,kind,tolerance)\n"
		+ "font_add_enable_aa=(enable)\n"
		+ "font_add_get_enable_aa=():\n"
		+ "font_add=(:string,:number,:bool,:bool,:int,:int)!:\n"
		+ "font_add_sprite=(spr:index,first:int,prop:bool,sep:number)!:\n"
		+ "font_add_sprite_ext=(spr:index,:string,:bool,:number)!:\n"
		+ "font_replace_sprite=(ind,spr,first,prop,sep)!\n"
		+ "font_replace_sprite_ext=(font,spr,string_map,prop,sep)!\n"
		+ "font_delete=(ind)!\n"
		+ "font_enable_sdf=(ind,enable)!\n"
		+ "font_get_sdf_enabled=(ind)!:\n"
		+ "font_sdf_spread=(ind,spread)!\n"
		+ "font_get_sdf_spread=(ind)!:\n"
		+ "font_enable_effects=(ind,enable, [params])!\n"
		+ "path_set_kind=(ind,kind)\n"
		+ "path_set_closed=(ind,closed)\n"
		+ "path_set_precision=(ind,prec)\n"
		+ "path_add=()!:\n"
		+ "path_assign=(ind,path)\n"
		+ "path_duplicate=(:index)!:\n"
		+ "path_append=(ind,path)\n"
		+ "path_delete=(ind)\n"
		+ "path_add_point=(ind,x,y,speed)\n"
		+ "path_insert_point=(ind,n,x,y,speed)\n"
		+ "path_change_point=(ind,n,x,y,speed)\n"
		+ "path_delete_point=(ind,n)!\n"
		+ "path_clear_points=(ind)\n"
		+ "path_reverse=(ind)\n"
		+ "path_mirror=(ind)\n"
		+ "path_flip=(ind)\n"
		+ "path_rotate=(ind,angle)\n"
		+ "path_rescale=(ind,xscale,yscale)\n"
		+ "path_shift=(ind,xshift,yshift)\n"
		+ "object_set_sprite=(ind,spr)\n"
		+ "object_set_solid=(ind,solid)\n"
		+ "object_set_visible=(ind,vis)\n"
		+ "object_set_persistent=(ind,pers)\n"
		+ "object_set_mask=(ind,spr)\n"
		+ "room_set_width=(ind,w)\n"
		+ "room_set_height=(ind,h)\n"
		+ "room_set_persistent=(ind,pers)\n"
		+ "room_set_viewport=(ind,vind,vis,xport,yport,wport,hport)\n"
		+ "room_get_viewport=(ind,vind):\n"
		+ "room_set_view_enabled=(ind,val)\n"
		+ "room_add=()!:\n"
		+ "room_duplicate=(:index)!:\n"
		+ "room_assign=(ind,source)\n"
		+ "room_instance_add=(:index,:number,:number,:index):\n"
		+ "room_instance_clear=(ind)\n"
		+ "room_get_camera=(ind,vind):\n"
		+ "room_set_camera=(ind,vind,camera)\n"
		+ "asset_get_index=(name):\n"
		+ "asset_get_type=(name_or_ref):\n"
		+ "asset_get_ids=(asset_type):\n"
		+ "file_text_open_from_string=(:string):\n"
		+ "file_text_open_read=(fname):\n"
		+ "file_text_open_write=(:string):\n"
		+ "file_text_open_append=(:string):\n"
		+ "file_text_close=(file)\n"
		+ "file_text_write_string=(file,str)\n"
		+ "file_text_write_real=(file,val)\n"
		+ "file_text_writeln=(file)\n"
		+ "file_text_read_string=(file):\n"
		+ "file_text_read_real=(file):\n"
		+ "file_text_readln=(file):\n"
		+ "file_text_eof=(:index):\n"
		+ "file_text_eoln=(:index):\n"
		+ "file_exists=(fname):\n"
		+ "file_delete=(:string):bool\n"
		+ "file_rename=(:string, :string):bool\n"
		+ "file_copy=(fname,newname)\n"
		+ "directory_exists=(dname):\n"
		+ "directory_create=(dname):\n"
		+ "directory_destroy=(dname)\n"
		+ "file_find_first=(mask,attr):\n"
		+ "file_find_next=():\n"
		+ "file_find_close=():\n"
		+ "file_attributes=(:string,:int):\n"
		+ "filename_name=(:string):\n"
		+ "filename_path=(:string):\n"
		+ "filename_dir=(:string):\n"
		+ "filename_drive=(:string):\n"
		+ "filename_ext=(:string):\n"
		+ "filename_change_ext=(:string,:string):\n"
		+ "file_bin_open=(:string,mode):\n"
		+ "file_bin_rewrite=(file)\n"
		+ "file_bin_close=(file)\n"
		+ "file_bin_position=(:index):\n"
		+ "file_bin_size=(file):\n"
		+ "file_bin_seek=(file,pos)\n"
		+ "file_bin_write_byte=(file,byte)\n"
		+ "file_bin_read_byte=(file):\n"
		+ "parameter_count=():\n"
		+ "parameter_string=(:index):\n"
		+ "environment_get_variable=(name):\n"
		+ "ini_open_from_string=(content)\n"
		+ "ini_open=(fname)\n"
		+ "ini_close=():\n"
		+ "ini_read_string=(section,key,default):\n"
		+ "ini_read_real=(section,key,default):\n"
		+ "ini_write_string=(section,key,str)\n"
		+ "ini_write_real=(section,key,value)\n"
		+ "ini_key_exists=(section,key):\n"
		+ "ini_section_exists=(section):\n"
		+ "ini_key_delete=(section,key)\n"
		+ "ini_section_delete=(section)\n"
		+ "ds_set_precision=(prec)\n"
		+ "ds_exists=(id, type):\n"
		+ "ds_stack_create=():index\n"
		+ "ds_stack_destroy=(id)\n"
		+ "ds_stack_clear=(id)\n"
		+ "ds_stack_copy=(destination,source)\n"
		+ "ds_stack_size=(id):\n"
		+ "ds_stack_empty=(:index):bool\n"
		+ "ds_stack_push=(id,value,...)\n"
		+ "ds_stack_pop=(:index):\n"
		+ "ds_stack_top=(:index):\n"
		+ "ds_stack_write=(:index):\n"
		+ "ds_stack_read=(:index,:string,?legacy):\n"
		+ "ds_queue_create=():\n"
		+ "ds_queue_destroy=(id)\n"
		+ "ds_queue_clear=(id)\n"
		+ "ds_queue_copy=(destination,source)\n"
		+ "ds_queue_size=(id):\n"
		+ "ds_queue_empty=(:index):\n"
		+ "ds_queue_enqueue=(id,value,...)\n"
		+ "ds_queue_dequeue=(:index):\n"
		+ "ds_queue_head=(:index):\n"
		+ "ds_queue_tail=(:index):\n"
		+ "ds_queue_write=(:index):\n"
		+ "ds_queue_read=(:index,:string,?legacy):\n"
		+ "ds_list_create=():id\n"
		+ "ds_list_destroy=(:id)\n"
		+ "ds_list_clear=(:id)\n"
		+ "ds_list_copy=(:id,source:id)\n"
		+ "ds_list_size=(:id):int\n"
		+ "ds_list_empty=(:id):bool\n"
		+ "ds_list_add=(:id,...:any)\n"
		+ "ds_list_insert=(:id,pos:int,value:any)\n"
		+ "ds_list_replace=(:id,pos:int,value:any)\n"
		+ "ds_list_delete=(:id,pos:int)\n"
		+ "ds_list_find_index=(:id,value:any):int\n"
		+ "ds_list_find_value=(:id,pos:int):any\n"
		+ "ds_list_is_map=(id,pos):\n"
		+ "ds_list_is_list=(id,pos):\n"
		+ "ds_list_mark_as_list=(:index, :index)\n"
		+ "ds_list_mark_as_map=(:index, :index)\n"
		+ "ds_list_sort=(:id,ascending:bool)\n"
		+ "ds_list_shuffle=(:id)\n"
		+ "ds_list_write=(:id):string\n"
		+ "ds_list_read=(:id,:string,?legacy:bool):\n"
		+ "ds_list_set=(:id,pos:int,value:any)\n"
		+ "ds_map_create=():index\n"
		+ "ds_map_destroy=(:index)\n"
		+ "ds_map_clear=(:index)\n"
		+ "ds_map_copy=(:index,:index)\n"
		+ "ds_map_size=(:index):int\n"
		+ "ds_map_empty=(:index):bool\n"
		+ "ds_map_add=(:index,:any,:any)\n"
		+ "ds_map_add_list=(:index,:any,value)\n"
		+ "ds_map_add_map=(:index,:any,value)\n"
		+ "ds_map_replace=(:index,:any,value)\n"
		+ "ds_map_replace_map=(:index,:any,value)\n"
		+ "ds_map_replace_list=(:index,:any,value)\n"
		+ "ds_map_delete=(:index,:any)\n"
		+ "ds_map_exists=(:index,:any):bool\n"
		+ "ds_map_values_to_array=(id,?$1,...)\n"
		+ "ds_map_keys_to_array=(id,?$1,...)\n"
		+ "ds_map_find_value=(:index,:any):any\n"
		+ "ds_map_is_map=(id,key):\n"
		+ "ds_map_is_list=(id,key):\n"
		+ "ds_map_find_previous=(:index,:any):any\n"
		+ "ds_map_find_next=(:index,:any):any\n"
		+ "ds_map_find_first=(:index):any\n"
		+ "ds_map_find_last=(:index):any\n"
		+ "ds_map_write=(:index):string\n"
		+ "ds_map_read=(:index,:string,?legacy:bool):\n"
		+ "ds_map_secure_save=(:index, path:string)\n"
		+ "ds_map_secure_load=(path:string):index\n"
		+ "ds_map_secure_load_buffer=(:id):index\n"
		+ "ds_map_secure_save_buffer=(:index,:id)\n"
		+ "ds_map_set=(:index,:any,:any)\n"
		+ "ds_priority_create=():\n"
		+ "ds_priority_destroy=(id)\n"
		+ "ds_priority_clear=(id)\n"
		+ "ds_priority_copy=(destination,source)\n"
		+ "ds_priority_size=(id):\n"
		+ "ds_priority_empty=(:index):\n"
		+ "ds_priority_add=(id,value,priority)\n"
		+ "ds_priority_change_priority=(id,value,priority)\n"
		+ "ds_priority_find_priority=(id,value):\n"
		+ "ds_priority_delete_value=(id,value)\n"
		+ "ds_priority_delete_min=(:index):\n"
		+ "ds_priority_find_min=(:index):\n"
		+ "ds_priority_delete_max=(:index):\n"
		+ "ds_priority_find_max=(:index):\n"
		+ "ds_priority_write=(:index):\n"
		+ "ds_priority_read=(:index,:string,?legacy):\n"
		+ "ds_grid_create=(w,h):\n"
		+ "ds_grid_destroy=(id)\n"
		+ "ds_grid_copy=(destination,source)\n"
		+ "ds_grid_resize=(id,w,h)\n"
		+ "ds_grid_width=(:index):\n"
		+ "ds_grid_height=(:index):\n"
		+ "ds_grid_clear=(id,val)\n"
		+ "ds_grid_add=(id,x,y,val)\n"
		+ "ds_grid_multiply=(id,x,y,val)\n"
		+ "ds_grid_set_region=(id,x1,y1,x2,y2,val)\n"
		+ "ds_grid_add_region=(id,x1,y1,x2,y2,val)\n"
		+ "ds_grid_multiply_region=(id,x1,y1,x2,y2,val)\n"
		+ "ds_grid_set_disk=(id,xm,ym,r,val)\n"
		+ "ds_grid_add_disk=(id,xm,ym,r,val)\n"
		+ "ds_grid_multiply_disk=(id,xm,ym,r,val)\n"
		+ "ds_grid_set_grid_region=(id,source,x1,y1,x2,y2,xpos,ypos)\n"
		+ "ds_grid_add_grid_region=(id,source,x1,y1,x2,y2,xpos,ypos)\n"
		+ "ds_grid_multiply_grid_region=(id,source,x1,y1,x2,y2,xpos,ypos)\n"
		+ "ds_grid_get_sum=(id,x1,y1,x2,y2):\n"
		+ "ds_grid_get_max=(id,x1,y1,x2,y2):\n"
		+ "ds_grid_get_min=(id,x1,y1,x2,y2):\n"
		+ "ds_grid_get_mean=(id,x1,y1,x2,y2):\n"
		+ "ds_grid_get_disk_sum=(id,xm,ym,r):\n"
		+ "ds_grid_get_disk_min=(id,xm,ym,r):\n"
		+ "ds_grid_get_disk_max=(id,xm,ym,r):\n"
		+ "ds_grid_get_disk_mean=(id,xm,ym,r):\n"
		+ "ds_grid_value_exists=(id,x1,y1,x2,y2,val):\n"
		+ "ds_grid_value_x=(:index,x1:number,y1:number,x2:number,y2:number,val):\n"
		+ "ds_grid_value_y=(:index,x1:number,y1:number,x2:number,y2:number,val):\n"
		+ "ds_grid_value_disk_exists=(id,xm,ym,r,val):\n"
		+ "ds_grid_value_disk_x=(:index,xm:number,ym:number,r:number,val):\n"
		+ "ds_grid_value_disk_y=(:index,xm:number,ym:number,r:number,val):\n"
		+ "ds_grid_shuffle=(id)\n"
		+ "ds_grid_write=(:index):\n"
		+ "ds_grid_read=(:index,:string,?legacy):\n"
		+ "ds_grid_sort=(id,column,ascending)\n"
		+ "ds_grid_set=(id,x,y,value)\n"
		+ "ds_grid_get=(id,x,y):\n"
		+ "ds_grid_to_mp_grid=(src,dest,[func])\n"
		+ "effect_create_below=(kind,x,y,size,col):\n"
		+ "effect_create_above=(kind,x,y,size,col):\n"
		+ "effect_create_layer=(layer_id_or_name,kind,x,y,size,col):\n"
		+ "effect_create_depth=(depth,kind,x,y,size,col):\n"
		+ "effect_clear=()\n"
		+ "part_type_create=():\n"
		+ "part_type_destroy=(ind)\n"
		+ "part_type_exists=(ind):\n"
		+ "part_type_clear=(ind)\n"
		+ "part_type_shape=(ind,shape)\n"
		+ "part_type_sprite=(ind,sprite,animat,stretch,random)\n"
		+ "part_type_subimage=(ind,subimg)\n"
		+ "part_type_size=(ind,size_min,size_max,size_incr,size_wiggle):\n"
		+ "part_type_size_x=(ind,size_min_x,size_max_x,size_incr_x,size_wiggle_y):\n"
		+ "part_type_size_y=(ind,size_min_y,size_max_y,size_incr_y,size_wiggle_y):\n"
		+ "part_type_scale=(ind,xscale,yscale)\n"
		+ "part_type_orientation=(ind,ang_min,ang_max,ang_incr,ang_wiggle,ang_relative)\n"
		+ "part_type_life=(ind,life_min,life_max)\n"
		+ "part_type_step=(ind,step_number,step_type)\n"
		+ "part_type_death=(ind,death_number,death_type)\n"
		+ "part_type_speed=(ind,speed_min,speed_max,speed_incr,speed_wiggle)\n"
		+ "part_type_direction=(ind,dir_min,dir_max,dir_incr,dir_wiggle)\n"
		+ "part_type_gravity=(ind,grav_amount,grav_dir)\n"
		+ "part_type_colour1=(ind,colour1)£\n"
		+ "part_type_colour2=(ind,colour1,colour2)£\n"
		+ "part_type_colour3=(ind,colour1,colour2,colour3)£\n"
		+ "part_type_colour_mix=(ind,colour1,colour2)£\n"
		+ "part_type_colour_rgb=(ind,rmin,rmax,gmin,gmax,bmin,bmax)£\n"
		+ "part_type_colour_hsv=(ind,hmin,hmax,smin,smax,vmin,vmax)£\n"
		+ "part_type_color1=(ind,color1)$\n"
		+ "part_type_color2=(ind,color1,color2)$\n"
		+ "part_type_color3=(ind,color1,color2,color3)$\n"
		+ "part_type_color_mix=(ind,color1,color2)$\n"
		+ "part_type_color_rgb=(ind,rmin,rmax,gmin,gmax,bmin,bmax)$\n"
		+ "part_type_color_hsv=(ind,hmin,hmax,smin,smax,vmin,vmax)$\n"
		+ "part_type_alpha1=(ind,alpha1)\n"
		+ "part_type_alpha2=(ind,alpha1,alpha2)\n"
		+ "part_type_alpha3=(ind,alpha1,alpha2,alpha3)\n"
		+ "part_type_blend=(ind,additive)\n"
		+ "particle_add=(info)\n"
		+ "particle_delete=(ind)\n"
		+ "particle_exists=(ind):\n"
		+ "particle_get_info=(ind):\n"
		+ "part_system_create=([partsys]):\n"
		+ "part_system_create_layer=(layer,persistent,[partsys]):\n"
		+ "part_system_destroy=(ind)\n"
		+ "part_system_exists=(ind):\n"
		+ "part_system_clear=(ind)\n"
		+ "part_system_draw_order=(ind,oldtonew)\n"
		+ "part_system_depth=(ind,depth)\n"
		+ "part_system_color=(ind,color,alpha)$\n"
		+ "part_system_colour=(ind,colour,alpha)£\n"
		+ "part_system_position=(ind,x,y)\n"
		+ "part_system_angle=(ind,angle)\n"
		+ "part_system_automatic_update=(ind,automatic)\n"
		+ "part_system_automatic_draw=(ind,draw)\n"
		+ "part_system_update=(ind)\n"
		+ "part_system_drawit=(ind)\n"
		+ "part_system_get_layer=(ind):\n"
		+ "part_system_layer=(ind,layer)\n"
		+ "part_system_global_space=(ind,enable)\n"
		+ "part_system_get_info=(ind):\n"
		+ "part_particles_create=(ind,x,y,parttype,number):\n"
		+ "part_particles_create_colour=(ind,x,y,parttype,colour,number)£:\n"
		+ "part_particles_create_color=(ind,x,y,parttype,color,number)$:\n"
		+ "part_particles_burst=(ind,x,y,partsys)\n"
		+ "part_particles_clear=(ind)\n"
		+ "part_particles_count=(ind)\n"
		+ "part_emitter_create=(ps):\n"
		+ "part_emitter_destroy=(ps,ind)\n"
		+ "part_emitter_destroy_all=(ps)\n"
		+ "part_emitter_enable=(ps,ind,enable)\n"
		+ "part_emitter_exists=(ps,ind):\n"
		+ "part_emitter_clear=(ps,ind)\n"
		+ "part_emitter_region=(ps,ind,xmin,xmax,ymin,ymax,shape,distribution)\n"
		+ "part_emitter_burst=(ps,ind,parttype,number)\n"
		+ "part_emitter_stream=(ps,ind,parttype,number)\n"
		+ "part_emitter_delay=(ps,ind,delay_min,delay_max,delay_unit)\n"
		+ "part_emitter_interval=(ps,ind,interval_min,interval_max,inerval_unit)\n"
		+ "part_emitter_relative=(ps,ind,enable)\n"
		+ "window_handle=():\n"
		+ "window_device=():\n"
		+ "window_post_message=(message)\n"
		+ "matrix_get=(type,[result_matrix]):\n"
		+ "matrix_set=(type,matrix)\n"
		+ "matrix_build_identity=():\n"
		+ "matrix_build=(x,y,z,xrotation,yrotation,zrotation,xscale,yscale,zscale,[result_matrix]):\n"
		+ "matrix_build_lookat=(xfrom,yfrom,zfrom,xto,yto,zto,xup,yup,zup,[result_matrix]):\n"
		+ "matrix_build_projection_ortho=(width,height,znear,zfar,[result_matrix]):\n"
		+ "matrix_build_projection_perspective=(width,height,znear,zfar,[result_matrix]):\n"
		+ "matrix_build_projection_perspective_fov=(fov_y,aspect,znear,zfar,[result_matrix]):\n"
		+ "matrix_multiply=(a, b):\n"
		+ "matrix_transform_vertex=(matrix, x, y, z):\n"
		+ "matrix_inverse=(matrix,[result_matrix])\n"
		+ "matrix_stack_push=(...)\n"
		+ "matrix_stack_pop=():\n"
		+ "matrix_stack_set=(matrix)\n"
		+ "matrix_stack_clear=()\n"
		+ "matrix_stack_top=():\n"
		+ "matrix_stack_is_empty=():\n"
		+ "browser_input_capture=(enable)\n"
		+ "os_get_config=():\n"
		+ "os_get_info=():\n"
		+ "os_get_language=():\n"
		+ "os_get_region=():\n"
		+ "os_check_permission=(perm):\n"
		+ "os_request_permission=(perm):\n"
		+ "os_lock_orientation=(flag)\n"
		+ "os_set_orientation_lock=(landscape_enable,portrait_enable)\n"
		+ "display_get_dpi_x=():\n"
		+ "display_get_dpi_y=():\n"
		+ "display_set_gui_size=(width,height)\n"
		+ "display_set_gui_maximise=(xscale,yscale,xoffset,yoffset,...)£\n"
		+ "display_set_gui_maximize=(xscale,yscale,xoffset,yoffset,...)$\n"
		+ "device_mouse_dbclick_enable=(enable)\n"
		+ "mac_refresh_receipt_validation=()\n"
		+ "display_set_timing_method=(method)\n"
		+ "display_get_timing_method=():\n"
		+ "display_set_sleep_margin=(milliseconds)\n"
		+ "display_get_sleep_margin=():\n"
		+ "virtual_key_add=(x,y,w,h,keycode)\n"
		+ "virtual_key_hide=(id)\n"
		+ "virtual_key_delete=(id)\n"
		+ "virtual_key_show=(id)\n"
		+ "draw_enable_drawevent=(enable)\n"
		+ "draw_enable_svg_aa=(enable)!\n"
		+ "draw_set_svg_aa_level=(aa_level)!\n"
		+ "draw_get_svg_aa_level=()!:\n"
		+ "vector_sprite_cache_limit=(limit)!\n"
		+ "vector_sprite_cache_prune_fraction=(fraction)!\n"
		+ "vector_sprite_cache_prune_age=(frames)!\n"
		+ "vector_sprite_cache_get_limit=()!:\n"
		+ "vector_sprite_cache_get_prune_fraction=()!:\n"
		+ "vector_sprite_cache_get_prune_age=()!:\n"
		+ "vector_sprite_cache_get_used=()!:\n"
		+ "vector_sprite_cache_get_max_used=()!:\n"
		+ "vector_sprite_cache_get_oldest_entry_age=()!:\n"
		+ "draw_texture_flush=()\n"
		+ "draw_flush=()\n"
		+ "gpu_set_stencil_depth_fail=(stencil_op)\n"
		+ "gpu_set_stencil_enable=(enable)\n"
		+ "gpu_set_stencil_fail=(stencil_op)\n"
		+ "gpu_set_stencil_func=(cmp_func)\n"
		+ "gpu_set_stencil_pass=(stencil_op)\n"
		+ "gpu_set_stencil_read_mask=(mask)\n"
		+ "gpu_set_stencil_ref=(ref)\n"
		+ "gpu_set_stencil_write_mask=(mask)\n"
		+ "gpu_set_sprite_cull=(enable)\n"
		+ "gpu_set_blendenable=(enable)\n"
		+ "gpu_set_ztestenable=(enable)\n"
		+ "gpu_set_zfunc=(cmp_func)\n"
		+ "gpu_set_zwriteenable=(enable)\n"
		+ "gpu_set_depth=(depth)\n"
		+ "gpu_set_fog=(data_or_enable,?color,?start,?end)\n"
		+ "gpu_set_cullmode=(cullmode)\n"
		+ "gpu_set_blendmode=(mode)\n"
		+ "gpu_set_blendmode_ext=(src,dest)\n"
		+ "gpu_set_blendmode_ext_sepalpha=(src,dest,srcalpha,destalpha)\n"
		+ "gpu_set_blendequation=(equation)\n"
		+ "gpu_set_blendequation_sepalpha=(equation, equation_alpha)\n"
		+ "gpu_set_colorwriteenable=(red_or_array,?$1,?$1,?$1,...)$\n"
		+ "gpu_set_colourwriteenable=(red_or_arry,?$1,?$1,?$1,...)£\n"
		+ "gpu_set_alphatestenable=(enable)\n"
		+ "gpu_set_alphatestref=(value)\n"
		+ "gpu_set_texfilter=(linear)\n"
		+ "gpu_set_texfilter_ext=(sampler_id,linear)\n"
		+ "gpu_set_texrepeat=(repeat)\n"
		+ "gpu_set_texrepeat_ext=(sampler_id,repeat)\n"
		+ "gpu_set_tex_filter=(linear)\n"
		+ "gpu_set_tex_filter_ext=(sampler_id,linear)\n"
		+ "gpu_set_tex_repeat=(repeat)\n"
		+ "gpu_set_tex_repeat_ext=(sampler_id,repeat)\n"
		+ "gpu_set_tex_mip_filter=(filter)\n"
		+ "gpu_set_tex_mip_filter_ext=(sampler_id,filter)\n"
		+ "gpu_set_tex_mip_bias=(bias)\n"
		+ "gpu_set_tex_mip_bias_ext=(sampler_id,bias)\n"
		+ "gpu_set_tex_min_mip=(minmip)\n"
		+ "gpu_set_tex_min_mip_ext=(sampler_id,minmip)\n"
		+ "gpu_set_tex_max_mip=(maxmip)\n"
		+ "gpu_set_tex_max_mip_ext=(sampler_id,maxmip)\n"
		+ "gpu_set_tex_max_aniso=(maxaniso)\n"
		+ "gpu_set_tex_max_aniso_ext=(sampler_id,maxaniso)\n"
		+ "gpu_set_tex_mip_enable=(setting)\n"
		+ "gpu_set_tex_mip_enable_ext=(sampler_id,setting)\n"
		+ "gpu_get_stencil_enable=():\n"
		+ "gpu_get_stencil_func=():\n"
		+ "gpu_get_stencil_ref=():\n"
		+ "gpu_get_stencil_read_mask=():\n"
		+ "gpu_get_stencil_write_mask=():\n"
		+ "gpu_get_stencil_fail=():\n"
		+ "gpu_get_stencil_depth_fail=():\n"
		+ "gpu_get_stencil_pass=():\n"
		+ "gpu_get_sprite_cull=():\n"
		+ "gpu_get_blendenable=():\n"
		+ "gpu_get_ztestenable=():\n"
		+ "gpu_get_zfunc=():\n"
		+ "gpu_get_zwriteenable=():\n"
		+ "gpu_get_depth=():\n"
		+ "gpu_get_fog=():\n"
		+ "gpu_get_cullmode=():\n"
		+ "gpu_get_blendmode=():\n"
		+ "gpu_get_blendmode_ext=():\n"
		+ "gpu_get_blendmode_ext_sepalpha=():\n"
		+ "gpu_get_blendmode_src=():\n"
		+ "gpu_get_blendmode_dest=():\n"
		+ "gpu_get_blendmode_srcalpha=():\n"
		+ "gpu_get_blendmode_destalpha=():\n"
		+ "gpu_get_blendequation=():\n"
		+ "gpu_get_blendequation_sepalpha=():\n"
		+ "gpu_get_colorwriteenable=()$:\n"
		+ "gpu_get_colourwriteenable=()£:\n"
		+ "gpu_get_alphatestenable=():\n"
		+ "gpu_get_alphatestref=():\n"
		+ "gpu_get_texfilter=():\n"
		+ "gpu_get_texfilter_ext=(sampler_id):\n"
		+ "gpu_get_texrepeat=():\n"
		+ "gpu_get_texrepeat_ext=(sampler_id):\n"
		+ "gpu_get_tex_filter=():\n"
		+ "gpu_get_tex_filter_ext=(sampler_id):\n"
		+ "gpu_get_tex_repeat=():\n"
		+ "gpu_get_tex_repeat_ext=(sampler_id):\n"
		+ "gpu_get_tex_mip_filter=():\n"
		+ "gpu_get_tex_mip_filter_ext=(sampler_id):\n"
		+ "gpu_get_tex_mip_bias=():\n"
		+ "gpu_get_tex_mip_bias_ext=(sampler_id):\n"
		+ "gpu_get_tex_min_mip=():\n"
		+ "gpu_get_tex_min_mip_ext=(sampler_id):\n"
		+ "gpu_get_tex_max_mip=():\n"
		+ "gpu_get_tex_max_mip_ext=(sampler_id):\n"
		+ "gpu_get_tex_max_aniso=():\n"
		+ "gpu_get_tex_max_aniso_ext=(sampler_id):\n"
		+ "gpu_get_tex_mip_enable=():\n"
		+ "gpu_get_tex_mip_enable_ext=(sampler_id):\n"
		+ "gpu_push_state=()\n"
		+ "gpu_pop_state=()\n"
		+ "gpu_get_state=():\n"
		+ "gpu_set_state=(map)\n"
		+ "gpu_get_scissor=():\n"
		+ "gpu_set_scissor=(xOrStruct, [y], [w], [h])\n"
		+ "draw_light_define_ambient=(col)\n"
		+ "draw_light_define_direction=(ind,dx,dy,dz,col)\n"
		+ "draw_light_define_point=(ind,x,y,z,range,col)\n"
		+ "draw_light_enable=(ind,enable)\n"
		+ "draw_set_lighting=(enable)\n"
		+ "draw_light_get_ambient=():\n"
		+ "draw_light_get=(ind):\n"
		+ "draw_get_lighting=():\n"
		+ "shop_leave_rating=(text_string,yes_string,no_string,url)\n"
		+ "url_get_domain=():\n"
		+ "url_open=(url)\n"
		+ "url_open_ext=(url,target)\n"
		+ "url_open_full=(url,target,options)\n"
		+ "get_timer=():number\n"
		+ "device_get_tilt_x=():\n"
		+ "device_get_tilt_y=():\n"
		+ "device_get_tilt_z=():\n"
		+ "device_is_keypad_open=():\n"
		+ "device_mouse_check_button=(:index,:index):\n"
		+ "device_mouse_check_button_pressed=(:index,:index):\n"
		+ "device_mouse_check_button_released=(:index,:index):\n"
		+ "device_mouse_x=(:index):\n"
		+ "device_mouse_y=(:index):\n"
		+ "device_mouse_raw_x=(:index):\n"
		+ "device_mouse_raw_y=(:index):\n"
		+ "device_mouse_x_to_gui=(:index):\n"
		+ "device_mouse_y_to_gui=(:index):\n"
		+ "gamepad_is_supported=():\n"
		+ "gamepad_get_device_count=():\n"
		+ "gamepad_is_connected=(device):\n"
		+ "gamepad_get_description=(device):\n"
		+ "gamepad_get_button_threshold=(device):\n"
		+ "gamepad_set_button_threshold=(device, threshold)\n"
		+ "gamepad_get_axis_deadzone=(device):\n"
		+ "gamepad_set_axis_deadzone=(device, deadzone)\n"
		+ "gamepad_button_count=(device:index):\n"
		+ "gamepad_button_check=(device:index, buttonIndex:index):\n"
		+ "gamepad_button_check_pressed=(device:index, buttonIndex:index):\n"
		+ "gamepad_button_check_released=(device:index, buttonIndex:index):\n"
		+ "gamepad_button_value=(device:index, buttonIndex:index):\n"
		+ "gamepad_axis_count=(axis:index):\n"
		+ "gamepad_axis_value=(device:index, axisIndex:index):\n"
		+ "gamepad_set_vibration=(device, leftMotorSpeed, rightMotorSpeed)\n"
		+ "gamepad_set_colour=(index,colour)£\n"
		+ "gamepad_set_color=(index,color)$\n"
		+ "gamepad_hat_count=(axis)\n"
		+ "gamepad_hat_value=(device, axisIndex)\n"
		+ "gamepad_remove_mapping=(device)\n"
		+ "gamepad_test_mapping=(device, mapping_string)\n"
		+ "gamepad_get_mapping=(device):\n"
		+ "gamepad_get_guid=(device):\n"
		+ "gamepad_set_option=(gamepad_id, option_key, option_value)\n"
		+ "gamepad_get_option=(gamepad_id, option_key):\n"
		+ "gamepad_enumerate=()\n"
		+ "os_is_paused=():\n"
		+ "window_has_focus=():\n"
		+ "code_is_compiled=():\n"
		+ "http_get=(url):\n"
		+ "http_get_file=(url, dest):\n"
		+ "http_post_string=(:string,:string):\n"
		+ "http_request=(url:string, method, header_map, body):\n"
		+ "http_get_request_crossorigin=():\n"
		+ "http_set_request_crossorigin=(crossorigin_type)\n"
		+ "http_get_connect_timeout=():\n"
		+ "http_set_connect_timeout=(connect_timeout_ms)\n"
		+ "json_encode=(:id):string\n"
		+ "json_decode=(:string):id\n"
		+ "json_stringify=(val, [prettify], [filter_func])\n"
		+ "json_parse=(json, [filter_func], [inhibit_string_convert])\n"
		+ "zip_unzip=(zip:string, path:string):int\n"
		+ "zip_unzip_async=(file, destPath)\n"
		+ "zip_create=():\n"
		+ "zip_add_file=(zip_object, dest, src)\n"
		+ "zip_save=(zip_object, path)\n"
		+ "load_csv=(:string):array2d\n"
		+ "base64_encode=(:string):string\n"
		+ "base64_decode=(:string):string\n"
		+ "md5_string_unicode=(:string):string\n"
		+ "md5_string_utf8=(:string):string\n"
		+ "md5_file=(:string):string\n"
		+ "os_is_network_connected=(attempt_connection,...):\n"
		+ "sha1_string_unicode=(:string):string\n"
		+ "sha1_string_utf8=(:string):string\n"
		+ "sha1_file=(:string):string\n"
		+ "os_powersave_enable=(enable)\n"
		+ "physics_world_create=(PixelToMetreScale):\n"
		+ "physics_world_gravity=(gx, gy)\n"
		+ "physics_world_update_speed=(speed)\n"
		+ "physics_world_update_iterations=(iterations)\n"
		+ "physics_world_draw_debug=(draw_flags)\n"
		+ "physics_raycast=(xStart,yStart,xEnd,yEnd,ids,[all_hits],[max_fraction],...)\n"
		+ "physics_debug=(enable)\n"
		+ "physics_pause_enable=(pause)\n"
		+ "physics_fixture_create=():\n"
		+ "physics_fixture_set_kinematic=(fixture)\n"
		+ "physics_fixture_set_density=(fixture, density)\n"
		+ "physics_fixture_set_awake=(fixture, flag)\n"
		+ "physics_fixture_set_restitution=(fixture, restitution)\n"
		+ "physics_fixture_set_friction=(fixture,friction)\n"
		+ "physics_fixture_set_collision_group=(fixture, group)\n"
		+ "physics_fixture_set_sensor=(fixture, sensorState)\n"
		+ "physics_fixture_set_linear_damping=(fixture, damping)\n"
		+ "physics_fixture_set_angular_damping=(fixture, damping)\n"
		+ "physics_fixture_set_circle_shape=(fixture, circleRadius)\n"
		+ "physics_fixture_set_box_shape=(fixture, halfWidth, halfHeight)\n"
		+ "physics_fixture_set_edge_shape=(fixture, x1,y1,x2,y2)\n"
		+ "physics_fixture_set_polygon_shape=(fixture)\n"
		+ "physics_fixture_set_chain_shape=(fixture, loop)\n"
		+ "physics_fixture_add_point=(fixture, local_x, local_y)\n"
		+ "physics_fixture_bind=:(fixture, target):\n"
		+ "physics_fixture_bind_ext=:(fixture, target, xoffset, yoffset):\n"
		+ "physics_fixture_delete=(fixture)\n"
		+ "physics_apply_force=:(xpos, ypos, xforce, yforce)\n"
		+ "physics_apply_impulse=:(xpos, ypos, ximpulse, yimpulse)\n"
		+ "physics_apply_angular_impulse=:(impulse)\n"
		+ "physics_apply_local_force=:(xlocal, ylocal, xforce_local, yforce_local)\n"
		+ "physics_apply_local_impulse=:(xlocal, ylocal, ximpulse_local, yimpulse_local)\n"
		+ "physics_apply_torque=:(torque)\n"
		+ "physics_mass_properties=:(mass, local_centre_of_mass_x, local_centre_of_mass_y, inertia)\n"
		+ "physics_draw_debug=:()\n"
		+ "physics_test_overlap=:(x:number, y:number, angle:number, obj:index):\n"
		+ "physics_remove_fixture=(inst, id)\n"
		+ "physics_set_friction=:(fixture, friction)\n"
		+ "physics_set_density=:(fixture, density)\n"
		+ "physics_set_restitution=:(fixture, restitution)\n"
		+ "physics_get_friction=:(fixture):\n"
		+ "physics_get_density=:(fixture):\n"
		+ "physics_get_restitution=:(fixture):\n"
		+ "physics_joint_distance_create=(inst1, inst2, anchor_1_x, anchor_1_y, anchor_2_x, anchor_2_y, collideInstances):\n"
		+ "physics_joint_rope_create=(inst1, inst2, anchor_1_x, anchor_1_y, anchor_2_x, anchor_2_y, maxLength, collideInstances):\n"
		+ "physics_joint_revolute_create=(inst1, inst2, anchor_x, anchor_y, lower_angle_limit, upper_angle_limit, enable_limit, max_motor_torque, motor_speed, enable_motor, collideInstances):\n"
		+ "physics_joint_prismatic_create=(inst1, inst2, anchor_x, anchor_y, axis_x, axis_y, lower_translation_limit, upper_translation_limit, enable_limit, max_motor_force, motor_speed, enable_motor, collideInstances):\n"
		+ "physics_joint_pulley_create=(inst1, inst2, anchor_1_x, anchor_1_y, anchor_2_x, anchor_2_y, local_anchor_1_x, local_anchor_1_y, local_anchor_2_x, local_anchor_2_y, ratio, collideInstances):\n"
		+ "physics_joint_wheel_create=(inst1, inst2, anchor_x, anchor_y, axis_x, axis_y, enableMotor, max_motor_torque, motor_speed, freq_hz, damping_ratio, collideInstances):\n"
		+ "physics_joint_weld_create=(inst1, inst2, anchor_x, anchor_y, ref_angle, freq_hz, damping_ratio, collideInstances):\n"
		+ "physics_joint_friction_create=(inst1, inst2, anchor_x, anchor_y, max_force, max_torque, collideInstances):\n"
		+ "physics_joint_gear_create=(inst1, inst2, revoluteJoint, prismaticJoint, ratio):\n"
		+ "physics_joint_enable_motor=(joint, motorState)\n"
		+ "physics_joint_get_value=(joint, field):\n"
		+ "physics_joint_set_value=(joint, field, value)\n"
		+ "physics_joint_delete=(joint)\n"
		+ "physics_particle_create=(typeflags, x, y, xv, yv, col, alpha, category):\n"
		+ "physics_particle_delete=(ind)\n"
		+ "physics_particle_delete_region_circle=(x, y, radius)\n"
		+ "physics_particle_delete_region_box=(x, y, halfWidth, halfHeight)\n"
		+ "physics_particle_delete_region_poly=(pointList)\n"
		+ "physics_particle_set_flags=(ind, typeflags)\n"
		+ "physics_particle_set_category_flags=(category, typeflags)\n"
		+ "physics_particle_draw=(typemask, category, sprite, subimg)\n"
		+ "physics_particle_draw_ext=(typemask, category, sprite, subimg, xscale, yscale, angle, col, alpha)\n"
		+ "physics_particle_count=():\n"
		+ "physics_particle_get_data=(buffer, dataFlags):\n"
		+ "physics_particle_get_data_particle=(ind, buffer, dataFlags):\n"
		+ "physics_particle_group_begin=(typeflags, groupflags, x, y, ang, xv, yv, angVelocity, col, alpha, strength, category)\n"
		+ "physics_particle_group_circle=(radius)\n"
		+ "physics_particle_group_box=(halfWidth, halfHeight)\n"
		+ "physics_particle_group_polygon=()\n"
		+ "physics_particle_group_add_point=(x, y)\n"
		+ "physics_particle_group_end=():\n"
		+ "physics_particle_group_join=(to, from)\n"
		+ "physics_particle_group_delete=(ind)\n"
		+ "physics_particle_group_count=(group)\n"
		+ "physics_particle_group_get_data=(group, buffer, dataFlags):\n"
		+ "physics_particle_group_get_mass=(group):\n"
		+ "physics_particle_group_get_inertia=(group):\n"
		+ "physics_particle_group_get_centre_x=(group):\n"
		+ "physics_particle_group_get_centre_y=(group):\n"
		+ "physics_particle_group_get_vel_x=(group):\n"
		+ "physics_particle_group_get_vel_y=(group):\n"
		+ "physics_particle_group_get_ang_vel=(group):\n"
		+ "physics_particle_group_get_x=(group):\n"
		+ "physics_particle_group_get_y=(group):\n"
		+ "physics_particle_group_get_angle=(group):\n"
		+ "physics_particle_set_group_flags=(group, groupflags)\n"
		+ "physics_particle_get_group_flags=(group):\n"
		+ "physics_particle_get_max_count=():\n"
		+ "physics_particle_get_radius=():\n"
		+ "physics_particle_get_density=():\n"
		+ "physics_particle_get_damping=():\n"
		+ "physics_particle_get_gravity_scale=():\n"
		+ "physics_particle_set_max_count=(count)\n"
		+ "physics_particle_set_radius=(radius)\n"
		+ "physics_particle_set_density=(density)\n"
		+ "physics_particle_set_damping=(damping)\n"
		+ "physics_particle_set_gravity_scale=(scale)\n"
		+ "network_create_socket=(type:int):id\n"
		+ "network_create_socket_ext=(type:int, port:int):id\n"
		+ "network_create_server=(type:int, port:int, maxclients:int):id\n"
		+ "network_create_server_raw=(type:int, port:int, maxclients:int):id\n"
		+ "network_connect=(:id, url:string, port:int):int\n"
		+ "network_connect_raw=(:id, url:string, port:int):id\n"
		+ "network_connect_async=(:id, url:string, port:int):int\n"
		+ "network_connect_raw_async=(:id, url:string, port:int):int\n"
		+ "network_send_packet=(:id, :id, size:int):int\n"
		+ "network_send_raw=(:id, :id, size:int):int\n"
		+ "network_send_broadcast=(:id, port:int, :id, size:int):int\n"
		+ "network_send_udp=(:id, URL:string, port:int, data:id, size:int):int\n"
		+ "network_send_udp_raw=(:id, URL:string, port:int, data:id, size:int):int\n"
		+ "network_set_timeout=(:id, read:number, write:number)\n"
		+ "network_set_config=(parameter, value)\n"
		+ "network_resolve=(url:string):string\n"
		+ "network_destroy=(:id)\n"
		+ "buffer_create=(size:int, buffer_type:int, alignment:int):id\n"
		+ "buffer_write=(:id, type:int, value)\n"
		+ "buffer_read=(:id, type:int):\n"
		+ "buffer_seek=(:id, base:int, offset:int)\n"
		+ "buffer_get_surface=(:id, :id, offset:int):\n"
		+ "buffer_get_surface_depth=(buffer, surface,offset):\n"
		+ "buffer_set_surface=(:id, :id, offset:int)\n"
		+ "buffer_set_surface_depth=(buffer, surface,offset)\n"
		+ "buffer_get_used_size=(buffer):\n"
		+ "buffer_set_used_size=(buffer,size)\n"
		+ "buffer_delete=(:id)\n"
		+ "buffer_exists=(:id):bool\n"
		+ "buffer_get_type=(:id):int\n"
		+ "buffer_get_alignment=(:id):int\n"
		+ "buffer_poke=(:id, offset:int, type:int, value)\n"
		+ "buffer_peek=(:id, offset:int, type:int):\n"
		+ "buffer_save=(:id, filename:string)\n"
		+ "buffer_save_ext=(:id, filename:string, offset:int, size:int)\n"
		+ "buffer_load=(filename:string):id\n"
		+ "buffer_load_ext=(:id, filename:string, offset:int):\n"
		+ "buffer_load_partial=(:id, filename:string, src_offset:int, src_len:int, dest_offset:int):\n"
		+ "buffer_copy=(src_buffer, src_offset:int, size:int, dest:id, dest_offset:int)\n"
		+ "buffer_copy_stride=(src_buffer, src_offset, src_size, src_stride, src_count, dest_buffer, dest_offset, dest_stride)\n"
		+ "buffer_fill=(:id, offset:int, type:int, value, size:int)\n"
		+ "buffer_get_size=(:id):int\n"
		+ "buffer_tell=(:id):int\n"
		+ "buffer_resize=(:id, newsize:int)\n"
		+ "buffer_md5=(:id, offset:int, size:int):string\n"
		+ "buffer_sha1=(:id, offset:int, size:int):string\n"
		+ "buffer_crc32=(:id, offset:int, size:int):int\n"
		+ "buffer_base64_encode=(:id, offset:int, size:int):string\n"
		+ "buffer_base64_decode=(string):id\n"
		+ "buffer_base64_decode_ext=(:id, :string, offset:int)\n"
		+ "buffer_sizeof=(type:int):int\n"
		+ "buffer_get_address=(:id):\n"
		+ "buffer_create_from_vertex_buffer=(:id, type, alignment):\n"
		+ "buffer_create_from_vertex_buffer_ext=(:id, type, alignment, start_vertex, num_vertices):\n"
		+ "buffer_copy_from_vertex_buffer=(vertex_buffer, start_vertex, num_vertices, dest_buffer, dest_offset)\n"
		+ "buffer_async_group_begin=(groupname)\n"
		+ "buffer_async_group_option=(optionname,optionvalue)\n"
		+ "buffer_async_group_end=()\n"
		+ "buffer_load_async=(:id,filename:string,offset:int,size:int):\n"
		+ "buffer_save_async=(:id,filename:string,offset:int,size:int):\n"
		+ "buffer_compress=(:id, offset:int, size:int):id\n"
		+ "buffer_decompress=(:id):id\n"
		+ "gx_share=(buffer,[title],[text],[filename])\n"
		+ "gml_release_mode=(enable)\n"
		+ "shader_set=(shader)\n"
		+ "shader_get_name=(shader):\n"
		+ "shader_reset=()\n"
		+ "shader_current=():\n"
		+ "shader_is_compiled=(shader):\n"
		+ "shader_get_sampler_index=(shader,uniform_name):\n"
		+ "shader_get_uniform=(shader,uniform_name):\n"
		+ "shader_set_uniform_i=(uniform_id,val,....)\n"
		+ "shader_set_uniform_i_array=(uniform_id,array)\n"
		+ "shader_set_uniform_f=(uniform_id,val,....)\n"
		+ "shader_set_uniform_f_array=(uniform_id,array)\n"
		+ "shader_set_uniform_f_buffer=(uniform_id,buffer,offset,count)\n"
		+ "shader_set_uniform_matrix=(uniform_id)\n"
		+ "shader_set_uniform_matrix_array=(uniform_id,array)\n"
		+ "shader_enable_corner_id=(enable)\n"
		+ "texture_set_stage=(sampled_id, texture_id)\n"
		+ "texture_get_texel_width=(texture_id):\n"
		+ "texture_get_texel_height=(texture_id):\n"
		+ "shaders_are_supported=():\n"
		+ "vertex_format_begin=()\n"
		+ "vertex_format_end=():\n"
		+ "vertex_format_delete=(format_id)\n"
		+ "vertex_format_add_position=()\n"
		+ "vertex_format_add_position_3d=()\n"
		+ "vertex_format_add_colour=()£\n"
		+ "vertex_format_add_color=()$\n"
		+ "vertex_format_add_normal=()\n"
		+ "vertex_format_add_texcoord=()\n"
		+ "vertex_format_add_custom=(type,usage)\n"
		+ "vertex_format_get_info=(format_id):\n"
		+ "vertex_format_exists=(format_id):\n"
		+ "vertex_create_buffer=():\n"
		+ "vertex_create_buffer_ext=(size):\n"
		+ "vertex_delete_buffer=(vbuff)\n"
		+ "vertex_begin=(vbuff,format)\n"
		+ "vertex_end=(vbuff)\n"
		+ "vertex_position=(vbuff,x,y)\n"
		+ "vertex_position_3d=(vbuff,x,y,z)\n"
		+ "vertex_colour=(vbuff,colour,alpha)£\n"
		+ "vertex_color=(vbuff,color,alpha)$\n"
		+ "vertex_argb=(vbuff,argb)\n"
		+ "vertex_texcoord=(vbuff,u,v)\n"
		+ "vertex_normal=(vbuff,nx,ny,nz)\n"
		+ "vertex_float1=(vbuff,f1)\n"
		+ "vertex_float2=(vbuff,f1,f2)\n"
		+ "vertex_float3=(vbuff,f1,f2,f3)\n"
		+ "vertex_float4=(vbuff,f1,f2,f3,f4)\n"
		+ "vertex_ubyte4=(vbuff,b1,b2,b3,b4)\n"
		+ "vertex_submit=(vbuff,prim,texture)\n"
		+ "vertex_submit_ext=(vbuff,prim,texture,offset,num)\n"
		+ "vertex_freeze=(vbuff)\n"
		+ "vertex_get_number=(vbuff):\n"
		+ "vertex_get_buffer_size=(vbuff):\n"
		+ "vertex_create_buffer_from_buffer=(src_buffer,format):\n"
		+ "vertex_create_buffer_from_buffer_ext=(src_buffer,format,src_offset,num_vertices):\n"
		+ "vertex_update_buffer_from_buffer=(dest_vbuff,dest_offset,src_buffer,[src_offset],[src_size])\n"
		+ "vertex_update_buffer_from_vertex=(dest_vbuff,dest_vert,src_vbuff,[src_vert],[src_vert_num])\n"
		+ "vertex_buffer_exists=(vbuff):\n"
		+ "skeleton_animation_set=:(anim_name, [loop])!\n"
		+ "skeleton_animation_get=:()!:\n"
		+ "skeleton_animation_mix=:(anim_from,anim_to,duration)!\n"
		+ "skeleton_animation_set_ext=:(anim_name, track, [loop])!\n"
		+ "skeleton_animation_get_ext=:(track)!:\n"
		+ "skeleton_animation_get_duration=:(anim_name)!:\n"
		+ "skeleton_animation_get_frames=:(anim_name)!:\n"
		+ "skeleton_animation_clear=:(track,[reset],[duration])!\n"
		+ "skeleton_skin_set=:(skin_name)!\n"
		+ "skeleton_skin_get=:()!:\n"
		+ "skeleton_skin_create=:(skin_name, base_skins)!:\n"
		+ "skeleton_attachment_set=:(slot, attachment)!\n"
		+ "skeleton_attachment_get=:(slot)!:\n"
		+ "skeleton_attachment_create=:(name,sprite,ind,xo,yo,xs,ys,rot)!:\n"
		+ "skeleton_attachment_create_colour=:(name,sprite,ind,xo,yo,xs,ys,rot,col,alpha)!£:\n"
		+ "skeleton_attachment_create_color=:(name,sprite,ind,xo,yo,xs,ys,rot,col,alpha)!$:\n"
		+ "skeleton_attachment_exists=:(name)!:\n"
		+ "skeleton_attachment_replace=:(name,sprite,ind,xo,yo,xs,ys,rot)!\n"
		+ "skeleton_attachment_replace_colour=:(name,sprite,ind,xo,yo,xs,ys,rot,col,alpha)!£\n"
		+ "skeleton_attachment_replace_color=:(name,sprite,ind,xo,yo,xs,ys,rot,col,alpha)!$\n"
		+ "skeleton_attachment_destroy=:(name)!\n"
		+ "skeleton_collision_draw_set=:(val)!\n"
		+ "skeleton_bone_data_get=:(bone, map)!:\n"
		+ "skeleton_bone_data_set=:(bone, map)!\n"
		+ "skeleton_bone_state_get=:(bone, map)!:\n"
		+ "skeleton_bone_state_set=:(bone, map)!\n"
		+ "skeleton_slot_colour_set=:(slot,col,alpha)!£\n"
		+ "skeleton_slot_color_set=:(slot,col,alpha)!$\n"
		+ "skeleton_slot_colour_get=:(slot)!£:\n"
		+ "skeleton_slot_color_get=:(slot)!$:\n"
		+ "skeleton_slot_alpha_get=:(slot)!:\n"
		+ "skeleton_find_slot=:(x,y,list)!:\n"
		+ "skeleton_get_minmax=:()!:\n"
		+ "skeleton_get_num_bounds=:()!:\n"
		+ "skeleton_get_bounds=:(index)!:\n"
		+ "skeleton_animation_get_frame=:(track)!:\n"
		+ "skeleton_animation_set_frame=:(track,index)!\n"
		+ "skeleton_animation_get_position=:(track)!:\n"
		+ "skeleton_animation_set_position=:(track,position)!\n"
		+ "skeleton_animation_get_event_frames=:(anim_name,event_name)!:\n"
		+ "skeleton_animation_is_looping=:(track)!:\n"
		+ "skeleton_animation_is_finished=:(track)!:\n"
		+ "draw_skeleton=:(sprite,animname,skinname,frame,x,y,xscale,yscale,rot,col,alpha)!\n"
		+ "draw_skeleton_time=:(sprite, animname,skinname, time, x,y, xscale,yscale, rot, col,alpha)!\n"
		+ "draw_skeleton_instance=:(instance, animname,skinname,frame,x,y,xscale,yscale,rot,col,alpha)!\n"
		+ "draw_skeleton_collision=:(sprite,animname,frame,x,y,xscale,yscale,rot,col)!\n"
		+ "draw_enable_skeleton_blendmodes=:(enable)!\n"
		+ "draw_get_enable_skeleton_blendmodes=:()!:\n"
		+ "draw_enable_skeleton_blend_override=(enable)!\n"
		+ "draw_get_enable_skeleton_blend_override=()!:\n"
		+ "skeleton_animation_list=:(sprite, list)!\n"
		+ "skeleton_skin_list=:(sprite, list)!\n"
		+ "skeleton_bone_list=:(sprite, list)!\n"
		+ "skeleton_slot_list=:(sprite, list)!\n"
		+ "skeleton_slot_data=:(sprite, list)!\n"
		+ "skeleton_slot_data_instance=:(list)!\n"
		+ "layer_get_id=(layer_name):\n"
		+ "layer_get_id_at_depth=(depth):\n"
		+ "layer_get_depth=(layer_id):\n"
		+ "layer_create=(depth:number, ?name:string):\n"
		+ "layer_destroy=(layer_id)\n"
		+ "layer_destroy_instances=(layer_id)\n"
		+ "layer_add_instance=(layer_id,instance)\n"
		+ "layer_has_instance=(layer, inst):bool\n"
		+ "layer_set_visible=(layer_id,visible)\n"
		+ "layer_get_visible=(layer_id):\n"
		+ "layer_exists=(layer_id):\n"
		+ "layer_x=(layer_id,x)\n"
		+ "layer_y=(layer_id,y)\n"
		+ "layer_get_x=(layer_id):\n"
		+ "layer_get_y=(layer_id):\n"
		+ "layer_hspeed=(layer_id,speed)\n"
		+ "layer_vspeed=(layer_id,speed)\n"
		+ "layer_get_hspeed=(layer_id):\n"
		+ "layer_get_vspeed=(layer_id):\n"
		+ "layer_get_flexpanel_node=(layer_name):\n"
		+ "layer_get_type=(layer_id):\n"
		+ "layer_script_begin=(layer_id,script)\n"
		+ "layer_script_end=(layer_id,script)\n"
		+ "layer_shader=(layer_id,shader)\n"
		+ "layer_get_script_begin=(layer_id):\n"
		+ "layer_get_script_end=(layer_id):\n"
		+ "layer_get_shader=(layer_id):\n"
		+ "layer_set_target_room=(room)\n"
		+ "layer_get_target_room=():\n"
		+ "layer_reset_target_room=()\n"
		+ "layer_get_all=():\n"
		+ "layer_get_all_elements=(layer_id):\n"
		+ "layer_get_name=(layer_id):\n"
		+ "layer_depth=(layer_id, depth)\n"
		+ "layer_get_element_layer=(element_id):\n"
		+ "layer_get_element_type=(element_id):\n"
		+ "layer_element_move=(element_id,layer_id)\n"
		+ "layer_force_draw_depth=(force,depth)\n"
		+ "layer_is_draw_depth_forced=():\n"
		+ "layer_get_forced_depth=():\n"
		+ "layer_background_get_id=(layer_id):\n"
		+ "layer_background_exists=(layer_id,background_element_id):\n"
		+ "layer_background_create=(layer_id,sprite):\n"
		+ "layer_background_destroy=(background_element_id)\n"
		+ "layer_background_visible=(background_element_id,visible)\n"
		+ "layer_background_change=(background_element_id,sprite)\n"
		+ "layer_background_sprite=(background_element_id,sprite)\n"
		+ "layer_background_htiled=(background_element_id,tiled)\n"
		+ "layer_background_vtiled=(background_element_id,tiled)\n"
		+ "layer_background_stretch=(background_element_id,stretch)\n"
		+ "layer_background_yscale=(background_element_id,yscale)\n"
		+ "layer_background_xscale=(background_element_id,xscale)\n"
		+ "layer_background_blend=(background_element_id,col)\n"
		+ "layer_background_alpha=(background_element_id,alpha)\n"
		+ "layer_background_index=(background_element_id,image_index)\n"
		+ "layer_background_speed=(background_element_id,image_speed)\n"
		+ "layer_background_get_visible=(background_element_id):\n"
		+ "layer_background_get_sprite=(background_element_id):\n"
		+ "layer_background_get_htiled=(background_element_id):\n"
		+ "layer_background_get_vtiled=(background_element_id):\n"
		+ "layer_background_get_stretch=(background_element_id):\n"
		+ "layer_background_get_yscale=(background_element_id):\n"
		+ "layer_background_get_xscale=(background_element_id):\n"
		+ "layer_background_get_blend=(background_element_id):\n"
		+ "layer_background_get_alpha=(background_element_id):\n"
		+ "layer_background_get_index=(background_element_id):\n"
		+ "layer_background_get_speed=(background_element_id):\n"
		+ "layer_sprite_get_id=(layer_id,sprite_element_name):\n"
		+ "layer_sprite_exists=(layer_id,sprite_element_id):\n"
		+ "layer_sprite_create=(layer_id,x,y,sprite):\n"
		+ "layer_sprite_destroy=(sprite_element_id)\n"
		+ "layer_sprite_change=(sprite_element_id,sprite)\n"
		+ "layer_sprite_index=(sprite_element_id,image_index)\n"
		+ "layer_sprite_speed=(sprite_element_id,image_speed)\n"
		+ "layer_sprite_xscale=(sprite_element_id,scale)\n"
		+ "layer_sprite_yscale=(sprite_element_id,scale)\n"
		+ "layer_sprite_angle=(sprite_element_id,angle)\n"
		+ "layer_sprite_blend=(sprite_element_id,col)\n"
		+ "layer_sprite_alpha=(sprite_element_id,alpha)\n"
		+ "layer_sprite_x=(sprite_element_id,x)\n"
		+ "layer_sprite_y=(sprite_element_id,y)\n"
		+ "layer_sprite_get_sprite=(sprite_element_id):\n"
		+ "layer_sprite_get_index=(sprite_element_id):\n"
		+ "layer_sprite_get_speed=(sprite_element_id):\n"
		+ "layer_sprite_get_xscale=(sprite_element_id):\n"
		+ "layer_sprite_get_yscale=(sprite_element_id):\n"
		+ "layer_sprite_get_angle=(sprite_element_id):\n"
		+ "layer_sprite_get_blend=(sprite_element_id):\n"
		+ "layer_sprite_get_alpha=(sprite_element_id):\n"
		+ "layer_sprite_get_x=(sprite_element_id):\n"
		+ "layer_sprite_get_y=(sprite_element_id):\n"
		+ "layer_tilemap_get_id=(layer_id):\n"
		+ "layer_tilemap_exists=(layer_id,tilemap_element_id):\n"
		+ "layer_tilemap_create=(layer_id,x,y,tileset,width,height):\n"
		+ "layer_tilemap_destroy=(tilemap_element_id)\n"
		+ "layer_tilemap_set_colmask=(tilemap_element_id,index)\n"
		+ "layer_tilemap_get_colmask=(tilemap_element_id):\n"
		+ "tilemap_tileset=(tilemap_element_id,tileset)\n"
		+ "tilemap_x=(tilemap_element_id,x)\n"
		+ "tilemap_y=(tilemap_element_id,y)\n"
		+ "tilemap_set=(tilemap_element_id,tiledata,cell_x,cell_y)\n"
		+ "tilemap_set_at_pixel=(tilemap_element_id,tiledata,x,y)\n"
		+ "tileset_get_texture=(tileset_id):\n"
		+ "tileset_get_uvs=(tileset_id):\n"
		+ "tileset_get_name=(tileset_id):\n"
		+ "tileset_get_info=(tileset_id):\n"
		+ "tilemap_get_tileset=(tilemap_element_id):\n"
		+ "tilemap_get_tile_width=(tilemap_element_id):\n"
		+ "tilemap_get_tile_height=(tilemap_element_id):\n"
		+ "tilemap_get_width=(tilemap_element_id):\n"
		+ "tilemap_get_height=(tilemap_element_id):\n"
		+ "tilemap_set_width=(tilemap_element_id, width)\n"
		+ "tilemap_set_height=(tilemap_element_id, height)\n"
		+ "tilemap_get_x=(tilemap_element_id):\n"
		+ "tilemap_get_y=(tilemap_element_id):\n"
		+ "tilemap_get=(tilemap_element_id,cell_x,cell_y):\n"
		+ "tilemap_get_at_pixel=(tilemap_element_id,x,y):\n"
		+ "tilemap_get_cell_x_at_pixel=(tilemap_element_id,x,y):\n"
		+ "tilemap_get_cell_y_at_pixel=(tilemap_element_id,x,y):\n"
		+ "tilemap_clear=(tilemap_element_id,tiledata)\n"
		+ "draw_tilemap=(tilemap_element_id,x,y)\n"
		+ "draw_tile=(tileset,tiledata,frame,x,y)\n"
		+ "tilemap_set_global_mask=(mask)\n"
		+ "tilemap_get_global_mask=():\n"
		+ "tilemap_set_mask=(tilemap_element_id, mask)\n"
		+ "tilemap_get_mask=(tilemap_element_id):\n"
		+ "tilemap_get_frame=(tilemap_element_id):\n"
		+ "tile_set_empty=(tiledata:number):\n"
		+ "tile_set_index=(tiledata:number,tileindex:index):\n"
		+ "tile_set_flip=(tiledata:number,flip:bool):\n"
		+ "tile_set_mirror=(tiledata:number,mirror:bool):\n"
		+ "tile_set_rotate=(tiledata:number,rotate:bool):\n"
		+ "tile_get_empty=(tiledata):\n"
		+ "tile_get_index=(tiledata):\n"
		+ "tile_get_flip=(tiledata):\n"
		+ "tile_get_mirror=(tiledata):\n"
		+ "tile_get_rotate=(tiledata):\n"
		+ "layer_instance_get_instance=(instance_element_id):\n"
		+ "instance_activate_layer=(layer_id)\n"
		+ "instance_deactivate_layer=(layer_id)\n"
		+ "camera_create=():\n"
		+ "camera_create_view=(room_x, room_y, width, height, ?angle, ?object, ?x_speed, ?y_speed, ?x_border, ?y_border):\n"
		+ "camera_destroy=(camera)\n"
		+ "camera_apply=(camera)\n"
		+ "camera_copy_transforms=(dest_camera,src_camera)\n"
		+ "camera_get_active=():\n"
		+ "camera_get_default=():\n"
		+ "camera_set_default=(camera)\n"
		+ "camera_set_view_mat=(camera,matrix)\n"
		+ "camera_set_proj_mat=(camera,matrix)\n"
		+ "camera_set_update_script=(camera,script)\n"
		+ "camera_set_begin_script=(camera,script)\n"
		+ "camera_set_end_script=(camera,script)\n"
		+ "camera_set_view_pos=(camera,x,y)\n"
		+ "camera_set_view_size=(camera,width,height)\n"
		+ "camera_set_view_speed=(camera,x_speed,y_speed)\n"
		+ "camera_set_view_border=(camera,x_border,y_border)\n"
		+ "camera_set_view_angle=(camera,angle)\n"
		+ "camera_set_view_target=(camera,object)\n"
		+ "camera_get_view_mat=(camera):\n"
		+ "camera_get_proj_mat=(camera):\n"
		+ "camera_get_update_script=(camera):\n"
		+ "camera_get_begin_script=(camera):\n"
		+ "camera_get_end_script=(camera):\n"
		+ "camera_get_view_x=(camera):\n"
		+ "camera_get_view_y=(camera):\n"
		+ "camera_get_view_width=(camera):\n"
		+ "camera_get_view_height=(camera):\n"
		+ "camera_get_view_speed_x=(camera):\n"
		+ "camera_get_view_speed_y=(camera):\n"
		+ "camera_get_view_border_x=(camera):\n"
		+ "camera_get_view_border_y=(camera):\n"
		+ "camera_get_view_angle=(camera):\n"
		+ "camera_get_view_target=(camera):\n"
		+ "view_get_camera=(view):\n"
		+ "view_get_visible=(view):\n"
		+ "view_get_xport=(view):\n"
		+ "view_get_yport=(view):\n"
		+ "view_get_wport=(view):\n"
		+ "view_get_hport=(view):\n"
		+ "view_get_surface_id=(view):\n"
		+ "view_set_camera=(view,camera)\n"
		+ "view_set_visible=(view,visible)\n"
		+ "view_set_xport=(view,xport)\n"
		+ "view_set_yport=(view,yport)\n"
		+ "view_set_wport=(view,wport)\n"
		+ "view_set_hport=(view,hport)\n"
		+ "view_set_surface_id=(view,surface_id)\n"
		+ "gesture_drag_time=(time)\n"
		+ "gesture_drag_distance=(distance)\n"
		+ "gesture_flick_speed=(speed)\n"
		+ "gesture_double_tap_time=(time)\n"
		+ "gesture_double_tap_distance=(distance)\n"
		+ "gesture_pinch_distance=(distance)\n"
		+ "gesture_pinch_angle_towards=(angle)\n"
		+ "gesture_pinch_angle_away=(angle)\n"
		+ "gesture_rotate_time=(time)\n"
		+ "gesture_rotate_angle=(angle)\n"
		+ "gesture_tap_count=(enable)\n"
		+ "gesture_get_drag_time=():\n"
		+ "gesture_get_drag_distance=():\n"
		+ "gesture_get_flick_speed=():\n"
		+ "gesture_get_double_tap_time=():\n"
		+ "gesture_get_double_tap_distance=():\n"
		+ "gesture_get_pinch_distance=():\n"
		+ "gesture_get_pinch_angle_towards=():\n"
		+ "gesture_get_pinch_angle_away=():\n"
		+ "gesture_get_rotate_time=():\n"
		+ "gesture_get_rotate_angle=():\n"
		+ "gesture_get_tap_count=():\n"
		+ "keyboard_virtual_show=(virtual_keyboard_type, virtual_return_key_type, auto_capitalization_type, predictive_text_enabled)\n"
		+ "keyboard_virtual_hide=()\n"
		+ "keyboard_virtual_status=()\n"
		+ "keyboard_virtual_height=()\n"
		+ "keyboard_virtual_set_position=(x,y)\n"
		+ "tag_get_asset_ids=(tags,asset_type):\n"
		+ "tag_get_assets=(tags):\n"
		+ "asset_get_tags=(asset_name_or_id,[asset_type]):\n"
		+ "asset_add_tags=(asset_name_or_id,tags,?asset_type):\n"
		+ "asset_remove_tags=(asset_name_or_id,tags,?asset_type):\n"
		+ "asset_has_tags=(asset_name_or_id,tags,?asset_type):\n"
		+ "asset_has_any_tag=(asset_name_or_id,tags,?asset_type):\n"
		+ "asset_clear_tags=(asset_name_or_id,?asset_type):\n"
		+ "extension_exists=(ext_name):\n"
		+ "extension_get_version=(ext_name):\n"
		+ "extension_get_option_count=(ext_name):\n"
		+ "extension_get_option_names=(ext_name):\n"
		+ "extension_get_option_value=(ext_name, option_name):\n"
		+ "extension_get_options=(ext_name):\n"
		+ "layer_sequence_get_instance=(sequence_element_id):\n"
		+ "layer_sequence_create=(layer_id,x,y,sequence_id):\n"
		+ "layer_sequence_destroy=(sequence_element_id)\n"
		+ "layer_sequence_exists=(layer_id,sequence_element_id):\n"
		+ "layer_sequence_x=(sequence_element_id,pos_x)\n"
		+ "layer_sequence_y=(sequence_element_id,pos_y)\n"
		+ "layer_sequence_angle=(sequence_element_id,angle)\n"
		+ "layer_sequence_xscale=(sequence_element_id,xscale)\n"
		+ "layer_sequence_yscale=(sequence_element_id,yscale)\n"
		+ "layer_sequence_alpha=(sequence_element_id,alpha)\n"
		+ "layer_sequence_blend=(sequence_element_id,blend)\n"
		+ "layer_sequence_headpos=(sequence_element_id,position)\n"
		+ "layer_sequence_headdir=(sequence_element_id,direction)\n"
		+ "layer_sequence_pause=(sequence_element_id)\n"
		+ "layer_sequence_play=(sequence_element_id)\n"
		+ "layer_sequence_speedscale=(sequence_element_id,speedscale)\n"
		+ "layer_sequence_get_x=(sequence_element_id):\n"
		+ "layer_sequence_get_y=(sequence_element_id):\n"
		+ "layer_sequence_get_angle=(sequence_element_id):\n"
		+ "layer_sequence_get_xscale=(sequence_element_id):\n"
		+ "layer_sequence_get_yscale=(sequence_element_id):\n"
		+ "layer_sequence_get_headpos=(sequence_element_id):\n"
		+ "layer_sequence_get_headdir=(sequence_element_id):\n"
		+ "layer_sequence_get_sequence=(sequence_element_id):\n"
		+ "layer_sequence_is_paused=(sequence_element_id):\n"
		+ "layer_sequence_is_finished=(sequence_element_id):\n"
		+ "layer_sequence_get_speedscale=(sequence_element_id):\n"
		+ "layer_sequence_get_length=(sequence_element_id):\n"
		+ "layer_particle_xscale=(particle_element_id,xscale)\n"
		+ "layer_particle_yscale=(particle_element_id,yscale)\n"
		+ "layer_particle_angle=(particle_element_id,angle)\n"
		+ "layer_particle_blend=(particle_element_id,col)\n"
		+ "layer_particle_alpha=(particle_element_id,alpha)\n"
		+ "layer_particle_x=(particle_element_id,x)\n"
		+ "layer_particle_y=(particle_element_id,y)\n"
		+ "layer_particle_get_id=(layer_id, particle_element_name):\n"
		+ "layer_particle_get_instance=(particle_element_id):\n"
		+ "layer_particle_get_system=(particle_element_id):\n"
		+ "layer_particle_get_xscale=(particle_element_id):\n"
		+ "layer_particle_get_yscale=(particle_element_id):\n"
		+ "layer_particle_get_angle=(particle_element_id):\n"
		+ "layer_particle_get_blend=(particle_element_id):\n"
		+ "layer_particle_get_alpha=(particle_element_id):\n"
		+ "layer_particle_get_x=(particle_element_id):\n"
		+ "layer_particle_get_y=(particle_element_id):\n"
		+ "layer_text_get_id=(layer_id,text_element_name):\n"
		+ "layer_text_exists=(layer_id,text_element_id):\n"
		+ "layer_text_create=(layer_id,x,y,font,text):\n"
		+ "layer_text_destroy=(text_element_id)\n"
		+ "layer_text_x=(text_element_id,x)\n"
		+ "layer_text_y=(text_element_id,y)\n"
		+ "layer_text_angle=(text_element_id,angle)\n"
		+ "layer_text_xscale=(text_element_id,scale)\n"
		+ "layer_text_yscale=(text_element_id,scale)\n"
		+ "layer_text_blend=(text_element_id,col)\n"
		+ "layer_text_alpha=(text_element_id,alpha)\n"
		+ "layer_text_font=(text_element_id,font)\n"
		+ "layer_text_xorigin=(text_element_id,xorigin)\n"
		+ "layer_text_yorigin=(text_element_id,yorigin)\n"
		+ "layer_text_origin=(text_element_id,origin)\n"
		+ "layer_text_text=(text_element_id,text)\n"
		+ "layer_text_halign=(text_element_id,alignment)\n"
		+ "layer_text_valign=(text_element_id,alignment)\n"
		+ "layer_text_charspacing=(text_element_id,charspacing)\n"
		+ "layer_text_linespacing=(text_element_id,linespacing)\n"
		+ "layer_text_paragraphspacing=(text_element_id,paragraphspacing)\n"
		+ "layer_text_framew=(text_element_id,width)\n"
		+ "layer_text_frameh=(text_element_id,height)\n"
		+ "layer_text_wrap=(text_element_id,wrap)\n"
		+ "layer_text_wrapmode=(text_element_id,wrapmode)\n"
		+ "layer_text_get_x=(text_element_id):\n"
		+ "layer_text_get_y=(text_element_id):\n"
		+ "layer_text_get_xscale=(text_element_id):\n"
		+ "layer_text_get_yscale=(text_element_id):\n"
		+ "layer_text_get_angle=(text_element_id):\n"
		+ "layer_text_get_blend=(text_element_id):\n"
		+ "layer_text_get_alpha=(text_element_id):\n"
		+ "layer_text_get_font=(text_element_id):\n"
		+ "layer_text_get_xorigin=(text_element_id):\n"
		+ "layer_text_get_yorigin=(text_element_id):\n"
		+ "layer_text_get_origin=(text_element_id):\n"
		+ "layer_text_get_text=(text_element_id):\n"
		+ "layer_text_get_halign=(text_element_id):\n"
		+ "layer_text_get_valign=(text_element_id):\n"
		+ "layer_text_get_charspacing=(text_element_id):\n"
		+ "layer_text_get_linespacing=(text_element_id):\n"
		+ "layer_text_get_paragraphspacing=(text_element_id):\n"
		+ "layer_text_get_framew=(text_element_id):\n"
		+ "layer_text_get_frameh=(text_element_id):\n"
		+ "layer_text_get_wrap=(text_element_id):\n"
		+ "layer_text_get_wrapmode=(text_element_id):\n"
		+ "animcurve_get=(curve_id):\n"
		+ "animcurve_get_channel=(curve_struct_or_id,channel_name_or_index):\n"
		+ "animcurve_get_channel_index=(curve_struct_or_id,channel_name):\n"
		+ "animcurve_channel_evaluate=(channel,posx):\n"
		+ "sequence_create=():\n"
		+ "sequence_destroy=(sequence_struct_or_id)\n"
		+ "sequence_exists=(sequence_struct_or_id):\n"
		+ "sequence_get=(sequence_id):\n"
		+ "sequence_keyframe_new=(type):\n"
		+ "sequence_keyframedata_new=(type):\n"
		+ "sequence_track_new=(type):\n"
		+ "sequence_get_objects=(sequence_struct_or_id):\n"
		+ "sequence_instance_override_object=(sequence_instance_struct,object_id,instance_or_object_id)\n"
		+ "animcurve_create=():\n"
		+ "animcurve_destroy=(curve_struct_or_id)\n"
		+ "animcurve_exists=(curve_struct_or_id):\n"
		+ "animcurve_channel_new=():\n"
		+ "animcurve_point_new=():\n"
		+ "fx_create=(filter_or_effect_name):\n"
		+ "fx_get_name=(filter_or_effect):\n"
		+ "fx_get_parameter_names=(filter_or_effect):\n"
		+ "fx_get_parameter=(filter_or_effect,parameter_name):\n"
		+ "fx_get_parameters=(filter_or_effect):\n"
		+ "fx_get_single_layer=(filter_or_effect):\n"
		+ "fx_set_parameter=(filter_or_effect,parameter_name,val,...)\n"
		+ "fx_set_parameters=(filter_or_effect,parameter_struct)\n"
		+ "fx_set_single_layer=(filter_or_effect,enable)\n"
		+ "layer_set_fx=(layer_name_or_id,filter_or_effect)\n"
		+ "layer_get_fx=(layer_name_or_id):\n"
		+ "layer_clear_fx=(layer_name_or_id)\n"
		+ "layer_enable_fx=(layer_name_or_id,enable)\n"
		+ "layer_fx_is_enabled=(layer_name_or_id):\n"
		+ "gc_collect=()\n"
		+ "gc_enable=(enable)\n"
		+ "gc_is_enabled=():\n"
		+ "gc_get_stats=():\n"
		+ "gc_target_frame_time=(time)\n"
		+ "gc_get_target_frame_time=():\n"
		+ "weak_ref_create=(thing_to_track):\n"
		+ "weak_ref_alive=(weak_ref)\n"
		+ "weak_ref_any_alive=(array,[index],[length])\n"
		+ "time_source_create=(parent,period,units,callback,[args],[reps],[expiryType]):\n"
		+ "time_source_destroy=(id, [destroyTree])\n"
		+ "time_source_start=(id)\n"
		+ "time_source_stop=(id)\n"
		+ "time_source_pause=(id)\n"
		+ "time_source_resume=(id)\n"
		+ "time_source_reset=(id)\n"
		+ "time_source_reconfigure=(id,period,units,callback,[args],[reps],[expiryType])\n"
		+ "time_source_get_period=(id):\n"
		+ "time_source_get_reps_completed=(id):\n"
		+ "time_source_get_reps_remaining=(id):\n"
		+ "time_source_get_units=(id):\n"
		+ "time_source_get_time_remaining=(id):\n"
		+ "time_source_get_state=(id):\n"
		+ "time_source_get_parent=(id):\n"
		+ "time_source_get_children=(id):\n"
		+ "time_source_exists=(id):\n"
		+ "time_seconds_to_bpm=(seconds)\n"
		+ "time_bpm_to_seconds=(bpm)\n"
		+ "call_later=(period, units, callback, [repeat])\n"
		+ "call_cancel=(handle)\n"
		+ "rollback_use_manual_start=()^rollback\n"
		+ "rollback_use_late_join=()^rollback\n"
		+ "rollback_define_player=(player_obj,...)^rollback\n"
		+ "rollback_define_input=(input)^rollback\n"
		+ "rollback_define_mock_input=(player_id,input)^rollback\n"
		+ "rollback_define_input_frame_delay=(frames)^rollback\n"
		+ "rollback_define_extra_network_latency=(latency)^rollback\n"
		+ "rollback_create_game=(num_players,...)^rollback:\n"
		+ "rollback_join_game=(...)^rollback\n"
		+ "rollback_start_game=()^rollback\n"
		+ "rollback_leave_game=()^rollback\n"
		+ "rollback_get_input=(...)^rollback:\n"
		+ "rollback_chat=(message,...)^rollback\n"
		+ "rollback_use_player_prefs=(...)^rollback\n"
		+ "rollback_set_player_prefs=(preferences)^rollback\n"
		+ "rollback_get_player_prefs=(...)^rollback:\n"
		+ "rollback_get_info=(...)^rollback:\n"
		+ "rollback_use_random_input=(enabled)^rollback\n"
		+ "rollback_display_events=(enabled)^rollback\n"
		+ "rollback_sync_on_frame=()^rollback\n"
		+ "wallpaper_set_config=(config)^rollback\n"
		+ "wallpaper_set_subscriptions=(subscriptions)^live_wallpaper_subscription\n"
		+ "audio_bus_create=():\n"
		+ "audio_effect_create=(type, [params]):\n"
		+ "audio_emitter_bus=(emitter_idx, bus)\n"
		+ "audio_emitter_get_bus=(emitter_idx):\n"
		+ "audio_bus_get_emitters=(bus):\n"
		+ "audio_bus_clear_emitters=(bus)\n"
		+ "lin_to_db=(x)\n"
		+ "db_to_lin=(x)\n"
		+ "flexpanel_create_node=([struct]):\n"
		+ "flexpanel_delete_node=(node,[recursive])\n"
		+ "flexpanel_node_insert_child=(node,child,index)\n"
		+ "flexpanel_node_remove_child=(node,child)\n"
		+ "flexpanel_node_remove_all_children=(node)\n"
		+ "flexpanel_node_get_num_children=(node):\n"
		+ "flexpanel_node_get_child=(node,indexOrName):\n"
		+ "flexpanel_node_get_child_hash=(node,hashOrName):\n"
		+ "flexpanel_node_get_parent=(node):\n"
		+ "flexpanel_node_get_name=(node):\n"
		+ "flexpanel_node_get_data=(node):\n"
		+ "flexpanel_node_set_name=(node,name)\n"
		+ "flexpanel_node_set_data=(node,dataStruct)\n"
		+ "flexpanel_node_get_struct=(node):\n"
		+ "flexpanel_node_get_measure_function=(node):\n"
		+ "flexpanel_node_set_measure_function=(node,function)\n"
		+ "flexpanel_calculate_layout=(node,[width],[height],[direction],[dirty])\n"
		+ "flexpanel_node_layout_get_position=(node,[relative]):\n"
		+ "flexpanel_set_rounding_scale=(scaleFactor)\n"
		+ "flexpanel_get_rounding_scale=():\n"
		+ "flexpanel_node_style_get_align_content=(node):\n"
		+ "flexpanel_node_style_get_align_items=(node):\n"
		+ "flexpanel_node_style_get_align_self=(node):\n"
		+ "flexpanel_node_style_get_aspect_ratio=(node):\n"
		+ "flexpanel_node_style_get_display=(node):\n"
		+ "flexpanel_node_style_get_flex=(node):\n"
		+ "flexpanel_node_style_get_flex_grow=(node):\n"
		+ "flexpanel_node_style_get_flex_shrink=(node):\n"
		+ "flexpanel_node_style_get_flex_basis=(node):\n"
		+ "flexpanel_node_style_get_flex_direction=(node):\n"
		+ "flexpanel_node_style_get_flex_wrap=(node):\n"
		+ "flexpanel_node_style_get_gap=(node,gutter):\n"
		+ "flexpanel_node_style_get_position=(node,edge):\n"
		+ "flexpanel_node_style_get_justify_content=(node):\n"
		+ "flexpanel_node_style_get_direction=(node):\n"
		+ "flexpanel_node_style_get_margin=(node,edge):\n"
		+ "flexpanel_node_style_get_padding=(node,edge):\n"
		+ "flexpanel_node_style_get_border=(node,edge):\n"
		+ "flexpanel_node_style_get_position_type=(node):\n"
		+ "flexpanel_node_style_get_min_width=(node):\n"
		+ "flexpanel_node_style_get_max_width=(node):\n"
		+ "flexpanel_node_style_get_min_height=(node):\n"
		+ "flexpanel_node_style_get_max_height=(node):\n"
		+ "flexpanel_node_style_get_width=(node):\n"
		+ "flexpanel_node_style_get_height=(node):\n"
		+ "flexpanel_node_style_set_align_content=(node,align)\n"
		+ "flexpanel_node_style_set_align_items=(node,align)\n"
		+ "flexpanel_node_style_set_align_self=(node,align)\n"
		+ "flexpanel_node_style_set_aspect_ratio=(node,aspect_ratio)\n"
		+ "flexpanel_node_style_set_display=(node,display)\n"
		+ "flexpanel_node_style_set_flex=(node,value)\n"
		+ "flexpanel_node_style_set_flex_grow=(node,grow)\n"
		+ "flexpanel_node_style_set_flex_shrink=(node,shrink)\n"
		+ "flexpanel_node_style_set_flex_basis=(node,value,unit)\n"
		+ "flexpanel_node_style_set_flex_direction=(node,direction)\n"
		+ "flexpanel_node_style_set_flex_wrap=(node,wrap)\n"
		+ "flexpanel_node_style_set_gap=(node,gutter,size)\n"
		+ "flexpanel_node_style_set_position=(node,edge,value,unit)\n"
		+ "flexpanel_node_style_set_justify_content=(node,justify)\n"
		+ "flexpanel_node_style_set_direction=(node,flexpanel_direction)\n"
		+ "flexpanel_node_style_set_margin=(node,edge,value,[unit])\n"
		+ "flexpanel_node_style_set_padding=(node,edge,value,[unit])\n"
		+ "flexpanel_node_style_set_border=(node,edge,value)\n"
		+ "flexpanel_node_style_set_position_type=(node,type)\n"
		+ "flexpanel_node_style_set_min_width=(node,value,unit)\n"
		+ "flexpanel_node_style_set_max_width=(node,value,unit)\n"
		+ "flexpanel_node_style_set_min_height=(node,value,unit)\n"
		+ "flexpanel_node_style_set_max_height=(node,value,unit)\n"
		+ "flexpanel_node_style_set_width=(node,width,unit)\n"
		+ "flexpanel_node_style_set_height=(node,height,unit)");
	while(!file_text_eof(l_lines)){
		var l_line=file_text_read_string(l_lines);
		file_text_readln(l_lines);
		var l_sep=string_pos("=",l_line);
		var l_name=string_copy(l_line,1,l_sep-1);
		var l_sig=string_delete(l_line,1,l_sep);
		l_sep=string_pos("(",l_sig);
		l_sig=string_insert(l_name,l_sig,l_sep);
		if(l_isJS){
			var l_jsFunc;
			try{
				l_jsFunc=live_preinit_js_func(l_jsIndex);
				if(l_jsFunc==undefined)l_jsFunc=l_jsDummy;
			}catch(l__g){
				l_jsFunc=l_jsDummy
			}
			l_jsIndex++;
			live_function_add(l_sig,l_jsFunc);
		} else {
			var l_m=l_fm[?l_name];
			if(l_m==undefined)continue;
			l_m.used=true;
			l_func=l_m.func;
			live_function_add(l_sig,l_func);
		}
	}
	file_text_close(l_lines);
	if(!l_isJS){
		for(var l_i=0,l__g1=ds_list_size(l_fl);l_i<l__g1;l_i++){
			var l_m=l_fl[|l_i];
			if(l_m.used)continue;
			live_function_add((":::"+l_m.name+"(...):"),l_m.func);
		}
	}
	ds_map_destroy(l_fm);
	ds_list_destroy(l_fl);
}

if(live_enabled)
function live_preinit_collect_constants(){
	/*
		If you are getting an error in this function, a constant doesn't exist in your runtime version.
		You can get around this by replacing it with `undefined` or adding a dummy macro like
		#macro missing_constant undefined
	*/;
	var l_gmlConstValues=[];
	l_gmlConstValues=[
		undefined,
		pointer_invalid,
		pointer_null,
		path_action_stop,
		path_action_restart,
		path_action_continue,
		path_action_reverse,
		pi,
		NaN,
		infinity,
		GM_build_date,
		GM_version,
		GM_runtime_version,
		timezone_local,
		timezone_utc,
		gamespeed_fps,
		gamespeed_microseconds,
		ev_create,
		ev_destroy,
		ev_step,
		ev_alarm,
		ev_keyboard,
		ev_mouse,
		ev_collision,
		ev_other,
		ev_draw,
		ev_draw_begin,
		ev_draw_end,
		ev_draw_pre,
		ev_draw_post,
		ev_keypress,
		ev_keyrelease,
		ev_trigger,
		ev_left_button,
		ev_right_button,
		ev_middle_button,
		ev_no_button,
		ev_left_press,
		ev_right_press,
		ev_middle_press,
		ev_left_release,
		ev_right_release,
		ev_middle_release,
		ev_mouse_enter,
		ev_mouse_leave,
		ev_mouse_wheel_up,
		ev_mouse_wheel_down,
		ev_global_left_button,
		ev_global_right_button,
		ev_global_middle_button,
		ev_global_left_press,
		ev_global_right_press,
		ev_global_middle_press,
		ev_global_left_release,
		ev_global_right_release,
		ev_global_middle_release,
		ev_joystick1_left,
		ev_joystick1_right,
		ev_joystick1_up,
		ev_joystick1_down,
		ev_joystick1_button1,
		ev_joystick1_button2,
		ev_joystick1_button3,
		ev_joystick1_button4,
		ev_joystick1_button5,
		ev_joystick1_button6,
		ev_joystick1_button7,
		ev_joystick1_button8,
		ev_joystick2_left,
		ev_joystick2_right,
		ev_joystick2_up,
		ev_joystick2_down,
		ev_joystick2_button1,
		ev_joystick2_button2,
		ev_joystick2_button3,
		ev_joystick2_button4,
		ev_joystick2_button5,
		ev_joystick2_button6,
		ev_joystick2_button7,
		ev_joystick2_button8,
		ev_outside,
		ev_boundary,
		ev_game_start,
		ev_game_end,
		ev_room_start,
		ev_room_end,
		ev_no_more_lives,
		ev_animation_end,
		ev_end_of_path,
		ev_no_more_health,
		ev_user0,
		ev_user1,
		ev_user2,
		ev_user3,
		ev_user4,
		ev_user5,
		ev_user6,
		ev_user7,
		ev_user8,
		ev_user9,
		ev_user10,
		ev_user11,
		ev_user12,
		ev_user13,
		ev_user14,
		ev_user15,
		ev_outside_view0,
		ev_outside_view1,
		ev_outside_view2,
		ev_outside_view3,
		ev_outside_view4,
		ev_outside_view5,
		ev_outside_view6,
		ev_outside_view7,
		ev_boundary_view0,
		ev_boundary_view1,
		ev_boundary_view2,
		ev_boundary_view3,
		ev_boundary_view4,
		ev_boundary_view5,
		ev_boundary_view6,
		ev_boundary_view7,
		ev_animation_update,
		ev_animation_event,
		ev_web_image_load,
		ev_web_sound_load,
		ev_web_async,
		ev_dialog_async,
		ev_web_iap,
		ev_web_cloud,
		ev_web_networking,
		ev_web_steam,
		ev_social,
		ev_push_notification,
		ev_async_save_load,
		ev_audio_recording,
		ev_audio_playback,
		ev_system_event,
		ev_broadcast_message,
		ev_step_normal,
		ev_step_begin,
		ev_step_end,
		ev_gui,
		ev_gui_begin,
		ev_gui_end,
		ev_cleanup,
		ev_gesture,
		ev_gesture_tap,
		ev_gesture_double_tap,
		ev_gesture_drag_start,
		ev_gesture_dragging,
		ev_gesture_drag_end,
		ev_gesture_flick,
		ev_gesture_pinch_start,
		ev_gesture_pinch_in,
		ev_gesture_pinch_out,
		ev_gesture_pinch_end,
		ev_gesture_rotate_start,
		ev_gesture_rotating,
		ev_gesture_rotate_end,
		ev_global_gesture_tap,
		ev_global_gesture_double_tap,
		ev_global_gesture_drag_start,
		ev_global_gesture_dragging,
		ev_global_gesture_drag_end,
		ev_global_gesture_flick,
		ev_global_gesture_pinch_start,
		ev_global_gesture_pinch_in,
		ev_global_gesture_pinch_out,
		ev_global_gesture_pinch_end,
		ev_global_gesture_rotate_start,
		ev_global_gesture_rotating,
		ev_global_gesture_rotate_end,
		ev_async_web_image_load,
		ev_async_web,
		ev_async_dialog,
		ev_async_web_iap,
		ev_async_web_cloud,
		ev_async_web_networking,
		ev_async_web_steam,
		ev_async_social,
		ev_async_push_notification,
		ev_async_save_load,
		ev_async_audio_recording,
		ev_async_audio_playback,
		ev_async_system_event,
		vk_nokey,
		vk_anykey,
		vk_enter,
		vk_return,
		vk_shift,
		vk_control,
		vk_alt,
		vk_escape,
		vk_space,
		vk_backspace,
		vk_tab,
		vk_pause,
		vk_printscreen,
		vk_left,
		vk_right,
		vk_up,
		vk_down,
		vk_home,
		vk_end,
		vk_delete,
		vk_insert,
		vk_pageup,
		vk_pagedown,
		vk_f1,
		vk_f2,
		vk_f3,
		vk_f4,
		vk_f5,
		vk_f6,
		vk_f7,
		vk_f8,
		vk_f9,
		vk_f10,
		vk_f11,
		vk_f12,
		vk_numpad0,
		vk_numpad1,
		vk_numpad2,
		vk_numpad3,
		vk_numpad4,
		vk_numpad5,
		vk_numpad6,
		vk_numpad7,
		vk_numpad8,
		vk_numpad9,
		vk_divide,
		vk_multiply,
		vk_subtract,
		vk_add,
		vk_decimal,
		vk_lshift,
		vk_lcontrol,
		vk_lalt,
		vk_rshift,
		vk_rcontrol,
		vk_ralt,
		mb_any,
		mb_none,
		mb_left,
		mb_right,
		mb_middle,
		mb_side1,
		mb_side2,
		bboxmode_automatic,
		bboxmode_fullimage,
		bboxmode_manual,
		bboxkind_precise,
		bboxkind_rectangular,
		bboxkind_ellipse,
		bboxkind_diamond,
		c_aqua,
		c_black,
		c_blue,
		c_dkgray,
		c_dkgrey,
		c_fuchsia,
		c_gray,
		c_grey,
		c_green,
		c_lime,
		c_ltgray,
		c_ltgrey,
		c_maroon,
		c_navy,
		c_olive,
		c_purple,
		c_red,
		c_silver,
		c_teal,
		c_white,
		c_yellow,
		c_orange,
		fa_left,
		fa_center,
		fa_right,
		fa_top,
		fa_middle,
		fa_bottom,
		pr_pointlist,
		pr_linelist,
		pr_linestrip,
		pr_trianglelist,
		pr_trianglestrip,
		pr_trianglefan,
		bm_normal,
		bm_add,
		bm_max,
		bm_subtract,
		bm_zero,
		bm_one,
		bm_src_colour,
		bm_inv_src_colour,
		bm_src_color,
		bm_inv_src_color,
		bm_src_alpha,
		bm_inv_src_alpha,
		bm_dest_alpha,
		bm_inv_dest_alpha,
		bm_dest_colour,
		bm_inv_dest_colour,
		bm_dest_color,
		bm_inv_dest_color,
		bm_src_alpha_sat,
		tf_point,
		tf_linear,
		tf_anisotropic,
		mip_off,
		mip_on,
		mip_markedonly,
		audio_falloff_none,
		audio_falloff_inverse_distance,
		audio_falloff_inverse_distance_clamped,
		audio_falloff_linear_distance,
		audio_falloff_linear_distance_clamped,
		audio_falloff_exponent_distance,
		audio_falloff_exponent_distance_clamped,
		audio_mono,
		audio_stereo,
		audio_3d,
		cr_default,
		cr_none,
		cr_arrow,
		cr_cross,
		cr_beam,
		cr_size_nesw,
		cr_size_ns,
		cr_size_nwse,
		cr_size_we,
		cr_uparrow,
		cr_hourglass,
		cr_drag,
		cr_appstart,
		cr_handpoint,
		cr_size_all,
		spritespeed_framespersecond,
		spritespeed_framespergameframe,
		asset_object,
		asset_unknown,
		asset_sprite,
		asset_sound,
		asset_room,
		asset_path,
		asset_script,
		asset_font,
		asset_timeline,
		asset_tiles,
		asset_shader,
		asset_sequence,
		asset_animationcurve,
		fa_readonly,
		fa_hidden,
		fa_sysfile,
		fa_volumeid,
		fa_directory,
		fa_archive,
		ds_type_map,
		ds_type_list,
		ds_type_stack,
		ds_type_queue,
		ds_type_grid,
		ds_type_priority,
		ef_explosion,
		ef_ring,
		ef_ellipse,
		ef_firework,
		ef_smoke,
		ef_smokeup,
		ef_star,
		ef_spark,
		ef_flare,
		ef_cloud,
		ef_rain,
		ef_snow,
		pt_shape_pixel,
		pt_shape_disk,
		pt_shape_square,
		pt_shape_line,
		pt_shape_star,
		pt_shape_circle,
		pt_shape_ring,
		pt_shape_sphere,
		pt_shape_flare,
		pt_shape_spark,
		pt_shape_explosion,
		pt_shape_cloud,
		pt_shape_smoke,
		pt_shape_snow,
		ps_distr_linear,
		ps_distr_gaussian,
		ps_distr_invgaussian,
		ps_shape_rectangle,
		ps_shape_ellipse,
		ps_shape_diamond,
		ps_shape_line,
		matrix_view,
		matrix_projection,
		matrix_world,
		os_windows,
		os_macosx,
		os_ios,
		os_android,
		os_linux,
		os_unknown,
		os_ps4,
		os_tvos,
		os_switch,
		os_ps5,
		os_xboxseriesxs,
		os_operagx,
		browser_not_a_browser,
		browser_unknown,
		browser_ie,
		browser_firefox,
		browser_chrome,
		browser_safari,
		browser_safari_mobile,
		browser_opera,
		browser_tizen,
		browser_edge,
		browser_windows_store,
		browser_ie_mobile,
		device_ios_unknown,
		device_ios_iphone,
		device_ios_iphone_retina,
		device_ios_ipad,
		device_ios_ipad_retina,
		device_ios_iphone5,
		device_ios_iphone6,
		device_ios_iphone6plus,
		device_emulator,
		device_tablet,
		display_landscape,
		display_landscape_flipped,
		display_portrait,
		display_portrait_flipped,
		tm_sleep,
		tm_countvsyncs,
		of_challenge_win,
		of_challenge_lose,
		of_challenge_tie,
		cmpfunc_never,
		cmpfunc_less,
		cmpfunc_equal,
		cmpfunc_lessequal,
		cmpfunc_greater,
		cmpfunc_notequal,
		cmpfunc_greaterequal,
		cmpfunc_always,
		cull_noculling,
		cull_clockwise,
		cull_counterclockwise,
		lighttype_dir,
		lighttype_point,
		phy_joint_anchor_1_x,
		phy_joint_anchor_1_y,
		phy_joint_anchor_2_x,
		phy_joint_anchor_2_y,
		phy_joint_reaction_force_x,
		phy_joint_reaction_force_y,
		phy_joint_reaction_torque,
		phy_joint_motor_speed,
		phy_joint_angle,
		phy_joint_motor_torque,
		phy_joint_max_motor_torque,
		phy_joint_translation,
		phy_joint_speed,
		phy_joint_motor_force,
		phy_joint_max_motor_force,
		phy_joint_length_1,
		phy_joint_length_2,
		phy_joint_damping_ratio,
		phy_joint_frequency,
		phy_joint_lower_angle_limit,
		phy_joint_upper_angle_limit,
		phy_joint_angle_limits,
		phy_joint_max_length,
		phy_joint_max_torque,
		phy_joint_max_force,
		phy_debug_render_aabb,
		phy_debug_render_collision_pairs,
		phy_debug_render_coms,
		phy_debug_render_core_shapes,
		phy_debug_render_joints,
		phy_debug_render_obb,
		phy_debug_render_shapes,
		phy_particle_flag_water,
		phy_particle_flag_zombie,
		phy_particle_flag_wall,
		phy_particle_flag_spring,
		phy_particle_flag_elastic,
		phy_particle_flag_viscous,
		phy_particle_flag_powder,
		phy_particle_flag_tensile,
		phy_particle_flag_colourmixing,
		phy_particle_group_flag_solid,
		phy_particle_group_flag_rigid,
		phy_particle_data_flag_typeflags,
		phy_particle_data_flag_position,
		phy_particle_data_flag_velocity,
		phy_particle_data_flag_colour,
		phy_particle_data_flag_category,
		network_socket_tcp,
		network_socket_udp,
		network_socket_ws,
		network_socket_bluetooth,
		network_type_connect,
		network_type_disconnect,
		network_type_data,
		network_type_non_blocking_connect,
		network_config_connect_timeout,
		network_config_use_non_blocking_socket,
		network_config_enable_reliable_udp,
		network_config_disable_reliable_udp,
		network_config_avoid_time_wait,
		buffer_fixed,
		buffer_grow,
		buffer_wrap,
		buffer_fast,
		buffer_vbuffer,
		buffer_u8,
		buffer_s8,
		buffer_u16,
		buffer_s16,
		buffer_u32,
		buffer_s32,
		buffer_u64,
		buffer_f16,
		buffer_f32,
		buffer_f64,
		buffer_bool,
		buffer_text,
		buffer_string,
		buffer_seek_start,
		buffer_seek_relative,
		buffer_seek_end,
		gp_face1,
		gp_face2,
		gp_face3,
		gp_face4,
		gp_shoulderl,
		gp_shoulderr,
		gp_shoulderlb,
		gp_shoulderrb,
		gp_select,
		gp_start,
		gp_stickl,
		gp_stickr,
		gp_padu,
		gp_padd,
		gp_padl,
		gp_padr,
		gp_axislh,
		gp_axislv,
		gp_axisrh,
		gp_axisrv,
		gp_axis_acceleration_x,
		gp_axis_acceleration_y,
		gp_axis_acceleration_z,
		gp_axis_angular_velocity_x,
		gp_axis_angular_velocity_y,
		gp_axis_angular_velocity_z,
		gp_axis_orientation_x,
		gp_axis_orientation_y,
		gp_axis_orientation_z,
		gp_axis_orientation_w,
		vertex_usage_position,
		vertex_usage_colour,
		vertex_usage_normal,
		vertex_usage_texcoord,
		vertex_usage_blendweight,
		vertex_usage_blendindices,
		vertex_usage_psize,
		vertex_usage_tangent,
		vertex_usage_binormal,
		vertex_usage_fog,
		vertex_usage_depth,
		vertex_usage_sample,
		vertex_type_float1,
		vertex_type_float2,
		vertex_type_float3,
		vertex_type_float4,
		vertex_type_colour,
		vertex_type_ubyte4,
		layerelementtype_undefined,
		layerelementtype_background,
		layerelementtype_instance,
		layerelementtype_oldtilemap,
		layerelementtype_sprite,
		layerelementtype_tilemap,
		layerelementtype_particlesystem,
		layerelementtype_tile,
		layerelementtype_sequence,
		tile_rotate,
		tile_flip,
		tile_mirror,
		tile_index_mask,
		kbv_type_default,
		kbv_type_ascii,
		kbv_type_url,
		kbv_type_email,
		kbv_type_numbers,
		kbv_type_phone,
		kbv_type_phone_name,
		kbv_returnkey_default,
		kbv_returnkey_go,
		kbv_returnkey_google,
		kbv_returnkey_join,
		kbv_returnkey_next,
		kbv_returnkey_route,
		kbv_returnkey_search,
		kbv_returnkey_send,
		kbv_returnkey_yahoo,
		kbv_returnkey_done,
		kbv_returnkey_continue,
		kbv_returnkey_emergency,
		kbv_autocapitalize_none,
		kbv_autocapitalize_words,
		kbv_autocapitalize_sentences,
		kbv_autocapitalize_characters,
		os_permission_denied_dont_request,
		os_permission_denied,
		os_permission_granted,
		nineslice_left,
		nineslice_top,
		nineslice_right,
		nineslice_bottom,
		nineslice_centre,
		nineslice_center,
		nineslice_stretch,
		nineslice_repeat,
		nineslice_mirror,
		nineslice_blank,
		nineslice_hide,
		seqtracktype_graphic,
		seqtracktype_audio,
		seqtracktype_real,
		seqtracktype_color,
		seqtracktype_colour,
		seqtracktype_bool,
		seqtracktype_string,
		seqtracktype_sequence,
		seqtracktype_clipmask,
		seqtracktype_clipmask_mask,
		seqtracktype_clipmask_subject,
		seqtracktype_group,
		seqtracktype_empty,
		seqtracktype_spriteframes,
		seqtracktype_instance,
		seqtracktype_message,
		seqtracktype_moment,
		seqplay_oneshot,
		seqplay_loop,
		seqplay_pingpong,
		seqdir_right,
		seqdir_left,
		seqinterpolation_assign,
		seqinterpolation_lerp,
		seqaudiokey_loop,
		seqaudiokey_oneshot,
		animcurvetype_linear,
		animcurvetype_catmullrom
	];
	return l_gmlConstValues;
}

if(live_enabled)
function live_preinit_init_consts(){
	var l_gmlConstNames=undefined;
	var l_gmlConstValues=live_preinit_collect_constants();
	l_gmlConstNames="undefined\n"
		+ "pointer_invalid\n"
		+ "pointer_null\n"
		+ "path_action_stop\n"
		+ "path_action_restart\n"
		+ "path_action_continue\n"
		+ "path_action_reverse\n"
		+ "pi\n"
		+ "NaN\n"
		+ "infinity\n"
		+ "GM_build_date\n"
		+ "GM_version\n"
		+ "GM_runtime_version\n"
		+ "timezone_local\n"
		+ "timezone_utc\n"
		+ "gamespeed_fps\n"
		+ "gamespeed_microseconds\n"
		+ "ev_create\n"
		+ "ev_destroy\n"
		+ "ev_step\n"
		+ "ev_alarm\n"
		+ "ev_keyboard\n"
		+ "ev_mouse\n"
		+ "ev_collision\n"
		+ "ev_other\n"
		+ "ev_draw\n"
		+ "ev_draw_begin\n"
		+ "ev_draw_end\n"
		+ "ev_draw_pre\n"
		+ "ev_draw_post\n"
		+ "ev_keypress\n"
		+ "ev_keyrelease\n"
		+ "ev_trigger\n"
		+ "ev_left_button\n"
		+ "ev_right_button\n"
		+ "ev_middle_button\n"
		+ "ev_no_button\n"
		+ "ev_left_press\n"
		+ "ev_right_press\n"
		+ "ev_middle_press\n"
		+ "ev_left_release\n"
		+ "ev_right_release\n"
		+ "ev_middle_release\n"
		+ "ev_mouse_enter\n"
		+ "ev_mouse_leave\n"
		+ "ev_mouse_wheel_up\n"
		+ "ev_mouse_wheel_down\n"
		+ "ev_global_left_button\n"
		+ "ev_global_right_button\n"
		+ "ev_global_middle_button\n"
		+ "ev_global_left_press\n"
		+ "ev_global_right_press\n"
		+ "ev_global_middle_press\n"
		+ "ev_global_left_release\n"
		+ "ev_global_right_release\n"
		+ "ev_global_middle_release\n"
		+ "ev_joystick1_left\n"
		+ "ev_joystick1_right\n"
		+ "ev_joystick1_up\n"
		+ "ev_joystick1_down\n"
		+ "ev_joystick1_button1\n"
		+ "ev_joystick1_button2\n"
		+ "ev_joystick1_button3\n"
		+ "ev_joystick1_button4\n"
		+ "ev_joystick1_button5\n"
		+ "ev_joystick1_button6\n"
		+ "ev_joystick1_button7\n"
		+ "ev_joystick1_button8\n"
		+ "ev_joystick2_left\n"
		+ "ev_joystick2_right\n"
		+ "ev_joystick2_up\n"
		+ "ev_joystick2_down\n"
		+ "ev_joystick2_button1\n"
		+ "ev_joystick2_button2\n"
		+ "ev_joystick2_button3\n"
		+ "ev_joystick2_button4\n"
		+ "ev_joystick2_button5\n"
		+ "ev_joystick2_button6\n"
		+ "ev_joystick2_button7\n"
		+ "ev_joystick2_button8\n"
		+ "ev_outside\n"
		+ "ev_boundary\n"
		+ "ev_game_start\n"
		+ "ev_game_end\n"
		+ "ev_room_start\n"
		+ "ev_room_end\n"
		+ "ev_no_more_lives\n"
		+ "ev_animation_end\n"
		+ "ev_end_of_path\n"
		+ "ev_no_more_health\n"
		+ "ev_user0\n"
		+ "ev_user1\n"
		+ "ev_user2\n"
		+ "ev_user3\n"
		+ "ev_user4\n"
		+ "ev_user5\n"
		+ "ev_user6\n"
		+ "ev_user7\n"
		+ "ev_user8\n"
		+ "ev_user9\n"
		+ "ev_user10\n"
		+ "ev_user11\n"
		+ "ev_user12\n"
		+ "ev_user13\n"
		+ "ev_user14\n"
		+ "ev_user15\n"
		+ "ev_outside_view0\n"
		+ "ev_outside_view1\n"
		+ "ev_outside_view2\n"
		+ "ev_outside_view3\n"
		+ "ev_outside_view4\n"
		+ "ev_outside_view5\n"
		+ "ev_outside_view6\n"
		+ "ev_outside_view7\n"
		+ "ev_boundary_view0\n"
		+ "ev_boundary_view1\n"
		+ "ev_boundary_view2\n"
		+ "ev_boundary_view3\n"
		+ "ev_boundary_view4\n"
		+ "ev_boundary_view5\n"
		+ "ev_boundary_view6\n"
		+ "ev_boundary_view7\n"
		+ "ev_animation_update\n"
		+ "ev_animation_event\n"
		+ "ev_web_image_load\n"
		+ "ev_web_sound_load\n"
		+ "ev_web_async\n"
		+ "ev_dialog_async\n"
		+ "ev_web_iap\n"
		+ "ev_web_cloud\n"
		+ "ev_web_networking\n"
		+ "ev_web_steam\n"
		+ "ev_social\n"
		+ "ev_push_notification\n"
		+ "ev_async_save_load\n"
		+ "ev_audio_recording\n"
		+ "ev_audio_playback\n"
		+ "ev_system_event\n"
		+ "ev_broadcast_message\n"
		+ "ev_step_normal\n"
		+ "ev_step_begin\n"
		+ "ev_step_end\n"
		+ "ev_gui\n"
		+ "ev_gui_begin\n"
		+ "ev_gui_end\n"
		+ "ev_cleanup\n"
		+ "ev_gesture\n"
		+ "ev_gesture_tap\n"
		+ "ev_gesture_double_tap\n"
		+ "ev_gesture_drag_start\n"
		+ "ev_gesture_dragging\n"
		+ "ev_gesture_drag_end\n"
		+ "ev_gesture_flick\n"
		+ "ev_gesture_pinch_start\n"
		+ "ev_gesture_pinch_in\n"
		+ "ev_gesture_pinch_out\n"
		+ "ev_gesture_pinch_end\n"
		+ "ev_gesture_rotate_start\n"
		+ "ev_gesture_rotating\n"
		+ "ev_gesture_rotate_end\n"
		+ "ev_global_gesture_tap\n"
		+ "ev_global_gesture_double_tap\n"
		+ "ev_global_gesture_drag_start\n"
		+ "ev_global_gesture_dragging\n"
		+ "ev_global_gesture_drag_end\n"
		+ "ev_global_gesture_flick\n"
		+ "ev_global_gesture_pinch_start\n"
		+ "ev_global_gesture_pinch_in\n"
		+ "ev_global_gesture_pinch_out\n"
		+ "ev_global_gesture_pinch_end\n"
		+ "ev_global_gesture_rotate_start\n"
		+ "ev_global_gesture_rotating\n"
		+ "ev_global_gesture_rotate_end\n"
		+ "ev_async_web_image_load\n"
		+ "ev_async_web\n"
		+ "ev_async_dialog\n"
		+ "ev_async_web_iap\n"
		+ "ev_async_web_cloud\n"
		+ "ev_async_web_networking\n"
		+ "ev_async_web_steam\n"
		+ "ev_async_social\n"
		+ "ev_async_push_notification\n"
		+ "ev_async_save_load\n"
		+ "ev_async_audio_recording\n"
		+ "ev_async_audio_playback\n"
		+ "ev_async_system_event\n"
		+ "vk_nokey\n"
		+ "vk_anykey\n"
		+ "vk_enter\n"
		+ "vk_return\n"
		+ "vk_shift\n"
		+ "vk_control\n"
		+ "vk_alt\n"
		+ "vk_escape\n"
		+ "vk_space\n"
		+ "vk_backspace\n"
		+ "vk_tab\n"
		+ "vk_pause\n"
		+ "vk_printscreen\n"
		+ "vk_left\n"
		+ "vk_right\n"
		+ "vk_up\n"
		+ "vk_down\n"
		+ "vk_home\n"
		+ "vk_end\n"
		+ "vk_delete\n"
		+ "vk_insert\n"
		+ "vk_pageup\n"
		+ "vk_pagedown\n"
		+ "vk_f1\n"
		+ "vk_f2\n"
		+ "vk_f3\n"
		+ "vk_f4\n"
		+ "vk_f5\n"
		+ "vk_f6\n"
		+ "vk_f7\n"
		+ "vk_f8\n"
		+ "vk_f9\n"
		+ "vk_f10\n"
		+ "vk_f11\n"
		+ "vk_f12\n"
		+ "vk_numpad0\n"
		+ "vk_numpad1\n"
		+ "vk_numpad2\n"
		+ "vk_numpad3\n"
		+ "vk_numpad4\n"
		+ "vk_numpad5\n"
		+ "vk_numpad6\n"
		+ "vk_numpad7\n"
		+ "vk_numpad8\n"
		+ "vk_numpad9\n"
		+ "vk_divide\n"
		+ "vk_multiply\n"
		+ "vk_subtract\n"
		+ "vk_add\n"
		+ "vk_decimal\n"
		+ "vk_lshift\n"
		+ "vk_lcontrol\n"
		+ "vk_lalt\n"
		+ "vk_rshift\n"
		+ "vk_rcontrol\n"
		+ "vk_ralt\n"
		+ "mb_any\n"
		+ "mb_none\n"
		+ "mb_left\n"
		+ "mb_right\n"
		+ "mb_middle\n"
		+ "mb_side1\n"
		+ "mb_side2\n"
		+ "bboxmode_automatic\n"
		+ "bboxmode_fullimage\n"
		+ "bboxmode_manual\n"
		+ "bboxkind_precise\n"
		+ "bboxkind_rectangular\n"
		+ "bboxkind_ellipse\n"
		+ "bboxkind_diamond\n"
		+ "c_aqua\n"
		+ "c_black\n"
		+ "c_blue\n"
		+ "c_dkgray\n"
		+ "c_dkgrey\n"
		+ "c_fuchsia\n"
		+ "c_gray\n"
		+ "c_grey\n"
		+ "c_green\n"
		+ "c_lime\n"
		+ "c_ltgray\n"
		+ "c_ltgrey\n"
		+ "c_maroon\n"
		+ "c_navy\n"
		+ "c_olive\n"
		+ "c_purple\n"
		+ "c_red\n"
		+ "c_silver\n"
		+ "c_teal\n"
		+ "c_white\n"
		+ "c_yellow\n"
		+ "c_orange\n"
		+ "fa_left\n"
		+ "fa_center\n"
		+ "fa_right\n"
		+ "fa_top\n"
		+ "fa_middle\n"
		+ "fa_bottom\n"
		+ "pr_pointlist\n"
		+ "pr_linelist\n"
		+ "pr_linestrip\n"
		+ "pr_trianglelist\n"
		+ "pr_trianglestrip\n"
		+ "pr_trianglefan\n"
		+ "bm_normal\n"
		+ "bm_add\n"
		+ "bm_max\n"
		+ "bm_subtract\n"
		+ "bm_zero\n"
		+ "bm_one\n"
		+ "bm_src_colour\n"
		+ "bm_inv_src_colour\n"
		+ "bm_src_color\n"
		+ "bm_inv_src_color\n"
		+ "bm_src_alpha\n"
		+ "bm_inv_src_alpha\n"
		+ "bm_dest_alpha\n"
		+ "bm_inv_dest_alpha\n"
		+ "bm_dest_colour\n"
		+ "bm_inv_dest_colour\n"
		+ "bm_dest_color\n"
		+ "bm_inv_dest_color\n"
		+ "bm_src_alpha_sat\n"
		+ "tf_point\n"
		+ "tf_linear\n"
		+ "tf_anisotropic\n"
		+ "mip_off\n"
		+ "mip_on\n"
		+ "mip_markedonly\n"
		+ "audio_falloff_none\n"
		+ "audio_falloff_inverse_distance\n"
		+ "audio_falloff_inverse_distance_clamped\n"
		+ "audio_falloff_linear_distance\n"
		+ "audio_falloff_linear_distance_clamped\n"
		+ "audio_falloff_exponent_distance\n"
		+ "audio_falloff_exponent_distance_clamped\n"
		+ "audio_mono\n"
		+ "audio_stereo\n"
		+ "audio_3d\n"
		+ "cr_default\n"
		+ "cr_none\n"
		+ "cr_arrow\n"
		+ "cr_cross\n"
		+ "cr_beam\n"
		+ "cr_size_nesw\n"
		+ "cr_size_ns\n"
		+ "cr_size_nwse\n"
		+ "cr_size_we\n"
		+ "cr_uparrow\n"
		+ "cr_hourglass\n"
		+ "cr_drag\n"
		+ "cr_appstart\n"
		+ "cr_handpoint\n"
		+ "cr_size_all\n"
		+ "spritespeed_framespersecond\n"
		+ "spritespeed_framespergameframe\n"
		+ "asset_object\n"
		+ "asset_unknown\n"
		+ "asset_sprite\n"
		+ "asset_sound\n"
		+ "asset_room\n"
		+ "asset_path\n"
		+ "asset_script\n"
		+ "asset_font\n"
		+ "asset_timeline\n"
		+ "asset_tiles\n"
		+ "asset_shader\n"
		+ "asset_sequence\n"
		+ "asset_animationcurve\n"
		+ "fa_readonly\n"
		+ "fa_hidden\n"
		+ "fa_sysfile\n"
		+ "fa_volumeid\n"
		+ "fa_directory\n"
		+ "fa_archive\n"
		+ "ds_type_map\n"
		+ "ds_type_list\n"
		+ "ds_type_stack\n"
		+ "ds_type_queue\n"
		+ "ds_type_grid\n"
		+ "ds_type_priority\n"
		+ "ef_explosion\n"
		+ "ef_ring\n"
		+ "ef_ellipse\n"
		+ "ef_firework\n"
		+ "ef_smoke\n"
		+ "ef_smokeup\n"
		+ "ef_star\n"
		+ "ef_spark\n"
		+ "ef_flare\n"
		+ "ef_cloud\n"
		+ "ef_rain\n"
		+ "ef_snow\n"
		+ "pt_shape_pixel\n"
		+ "pt_shape_disk\n"
		+ "pt_shape_square\n"
		+ "pt_shape_line\n"
		+ "pt_shape_star\n"
		+ "pt_shape_circle\n"
		+ "pt_shape_ring\n"
		+ "pt_shape_sphere\n"
		+ "pt_shape_flare\n"
		+ "pt_shape_spark\n"
		+ "pt_shape_explosion\n"
		+ "pt_shape_cloud\n"
		+ "pt_shape_smoke\n"
		+ "pt_shape_snow\n"
		+ "ps_distr_linear\n"
		+ "ps_distr_gaussian\n"
		+ "ps_distr_invgaussian\n"
		+ "ps_shape_rectangle\n"
		+ "ps_shape_ellipse\n"
		+ "ps_shape_diamond\n"
		+ "ps_shape_line\n"
		+ "matrix_view\n"
		+ "matrix_projection\n"
		+ "matrix_world\n"
		+ "os_windows\n"
		+ "os_macosx\n"
		+ "os_ios\n"
		+ "os_android\n"
		+ "os_linux\n"
		+ "os_unknown\n"
		+ "os_ps4\n"
		+ "os_tvos\n"
		+ "os_switch\n"
		+ "os_ps5\n"
		+ "os_xboxseriesxs\n"
		+ "os_operagx\n"
		+ "browser_not_a_browser\n"
		+ "browser_unknown\n"
		+ "browser_ie\n"
		+ "browser_firefox\n"
		+ "browser_chrome\n"
		+ "browser_safari\n"
		+ "browser_safari_mobile\n"
		+ "browser_opera\n"
		+ "browser_tizen\n"
		+ "browser_edge\n"
		+ "browser_windows_store\n"
		+ "browser_ie_mobile\n"
		+ "device_ios_unknown\n"
		+ "device_ios_iphone\n"
		+ "device_ios_iphone_retina\n"
		+ "device_ios_ipad\n"
		+ "device_ios_ipad_retina\n"
		+ "device_ios_iphone5\n"
		+ "device_ios_iphone6\n"
		+ "device_ios_iphone6plus\n"
		+ "device_emulator\n"
		+ "device_tablet\n"
		+ "display_landscape\n"
		+ "display_landscape_flipped\n"
		+ "display_portrait\n"
		+ "display_portrait_flipped\n"
		+ "tm_sleep\n"
		+ "tm_countvsyncs\n"
		+ "of_challenge_win\n"
		+ "of_challenge_lose\n"
		+ "of_challenge_tie\n"
		+ "cmpfunc_never\n"
		+ "cmpfunc_less\n"
		+ "cmpfunc_equal\n"
		+ "cmpfunc_lessequal\n"
		+ "cmpfunc_greater\n"
		+ "cmpfunc_notequal\n"
		+ "cmpfunc_greaterequal\n"
		+ "cmpfunc_always\n"
		+ "cull_noculling\n"
		+ "cull_clockwise\n"
		+ "cull_counterclockwise\n"
		+ "lighttype_dir\n"
		+ "lighttype_point\n"
		+ "phy_joint_anchor_1_x\n"
		+ "phy_joint_anchor_1_y\n"
		+ "phy_joint_anchor_2_x\n"
		+ "phy_joint_anchor_2_y\n"
		+ "phy_joint_reaction_force_x\n"
		+ "phy_joint_reaction_force_y\n"
		+ "phy_joint_reaction_torque\n"
		+ "phy_joint_motor_speed\n"
		+ "phy_joint_angle\n"
		+ "phy_joint_motor_torque\n"
		+ "phy_joint_max_motor_torque\n"
		+ "phy_joint_translation\n"
		+ "phy_joint_speed\n"
		+ "phy_joint_motor_force\n"
		+ "phy_joint_max_motor_force\n"
		+ "phy_joint_length_1\n"
		+ "phy_joint_length_2\n"
		+ "phy_joint_damping_ratio\n"
		+ "phy_joint_frequency\n"
		+ "phy_joint_lower_angle_limit\n"
		+ "phy_joint_upper_angle_limit\n"
		+ "phy_joint_angle_limits\n"
		+ "phy_joint_max_length\n"
		+ "phy_joint_max_torque\n"
		+ "phy_joint_max_force\n"
		+ "phy_debug_render_aabb\n"
		+ "phy_debug_render_collision_pairs\n"
		+ "phy_debug_render_coms\n"
		+ "phy_debug_render_core_shapes\n"
		+ "phy_debug_render_joints\n"
		+ "phy_debug_render_obb\n"
		+ "phy_debug_render_shapes\n"
		+ "phy_particle_flag_water\n"
		+ "phy_particle_flag_zombie\n"
		+ "phy_particle_flag_wall\n"
		+ "phy_particle_flag_spring\n"
		+ "phy_particle_flag_elastic\n"
		+ "phy_particle_flag_viscous\n"
		+ "phy_particle_flag_powder\n"
		+ "phy_particle_flag_tensile\n"
		+ "phy_particle_flag_colourmixing\n"
		+ "phy_particle_group_flag_solid\n"
		+ "phy_particle_group_flag_rigid\n"
		+ "phy_particle_data_flag_typeflags\n"
		+ "phy_particle_data_flag_position\n"
		+ "phy_particle_data_flag_velocity\n"
		+ "phy_particle_data_flag_colour\n"
		+ "phy_particle_data_flag_category\n"
		+ "network_socket_tcp\n"
		+ "network_socket_udp\n"
		+ "network_socket_ws\n"
		+ "network_socket_bluetooth\n"
		+ "network_type_connect\n"
		+ "network_type_disconnect\n"
		+ "network_type_data\n"
		+ "network_type_non_blocking_connect\n"
		+ "network_config_connect_timeout\n"
		+ "network_config_use_non_blocking_socket\n"
		+ "network_config_enable_reliable_udp\n"
		+ "network_config_disable_reliable_udp\n"
		+ "network_config_avoid_time_wait\n"
		+ "buffer_fixed\n"
		+ "buffer_grow\n"
		+ "buffer_wrap\n"
		+ "buffer_fast\n"
		+ "buffer_vbuffer\n"
		+ "buffer_u8\n"
		+ "buffer_s8\n"
		+ "buffer_u16\n"
		+ "buffer_s16\n"
		+ "buffer_u32\n"
		+ "buffer_s32\n"
		+ "buffer_u64\n"
		+ "buffer_f16\n"
		+ "buffer_f32\n"
		+ "buffer_f64\n"
		+ "buffer_bool\n"
		+ "buffer_text\n"
		+ "buffer_string\n"
		+ "buffer_seek_start\n"
		+ "buffer_seek_relative\n"
		+ "buffer_seek_end\n"
		+ "gp_face1\n"
		+ "gp_face2\n"
		+ "gp_face3\n"
		+ "gp_face4\n"
		+ "gp_shoulderl\n"
		+ "gp_shoulderr\n"
		+ "gp_shoulderlb\n"
		+ "gp_shoulderrb\n"
		+ "gp_select\n"
		+ "gp_start\n"
		+ "gp_stickl\n"
		+ "gp_stickr\n"
		+ "gp_padu\n"
		+ "gp_padd\n"
		+ "gp_padl\n"
		+ "gp_padr\n"
		+ "gp_axislh\n"
		+ "gp_axislv\n"
		+ "gp_axisrh\n"
		+ "gp_axisrv\n"
		+ "gp_axis_acceleration_x\n"
		+ "gp_axis_acceleration_y\n"
		+ "gp_axis_acceleration_z\n"
		+ "gp_axis_angular_velocity_x\n"
		+ "gp_axis_angular_velocity_y\n"
		+ "gp_axis_angular_velocity_z\n"
		+ "gp_axis_orientation_x\n"
		+ "gp_axis_orientation_y\n"
		+ "gp_axis_orientation_z\n"
		+ "gp_axis_orientation_w\n"
		+ "vertex_usage_position\n"
		+ "vertex_usage_colour\n"
		+ "vertex_usage_normal\n"
		+ "vertex_usage_texcoord\n"
		+ "vertex_usage_blendweight\n"
		+ "vertex_usage_blendindices\n"
		+ "vertex_usage_psize\n"
		+ "vertex_usage_tangent\n"
		+ "vertex_usage_binormal\n"
		+ "vertex_usage_fog\n"
		+ "vertex_usage_depth\n"
		+ "vertex_usage_sample\n"
		+ "vertex_type_float1\n"
		+ "vertex_type_float2\n"
		+ "vertex_type_float3\n"
		+ "vertex_type_float4\n"
		+ "vertex_type_colour\n"
		+ "vertex_type_ubyte4\n"
		+ "layerelementtype_undefined\n"
		+ "layerelementtype_background\n"
		+ "layerelementtype_instance\n"
		+ "layerelementtype_oldtilemap\n"
		+ "layerelementtype_sprite\n"
		+ "layerelementtype_tilemap\n"
		+ "layerelementtype_particlesystem\n"
		+ "layerelementtype_tile\n"
		+ "layerelementtype_sequence\n"
		+ "tile_rotate\n"
		+ "tile_flip\n"
		+ "tile_mirror\n"
		+ "tile_index_mask\n"
		+ "kbv_type_default\n"
		+ "kbv_type_ascii\n"
		+ "kbv_type_url\n"
		+ "kbv_type_email\n"
		+ "kbv_type_numbers\n"
		+ "kbv_type_phone\n"
		+ "kbv_type_phone_name\n"
		+ "kbv_returnkey_default\n"
		+ "kbv_returnkey_go\n"
		+ "kbv_returnkey_google\n"
		+ "kbv_returnkey_join\n"
		+ "kbv_returnkey_next\n"
		+ "kbv_returnkey_route\n"
		+ "kbv_returnkey_search\n"
		+ "kbv_returnkey_send\n"
		+ "kbv_returnkey_yahoo\n"
		+ "kbv_returnkey_done\n"
		+ "kbv_returnkey_continue\n"
		+ "kbv_returnkey_emergency\n"
		+ "kbv_autocapitalize_none\n"
		+ "kbv_autocapitalize_words\n"
		+ "kbv_autocapitalize_sentences\n"
		+ "kbv_autocapitalize_characters\n"
		+ "os_permission_denied_dont_request\n"
		+ "os_permission_denied\n"
		+ "os_permission_granted\n"
		+ "nineslice_left\n"
		+ "nineslice_top\n"
		+ "nineslice_right\n"
		+ "nineslice_bottom\n"
		+ "nineslice_centre\n"
		+ "nineslice_center\n"
		+ "nineslice_stretch\n"
		+ "nineslice_repeat\n"
		+ "nineslice_mirror\n"
		+ "nineslice_blank\n"
		+ "nineslice_hide\n"
		+ "seqtracktype_graphic\n"
		+ "seqtracktype_audio\n"
		+ "seqtracktype_real\n"
		+ "seqtracktype_color\n"
		+ "seqtracktype_colour\n"
		+ "seqtracktype_bool\n"
		+ "seqtracktype_string\n"
		+ "seqtracktype_sequence\n"
		+ "seqtracktype_clipmask\n"
		+ "seqtracktype_clipmask_mask\n"
		+ "seqtracktype_clipmask_subject\n"
		+ "seqtracktype_group\n"
		+ "seqtracktype_empty\n"
		+ "seqtracktype_spriteframes\n"
		+ "seqtracktype_instance\n"
		+ "seqtracktype_message\n"
		+ "seqtracktype_moment\n"
		+ "seqplay_oneshot\n"
		+ "seqplay_loop\n"
		+ "seqplay_pingpong\n"
		+ "seqdir_right\n"
		+ "seqdir_left\n"
		+ "seqinterpolation_assign\n"
		+ "seqinterpolation_lerp\n"
		+ "seqaudiokey_loop\n"
		+ "seqaudiokey_oneshot\n"
		+ "animcurvetype_linear\n"
		+ "animcurvetype_catmullrom";
	var l_lines=file_text_open_from_string(l_gmlConstNames);
	var l_index=-1;
	while(!file_text_eof(l_lines)){
		var l_name=file_text_read_string(l_lines);
		file_text_readln(l_lines);
		live_api_const_add(l_name,l_gmlConstValues[++l_index]);
	}
	file_text_close(l_lines);
}

if(live_enabled)
function live_preinit_init_new_consts(){
	try{
		live_api_const_add("GM_runtime_type",GM_runtime_type)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("GM_project_filename",GM_project_filename)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("GM_build_type",GM_build_type)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("GM_is_sandboxed",GM_is_sandboxed)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("_GMLINE_",_GMLINE_)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("_GMFILE_",_GMFILE_)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("_GMFUNCTION_",_GMFUNCTION_)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("ev_pre_create",ev_pre_create)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("ev_draw_normal",ev_draw_normal)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("ev_audio_playback_ended",ev_audio_playback_ended)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("ev_async_audio_playback_ended",ev_async_audio_playback_ended)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("debug_input_filter_keyboard",debug_input_filter_keyboard)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("debug_input_filter_mouse",debug_input_filter_mouse)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("debug_input_filter_touch",debug_input_filter_touch)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("m_axisx",m_axisx)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("m_axisy",m_axisy)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("m_axisx_gui",m_axisx_gui)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("m_axisy_gui",m_axisy_gui)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("m_scroll_up",m_scroll_up)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("m_scroll_down",m_scroll_down)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("bboxkind_spine",bboxkind_spine)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("bm_min",bm_min)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("bm_reverse_subtract",bm_reverse_subtract)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("bm_eq_add",bm_eq_add)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("bm_eq_max",bm_eq_max)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("bm_eq_subtract",bm_eq_subtract)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("bm_eq_min",bm_eq_min)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("bm_eq_reverse_subtract",bm_eq_reverse_subtract)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("audio_falloff_inverse_distance_scaled",audio_falloff_inverse_distance_scaled)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("audio_falloff_exponent_distance_scaled",audio_falloff_exponent_distance_scaled)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("surface_rgba8unorm",surface_rgba8unorm)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("surface_r16float",surface_r16float)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("surface_r32float",surface_r32float)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("surface_rgba4unorm",surface_rgba4unorm)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("surface_r8unorm",surface_r8unorm)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("surface_rg8unorm",surface_rg8unorm)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("surface_rgba16float",surface_rgba16float)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("surface_rgba32float",surface_rgba32float)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("video_format_rgba",video_format_rgba)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("video_format_yuv",video_format_yuv)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("video_status_closed",video_status_closed)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("video_status_preparing",video_status_preparing)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("video_status_playing",video_status_playing)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("video_status_paused",video_status_paused)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("sprite_add_ext_error_unknown",sprite_add_ext_error_unknown)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("sprite_add_ext_error_cancelled",sprite_add_ext_error_cancelled)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("sprite_add_ext_error_spritenotfound",sprite_add_ext_error_spritenotfound)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("sprite_add_ext_error_loadfailed",sprite_add_ext_error_loadfailed)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("sprite_add_ext_error_decompressfailed",sprite_add_ext_error_decompressfailed)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("sprite_add_ext_error_setupfailed",sprite_add_ext_error_setupfailed)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("asset_particlesystem",asset_particlesystem)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("fa_none",fa_none)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("ps_mode_stream",ps_mode_stream)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("ps_mode_burst",ps_mode_burst)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("os_gdk",os_gdk)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("os_gxgames",os_gxgames)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("os_switch2",os_switch2)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("tm_systemtiming",tm_systemtiming)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("tm_countvsyncs_winalt",tm_countvsyncs_winalt)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("stencilop_keep",stencilop_keep)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("stencilop_zero",stencilop_zero)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("stencilop_replace",stencilop_replace)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("stencilop_incr_wrap",stencilop_incr_wrap)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("stencilop_decr_wrap",stencilop_decr_wrap)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("stencilop_invert",stencilop_invert)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("stencilop_incr",stencilop_incr)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("stencilop_decr",stencilop_decr)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_socket_wss",network_socket_wss)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_type_up",network_type_up)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_type_up_failed",network_type_up_failed)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_type_down",network_type_down)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_send_binary",network_send_binary)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_send_text",network_send_text)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_config_websocket_protocol",network_config_websocket_protocol)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_config_enable_multicast",network_config_enable_multicast)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_config_disable_multicast",network_config_disable_multicast)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_config_message_size_limit",network_config_message_size_limit)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_connect_none",network_connect_none)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_connect_blocking",network_connect_blocking)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_connect_nonblocking",network_connect_nonblocking)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_connect_active",network_connect_active)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("network_connect_passive",network_connect_passive)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("buffer_error_general",buffer_error_general)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("buffer_error_out_of_space",buffer_error_out_of_space)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("buffer_error_invalid_type",buffer_error_invalid_type)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("gp_home",gp_home)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("gp_extra1",gp_extra1)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("gp_extra2",gp_extra2)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("gp_extra3",gp_extra3)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("gp_extra4",gp_extra4)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("gp_paddler",gp_paddler)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("gp_paddlel",gp_paddlel)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("gp_paddlerb",gp_paddlerb)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("gp_paddlelb",gp_paddlelb)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("gp_touchpadbutton",gp_touchpadbutton)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("gp_extra5",gp_extra5)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("gp_extra6",gp_extra6)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("layerelementtype_text",layerelementtype_text)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("layer_type_unknown",layer_type_unknown)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("layer_type_room",layer_type_room)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("layer_type_ui_viewports",layer_type_ui_viewports)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("layer_type_ui_display",layer_type_ui_display)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("texturegroup_status_unloaded",texturegroup_status_unloaded)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("texturegroup_status_loading",texturegroup_status_loading)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("texturegroup_status_loaded",texturegroup_status_loaded)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("texturegroup_status_fetched",texturegroup_status_fetched)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("textalign_left",textalign_left)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("textalign_center",textalign_center)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("textalign_right",textalign_right)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("textalign_justify",textalign_justify)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("textalign_top",textalign_top)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("textalign_middle",textalign_middle)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("textalign_bottom",textalign_bottom)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("origin_topleft",origin_topleft)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("origin_topcentre",origin_topcentre)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("origin_topright",origin_topright)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("origin_middleleft",origin_middleleft)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("origin_middlecentre",origin_middlecentre)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("origin_middleright",origin_middleright)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("origin_bottomleft",origin_bottomleft)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("origin_bottomcentre",origin_bottomcentre)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("origin_bottomright",origin_bottomright)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("textwrap_default",textwrap_default)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("textwrap_splitwords",textwrap_splitwords)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("seqtracktype_text",seqtracktype_text)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("seqtracktype_particlesystem",seqtracktype_particlesystem)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("seqtracktype_audioeffect",seqtracktype_audioeffect)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("seqtextkey_left",seqtextkey_left)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("seqtextkey_center",seqtextkey_center)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("seqtextkey_right",seqtextkey_right)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("seqtextkey_justify",seqtextkey_justify)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("seqtextkey_top",seqtextkey_top)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("seqtextkey_middle",seqtextkey_middle)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("seqtextkey_bottom",seqtextkey_bottom)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("animcurvetype_bezier",animcurvetype_bezier)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("time_source_global",time_source_global)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("time_source_game",time_source_game)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("time_source_units_seconds",time_source_units_seconds)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("time_source_units_frames",time_source_units_frames)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("time_source_expire_nearest",time_source_expire_nearest)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("time_source_expire_after",time_source_expire_after)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("time_source_state_initial",time_source_state_initial)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("time_source_state_active",time_source_state_active)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("time_source_state_paused",time_source_state_paused)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("time_source_state_stopped",time_source_state_stopped)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("audio_bus_main",audio_bus_main)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("AudioEffectType",AudioEffectType)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("AudioLFOType",AudioLFOType)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("flexpanel_unit",flexpanel_unit)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("flexpanel_position_type",flexpanel_position_type)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("flexpanel_justify",flexpanel_justify)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("flexpanel_direction",flexpanel_direction)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("flexpanel_gutter",flexpanel_gutter)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("flexpanel_display",flexpanel_display)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("flexpanel_flex_direction",flexpanel_flex_direction)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("flexpanel_align",flexpanel_align)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("flexpanel_wrap",flexpanel_wrap)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("flexpanel_edge",flexpanel_edge)
	}catch(l__g){
		
	}
	try{
		live_api_const_add("colspace",colspace)
	}catch(l__g){
		
	}
}

if(live_enabled)
function live_preinit_init_enums(){
	try{
		live_enum_add("AudioEffectType",{
			Bitcrusher:AudioEffectType.Bitcrusher,
			Delay:AudioEffectType.Delay,
			Gain:AudioEffectType.Gain,
			HPF2:AudioEffectType.HPF2,
			LPF2:AudioEffectType.LPF2,
			Reverb1:AudioEffectType.Reverb1,
			Tremolo:AudioEffectType.Tremolo,
			PeakEQ:AudioEffectType.PeakEQ,
			HiShelf:AudioEffectType.HiShelf,
			LoShelf:AudioEffectType.LoShelf,
			EQ:AudioEffectType.EQ,
			Compressor:AudioEffectType.Compressor
		})
	}catch(l__g){
		show_debug_message("Trouble exposing the AudioEffectType enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
	try{
		live_enum_add("AudioLFOType",{
			InvSawtooth:AudioLFOType.InvSawtooth,
			Sawtooth:AudioLFOType.Sawtooth,
			Sine:AudioLFOType.Sine,
			Square:AudioLFOType.Square,
			Triangle:AudioLFOType.Triangle
		})
	}catch(l__g){
		show_debug_message("Trouble exposing the AudioLFOType enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
	try{
		live_enum_add("flexpanel_unit",{point:flexpanel_unit.point,percent:flexpanel_unit.percent,auto:flexpanel_unit.auto})
	}catch(l__g){
		show_debug_message("Trouble exposing the flexpanel_unit enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
	try{
		live_enum_add("flexpanel_position_type",{static:flexpanel_position_type.static,relative:flexpanel_position_type.relative,absolute:flexpanel_position_type.absolute})
	}catch(l__g){
		show_debug_message("Trouble exposing the flexpanel_position_type enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
	try{
		live_enum_add("flexpanel_justify",{
			start:flexpanel_justify.start,
			center:flexpanel_justify.center,
			flex_end:flexpanel_justify.flex_end,
			space_between:flexpanel_justify.space_between,
			space_around:flexpanel_justify.space_around,
			space_evenly:flexpanel_justify.space_evenly
		})
	}catch(l__g){
		show_debug_message("Trouble exposing the flexpanel_justify enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
	try{
		live_enum_add("flexpanel_direction",{inherit:flexpanel_direction.inherit,LTR:flexpanel_direction.LTR,RTL:flexpanel_direction.RTL})
	}catch(l__g){
		show_debug_message("Trouble exposing the flexpanel_direction enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
	try{
		live_enum_add("flexpanel_gutter",{column:flexpanel_gutter.column,row:flexpanel_gutter.row,all_gutters:flexpanel_gutter.all_gutters})
	}catch(l__g){
		show_debug_message("Trouble exposing the flexpanel_gutter enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
	try{
		live_enum_add("flexpanel_display",{flex:flexpanel_display.flex,none:flexpanel_display.none})
	}catch(l__g){
		show_debug_message("Trouble exposing the flexpanel_display enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
	try{
		live_enum_add("flexpanel_flex_direction",{
			column:flexpanel_flex_direction.column,
			column_reverse:flexpanel_flex_direction.column_reverse,
			row:flexpanel_flex_direction.row,
			row_reverse:flexpanel_flex_direction.row_reverse
		})
	}catch(l__g){
		show_debug_message("Trouble exposing the flexpanel_flex_direction enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
	try{
		live_enum_add("flexpanel_align",{
			auto:flexpanel_align.auto,
			flex_start:flexpanel_align.flex_start,
			center:flexpanel_align.center,
			flex_end:flexpanel_align.flex_end,
			stretch:flexpanel_align.stretch,
			baseline:flexpanel_align.baseline,
			space_between:flexpanel_align.space_between,
			space_around:flexpanel_align.space_around,
			space_evenly:flexpanel_align.space_evenly
		})
	}catch(l__g){
		show_debug_message("Trouble exposing the flexpanel_align enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
	try{
		live_enum_add("flexpanel_wrap",{no_wrap:flexpanel_wrap.no_wrap,wrap:flexpanel_wrap.wrap,reverse:flexpanel_wrap.reverse})
	}catch(l__g){
		show_debug_message("Trouble exposing the flexpanel_wrap enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
	try{
		live_enum_add("flexpanel_edge",{
			left:flexpanel_edge.left,
			top:flexpanel_edge.top,
			right:flexpanel_edge.right,
			bottom:flexpanel_edge.bottom,
			start:flexpanel_edge.start,
			_end:flexpanel_edge._end,
			horizontal:flexpanel_edge.horizontal,
			vertical:flexpanel_edge.vertical,
			all_edges:flexpanel_edge.all_edges
		})
	}catch(l__g){
		show_debug_message("Trouble exposing the flexpanel_edge enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
	try{
		live_enum_add("colspace",{
			room:colspace.room,
			ui_view:colspace.ui_view,
			ui_display:colspace.ui_display,
			colspace_all:colspace.colspace_all
		})
	}catch(l__g){
		show_debug_message("Trouble exposing the colspace enum to GMLive:");
		show_debug_message(__lnc__std_haxe_Exception_caught(l__g).native);
	}
}

if(live_enabled)
function live_preinit_init_arrays(){
	live_api_var_add("instance_count*",function(l_set,l_val){
		return instance_count
	});
	live_api_var_add("room_speed",function(l_set,l_val){
		if(l_set){
			room_speed=l_val;
			return undefined;
		} else return room_speed
	});
	live_api_var_add("fps*",function(l_set,l_val){
		return fps
	});
	live_api_var_add("fps_real*",function(l_set,l_val){
		return fps_real
	});
	live_api_var_add("current_time*",function(l_set,l_val){
		return current_time
	});
	live_api_var_add("current_year*",function(l_set,l_val){
		return current_year
	});
	live_api_var_add("current_month*",function(l_set,l_val){
		return current_month
	});
	live_api_var_add("current_day*",function(l_set,l_val){
		return current_day
	});
	live_api_var_add("current_weekday*",function(l_set,l_val){
		return current_weekday
	});
	live_api_var_add("current_hour*",function(l_set,l_val){
		return current_hour
	});
	live_api_var_add("current_minute*",function(l_set,l_val){
		return current_minute
	});
	live_api_var_add("current_second*",function(l_set,l_val){
		return current_second
	});
	live_api_var_add("room",function(l_set,l_val){
		if(l_set){
			room=l_val;
			return undefined;
		} else return room
	});
	live_api_var_add("room_first*",function(l_set,l_val){
		return room_first
	});
	live_api_var_add("room_last*",function(l_set,l_val){
		return room_last
	});
	live_api_var_add("room_width*",function(l_set,l_val){
		return room_width
	});
	live_api_var_add("room_height*",function(l_set,l_val){
		return room_height
	});
	live_api_var_add("room_persistent",function(l_set,l_val){
		if(l_set){
			room_persistent=l_val;
			return undefined;
		} else return room_persistent
	});
	live_api_var_add("score",function(l_set,l_val){
		if(l_set){
			score=l_val;
			return undefined;
		} else return score
	});
	live_api_var_add("lives",function(l_set,l_val){
		if(l_set){
			lives=l_val;
			return undefined;
		} else return lives
	});
	live_api_var_add("health",function(l_set,l_val){
		if(l_set){
			health=l_val;
			return undefined;
		} else return health
	});
	live_api_var_add("event_type*",function(l_set,l_val){
		return event_type
	});
	live_api_var_add("event_number*",function(l_set,l_val){
		return event_number
	});
	live_api_var_add("event_object*",function(l_set,l_val){
		return event_object
	});
	live_api_var_add("event_action*",function(l_set,l_val){
		return event_action
	});
	live_api_var_add("application_surface*",function(l_set,l_val){
		return application_surface
	});
	live_api_var_add("debug_mode*",function(l_set,l_val){
		return debug_mode
	});
	live_api_var_add("font_texture_page_size",function(l_set,l_val){
		if(l_set){
			font_texture_page_size=l_val;
			return undefined;
		} else return font_texture_page_size
	});
	live_api_var_add("keyboard_key",function(l_set,l_val){
		if(l_set){
			keyboard_key=l_val;
			return undefined;
		} else return keyboard_key
	});
	live_api_var_add("keyboard_lastkey",function(l_set,l_val){
		if(l_set){
			keyboard_lastkey=l_val;
			return undefined;
		} else return keyboard_lastkey
	});
	live_api_var_add("keyboard_lastchar",function(l_set,l_val){
		if(l_set){
			keyboard_lastchar=l_val;
			return undefined;
		} else return keyboard_lastchar
	});
	live_api_var_add("keyboard_string",function(l_set,l_val){
		if(l_set){
			keyboard_string=l_val;
			return undefined;
		} else return keyboard_string
	});
	live_api_var_add("mouse_x*",function(l_set,l_val){
		return mouse_x
	});
	live_api_var_add("mouse_y*",function(l_set,l_val){
		return mouse_y
	});
	live_api_var_add("mouse_button",function(l_set,l_val){
		if(l_set){
			mouse_button=l_val;
			return undefined;
		} else return mouse_button
	});
	live_api_var_add("mouse_lastbutton",function(l_set,l_val){
		if(l_set){
			mouse_lastbutton=l_val;
			return undefined;
		} else return mouse_lastbutton
	});
	live_api_var_add("cursor_sprite",function(l_set,l_val){
		if(l_set){
			cursor_sprite=l_val;
			return undefined;
		} else return cursor_sprite
	});
	live_api_var_add("background_colour£",function(l_set,l_val){
		if(l_set){
			background_colour=l_val;
			return undefined;
		} else return background_colour
	});
	live_api_var_add("background_showcolour£",function(l_set,l_val){
		if(l_set){
			background_showcolour=l_val;
			return undefined;
		} else return background_showcolour
	});
	live_api_var_add("background_color$",function(l_set,l_val){
		if(l_set){
			background_color=l_val;
			return undefined;
		} else return background_color
	});
	live_api_var_add("background_showcolor$",function(l_set,l_val){
		if(l_set){
			background_showcolor=l_val;
			return undefined;
		} else return background_showcolor
	});
	live_api_var_add("view_enabled",function(l_set,l_val){
		if(l_set){
			view_enabled=l_val;
			return undefined;
		} else return view_enabled
	});
	live_api_var_add("view_current*",function(l_set,l_val){
		return view_current
	});
	live_api_var_add("view_visible[]",function(l_set,l_val,l_ind){
		if(l_ind<0||l_ind>7)return gml_thread_error("Index ("+string(l_ind)+") is out of range [0..7]");
		if(l_set){
			view_visible[l_ind] = l_val;
			return undefined;
		} else return view_visible[l_ind];
	});
	live_api_var_add("view_xport[]",function(l_set,l_val,l_ind){
		if(l_ind<0||l_ind>7)return gml_thread_error("Index ("+string(l_ind)+") is out of range [0..7]");
		if(l_set){
			view_xport[l_ind] = l_val;
			return undefined;
		} else return view_xport[l_ind];
	});
	live_api_var_add("view_yport[]",function(l_set,l_val,l_ind){
		if(l_ind<0||l_ind>7)return gml_thread_error("Index ("+string(l_ind)+") is out of range [0..7]");
		if(l_set){
			view_yport[l_ind] = l_val;
			return undefined;
		} else return view_yport[l_ind];
	});
	live_api_var_add("view_wport[]",function(l_set,l_val,l_ind){
		if(l_ind<0||l_ind>7)return gml_thread_error("Index ("+string(l_ind)+") is out of range [0..7]");
		if(l_set){
			view_wport[l_ind] = l_val;
			return undefined;
		} else return view_wport[l_ind];
	});
	live_api_var_add("view_hport[]",function(l_set,l_val,l_ind){
		if(l_ind<0||l_ind>7)return gml_thread_error("Index ("+string(l_ind)+") is out of range [0..7]");
		if(l_set){
			view_hport[l_ind] = l_val;
			return undefined;
		} else return view_hport[l_ind];
	});
	live_api_var_add("view_surface_id[]",function(l_set,l_val,l_ind){
		if(l_ind<0||l_ind>7)return gml_thread_error("Index ("+string(l_ind)+") is out of range [0..7]");
		if(l_set){
			view_surface_id[l_ind] = l_val;
			return undefined;
		} else return view_surface_id[l_ind];
	});
	live_api_var_add("view_camera[]",function(l_set,l_val,l_ind){
		if(l_ind<0||l_ind>7)return gml_thread_error("Index ("+string(l_ind)+") is out of range [0..7]");
		if(l_set){
			view_camera[l_ind] = l_val;
			return undefined;
		} else return view_camera[l_ind];
	});
	live_api_var_add("game_id*",function(l_set,l_val){
		return game_id
	});
	live_api_var_add("game_display_name*",function(l_set,l_val){
		return game_display_name
	});
	live_api_var_add("game_project_name*",function(l_set,l_val){
		return game_project_name
	});
	live_api_var_add("game_save_id*",function(l_set,l_val){
		return game_save_id
	});
	live_api_var_add("working_directory*",function(l_set,l_val){
		return working_directory
	});
	live_api_var_add("temp_directory*",function(l_set,l_val){
		return temp_directory
	});
	live_api_var_add("cache_directory*",function(l_set,l_val){
		return cache_directory
	});
	live_api_var_add("program_directory*",function(l_set,l_val){
		return program_directory
	});
	live_api_var_add("browser_width*",function(l_set,l_val){
		return browser_width
	});
	live_api_var_add("browser_height*",function(l_set,l_val){
		return browser_height
	});
	live_api_var_add("os_type*",function(l_set,l_val){
		return os_type
	});
	live_api_var_add("os_device*",function(l_set,l_val){
		return os_device
	});
	live_api_var_add("os_browser*",function(l_set,l_val){
		return os_browser
	});
	live_api_var_add("os_version*",function(l_set,l_val){
		return os_version
	});
	live_api_var_add("display_aa*",function(l_set,l_val){
		return display_aa
	});
	live_api_var_add("async_load*",function(l_set,l_val){
		return async_load
	});
	live_api_var_add("delta_time*",function(l_set,l_val){
		return delta_time
	});
	live_api_var_add("webgl_enabled*",function(l_set,l_val){
		return webgl_enabled
	});
	live_api_var_add("event_data*",function(l_set,l_val){
		return event_data
	});
}

function live_preinit_api(){
	if(live_enabled){
		live_preinit_init_funcs();
		live_preinit_init_consts();
		live_preinit_init_new_consts();
		live_preinit_init_enums();
		live_preinit_init_arrays();
	}
}


