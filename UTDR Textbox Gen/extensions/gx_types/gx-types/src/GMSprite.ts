import { get_function } from "./GMFunctionHandler";
import { AssetType } from "./GMAssets";
import GMSurface from "./GMSurface";

export enum SpeedType {
    FramesPerSecond = 0,
    FramesPerGameFrame = 1,
}

export enum BoundingBoxMode {
    Automatic = 0,
    FullImage = 1,
    Manual = 2,
}

export enum BoundingBoxKind {
    Precise = 0,
    Rectangular = 1,
    Ellipse = 2,
    Diamond = 3,
    Spine = 4,
}

export interface SpriteNineslice {
    left: number;
    top: number;
    right: number;
    bottom: number;
    enabled: number;
    tilemode: [
        number,
        number,
        number,
        number,
        number
    ],
}

function get_internal_functions() {
    return {
        // statics
        sprite_add: get_function("sprite_add"),
        sprite_add_ext: get_function("sprite_add_ext"),
        sprite_create_from_surface: get_function("sprite_create_from_surface"),
        sprite_add_from_surface: get_function("sprite_add_from_surface"),
        // creating/modifying
        sprite_delete: get_function("sprite_delete"),
        sprite_replace: get_function("sprite_replace"),
        sprite_duplicate: get_function("sprite_duplicate"),
        sprite_assign: get_function("sprite_assign"),
        sprite_merge: get_function("sprite_merge"),
        sprite_set_alpha_from_sprite: get_function("sprite_set_alpha_from_sprite"),
        // general
        sprite_exists: get_function("sprite_exists"),
        sprite_get_name: get_function("sprite_get_name"),
        sprite_get_number: get_function("sprite_get_number"),
        sprite_get_speed: get_function("sprite_get_speed"),
        sprite_get_speed_type: get_function("sprite_get_speed_type"),
        sprite_get_width: get_function("sprite_get_width"),
        sprite_get_height: get_function("sprite_get_height"),
        sprite_get_xoffset: get_function("sprite_get_xoffset"),
        sprite_get_yoffset: get_function("sprite_get_yoffset"),
        // collision mask
        sprite_get_bbox_bottom: get_function("sprite_get_bbox_bottom"),
        sprite_get_bbox_left: get_function("sprite_get_bbox_left"),
        sprite_get_bbox_right: get_function("sprite_get_bbox_right"),
        sprite_get_bbox_top: get_function("sprite_get_bbox_top"),
        sprite_get_bbox_mode: get_function("sprite_get_bbox_mode"),
        sprite_get_convex_hull: get_function("sprite_get_convex_hull"),
        // nineslice
        sprite_nineslice_create: get_function("sprite_nineslice_create"),
        sprite_get_nineslice: get_function("sprite_get_nineslice"),
        sprite_set_nineslice: get_function("sprite_set_nineslice"),
        // texture page
        sprite_get_tpe: get_function("sprite_get_tpe"),
        sprite_get_texture: get_function("sprite_get_texture"),
        sprite_get_uvs: get_function("sprite_get_uvs"),
        sprite_get_info: get_function("sprite_get_info"),
        /// manipulation
        // properties
        sprite_collision_mask: get_function("sprite_collision_mask"),
        sprite_set_offset: get_function("sprite_set_offset"),
        sprite_set_bbox_mode: get_function("sprite_set_bbox_mode"),
        sprite_set_bbox: get_function("sprite_set_bbox"),
        sprite_set_speed: get_function("sprite_set_speed"),
        // saving
        sprite_save: get_function("sprite_save"),
        sprite_save_strip: get_function("sprite_save_strip"),
        // blending (html5)
        sprite_set_cache_size: get_function("sprite_set_cache_size"),
        sprite_set_cache_size_ext: get_function("sprite_set_cache_size_ext"),
        // prefetching
        sprite_prefetch: get_function("sprite_prefetch"),
        sprite_prefetch_multi: get_function("sprite_prefetch_multi"),
        sprite_flush: get_function("sprite_flush"),
        sprite_flush_multi: get_function("sprite_flush_multi"),
        // vector sprite caching
        vector_sprite_cache_get_limit: get_function("vector_sprite_cache_get_limit"),
        vector_sprite_cache_get_max_used: get_function("vector_sprite_cache_get_max_used"),
        vector_sprite_cache_get_oldest_entry_age: get_function("vector_sprite_cache_get_oldest_entry_age"),
        vector_sprite_cache_get_prune_age: get_function("vector_sprite_cache_get_prune_age"),
        vector_sprite_cache_get_prune_fraction: get_function("vector_sprite_cache_get_prune_fraction"),
        vector_sprite_cache_get_used: get_function("vector_sprite_cache_get_used"),
        vector_sprite_cache_limit: get_function("vector_sprite_cache_limit"),
        vector_sprite_cache_prune_age: get_function("vector_sprite_cache_prune_age"),
        vector_sprite_cache_prune_fraction: get_function("vector_sprite_cache_prune_fraction"),
        /// drawing
        draw_sprite: get_function("draw_sprite"),
        draw_sprite_ext: get_function("draw_sprite_ext"),
        draw_sprite_general: get_function("draw_sprite_general"),
        draw_sprite_part: get_function("draw_sprite_part"),
        draw_sprite_part_ext: get_function("draw_sprite_part_ext"),
        draw_sprite_stretched: get_function("draw_sprite_stretched"),
        draw_sprite_stretched_ext: get_function("draw_sprite_stretched_ext"),
        draw_sprite_pos: get_function("draw_sprite_pos"),
        draw_sprite_tiled: get_function("draw_sprite_tiled"),
        draw_sprite_tiled_ext: get_function("draw_sprite_tiled_ext"),
        // global sprite aa options
        draw_enable_swf_aa: get_function("draw_enable_swf_aa"),
        draw_set_swf_aa_level: get_function("draw_set_swf_aa_level"),
        draw_get_swf_aa_level: get_function("draw_get_swf_aa_level"),
        draw_enable_svg_aa: get_function("draw_enable_svg_aa"),
        draw_set_svg_aa_level: get_function("draw_set_svg_aa_level"),
        draw_get_svg_aa_level: get_function("draw_get_svg_aa_level"),
        // retrieval
        asset_get_index: get_function("asset_get_index"),
    }
}

export default class GMSprite {
    ptr: string | null = null
    constructor(create=true) {
        if (create == true) {
            // can't easily create a sprite
            // require GMSprite.from for consistency?
        }
    }
    static InternalFunctions = get_internal_functions();
    static init(){
        GMSprite.InternalFunctions = get_internal_functions();
    }
    static from(name_or_handle: string) {
        const spr = new GMSprite(false);
        const id = GMSprite.InternalFunctions.asset_get_index(name_or_handle) as string | number;
        if (id == -1) {
            // failed
            return null;
        } else {
            spr.ptr = id as string;
            return spr;
        }
    }
    static add(fname: string, imgnum: number, removeback: boolean, smooth: boolean, xorigin: number, yorigin: number) {
        const id = GMSprite.InternalFunctions.sprite_add(fname,imgnum,removeback,smooth,xorigin,yorigin) as string;
        return GMSprite.from(id);
    }
    static add_ext(fname: string, imgnum: number, xorigin: number, yorigin: number, prefetch: boolean) {
        const id = GMSprite.InternalFunctions.sprite_add_ext(fname,imgnum,xorigin,yorigin,prefetch) as string;
        return GMSprite.from(id)
    }
    static from_surface(surface: GMSurface, x: number, y: number, width: number, height: number, removeback: boolean, smooth: boolean, xorigin: number, yorigin: number) {
        const id = GMSprite.InternalFunctions.sprite_create_from_surface(surface.ptr,x,y,width,height,removeback,smooth,xorigin,yorigin);
        return GMSprite.from(id);
    }
    static create_nineslice() {
        return GMSprite.InternalFunctions.sprite_nineslice_create() as SpriteNineslice;
    }
    
    // general
    exists() {
        return !!GMSprite.InternalFunctions.sprite_exists(this.ptr);
    }
    get_name() {
        return GMSprite.InternalFunctions.sprite_get_name(this.ptr) as string;
    }
    get_number() {
        return GMSprite.InternalFunctions.sprite_get_number(this.ptr) as number;
    }
    get_speed() {
        return GMSprite.InternalFunctions.sprite_get_speed(this.ptr) as number;
    }
    get_speed_type() {
        return GMSprite.InternalFunctions.sprite_get_speed_type(this.ptr) as SpeedType;
    }
    get_width() {
        return GMSprite.InternalFunctions.sprite_get_width(this.ptr) as number;
    }
    get_height() {
        return GMSprite.InternalFunctions.sprite_get_height(this.ptr) as number;
    }
    get_xoffset() {
        return GMSprite.InternalFunctions.sprite_get_xoffset(this.ptr) as number;
    }
    get_yoffset() {
        return GMSprite.InternalFunctions.sprite_get_yoffset(this.ptr) as number;
    }
    
    // modification
    delete() {
        return !!GMSprite.InternalFunctions.sprite_delete(this.ptr);
    }
    replace(fname: string, imgnum: number, removeback: boolean, smooth :boolean, xorigin: number, yorigin: number) {
        return GMSprite.InternalFunctions.sprite_replace(this.ptr,fname,imgnum,removeback,smooth,xorigin,yorigin);
    }
    duplicate() {
        return GMSprite.from(GMSprite.InternalFunctions.sprite_duplicate(this.ptr));
    }
    assign(sprite: GMSprite | string) {
        if (typeof(sprite) != 'string') {
            sprite = sprite.ptr!;
        }
        return GMSprite.InternalFunctions.sprite_assign(this.ptr,sprite);
    }
    merge(sprite: GMSprite | string) {
        if (typeof(sprite) != 'string') {
            sprite = sprite.ptr!;
        }
        return GMSprite.InternalFunctions.sprite_merge(this.ptr,sprite);
    }
    set_alpha_from_sprite(sprite: GMSprite | string) {
        if (typeof(sprite) != 'string') {
            sprite = sprite.ptr!;
        }
        return GMSprite.InternalFunctions.sprite_set_alpha_from_sprite(this.ptr,sprite);
    }
    add_from_surface(surface: GMSurface, x: number, y: number, width: number, height: number, removeback: boolean, smooth: boolean) {
        return GMSprite.InternalFunctions.sprite_add_from_surface(this.ptr,surface.ptr,x,y,width,height,removeback,smooth);
    }
    get_bbox_bottom(){
        return GMSprite.InternalFunctions.sprite_get_bbox_bottom(this.ptr) as number;
    }
    get_bbox_left(){
        return GMSprite.InternalFunctions.sprite_get_bbox_left(this.ptr) as number;
    }
    get_bbox_top(){
        return GMSprite.InternalFunctions.sprite_get_bbox_top(this.ptr) as number;
    }
    get_bbox_right(){
        return GMSprite.InternalFunctions.sprite_get_bbox_right(this.ptr) as number;
    }
    get_bbox_mode() {
        return GMSprite.InternalFunctions.sprite_get_bbox_mode(this.ptr) as BoundingBoxMode;
    }
    get_convex_hull(max_points?: number, subimg?: number) {
        return GMSprite.InternalFunctions.sprite_get_convex_hull(this.ptr,max_points,subimg) as number[];
    }
    get_nineslice(){
        return GMSprite.InternalFunctions.sprite_get_nineslice(this.ptr) as SpriteNineslice;
    }
    set_nineslice(nineslice: SpriteNineslice) {
        return GMSprite.InternalFunctions.sprite_set_nineslice(this.ptr,nineslice);
    }
    get_tpe(subimage: number) {
        return GMSprite.InternalFunctions.sprite_get_tpe(this.ptr,subimage);
    }
    get_texture(subimage: number) {
        return GMSprite.InternalFunctions.sprite_get_texture(this.ptr,subimage);
    }
    get_uvs(subimage: number) {
        return GMSprite.InternalFunctions.sprite_get_uvs(this.ptr,subimage);
    }
    get_info() {
        return GMSprite.InternalFunctions.sprite_get_info(this.ptr) as Object;
    }
    set_collision_mask(sepmasks: boolean, mode: BoundingBoxMode, left: number, top: number, right: number, bottom: number, kind: BoundingBoxKind, tolerance: number ) {
        return GMSprite.InternalFunctions.sprite_collision_mask(sepmasks,mode,left,top,right,bottom,kind,tolerance)
    }
    set_offset(x: number, y: number) {
        return GMSprite.InternalFunctions.sprite_set_offset(this.ptr,x,y);
    }
    set_bbox_mode(mode: BoundingBoxMode) {
        return GMSprite.InternalFunctions.sprite_set_bbox_mode(this.ptr,mode);
    }
    set_bbox(left: number, top: number, right: number, bottom: number) {
        return GMSprite.InternalFunctions.sprite_set_bbox(this.ptr,left,top,right,bottom);
    }
    set_speed(speed: number,type: SpeedType) {
        return GMSprite.InternalFunctions.sprite_set_speed(speed,type);
    }
    save(subimage: number, fname: string) {
        return GMSprite.InternalFunctions.sprite_save(this.ptr,subimage,fname);
    }
    save_strip(fname: string) {
        return GMSprite.InternalFunctions.sprite_save_strip(this.ptr,fname);
    }
    draw(subimage: number, x: number, y: number) {
        return GMSprite.InternalFunctions.draw_sprite(this.ptr,subimage,x,y);
    }
    draw_ext(subimage: number, x: number, y: number, xscale: number, yscale: number, angle: number, colour: number, alpha: number) {
        return GMSprite.InternalFunctions.draw_sprite_ext(this.ptr, subimage,x,y,xscale,yscale,angle,colour,alpha);
    }
    draw_general(subimage: number, left: number, top: number, width: number, height: number, x: number, y: number, xscale: number, yscale: number, angle: number, col1: number, col2: number, col3: number, col4: number, alpha: number) {
        return GMSprite.InternalFunctions.draw_sprite_general(this.ptr, subimage,left,top,width,height,x,y,xscale,yscale,angle,col1,col2,col3,col4,alpha);
    }
    draw_part(subimage: number, left: number, top: number, width: number, height: number, x: number, y: number) {
        return GMSprite.InternalFunctions.draw_sprite_part(this.ptr,subimage,left,top,width,height,x,y);
    }
    draw_part_ext(subimage: number, left: number, top: number, width: number, height: number, x: number, y: number, xscale: number, yscale: number, colour: number, alpha: number) {
        return GMSprite.InternalFunctions.draw_sprite_part_ext(this.ptr,subimage,left,top,width,height,x,y,xscale,yscale,colour,alpha);
    }
    draw_stretched(subimage: number, x: number, y: number, width: number, height: number) {
        return GMSprite.InternalFunctions.draw_sprite_stretched(this.ptr,subimage,x,y,width,height);
    }
    draw_stretched_ext(subimage: number, x: number, y: number, width: number, height: number,colour: number, alpha: number) {
        return GMSprite.InternalFunctions.draw_sprite_stretched_ext(this.ptr,subimage,x,y,width,height,colour,alpha);
    }
    draw_pos(subimage: number, x1: number, y1: number, x2: number, y2: number, x3: number, y3: number, x4: number, y4: number, alpha: number) {
        return GMSprite.InternalFunctions.draw_sprite_pos(this.ptr,subimage,x1,y1,x2,y2,x3,y3,x4,y4,alpha);
    }
    draw_tiled(subimage: number, x: number, y: number) {
        return GMSprite.InternalFunctions.draw_sprite_tiled(this.ptr,subimage,x,y);
    }
    draw_tiled_ext(subimage: number, x: number, y: number, xscale: number, yscale: number, colour: number, alpha: number) {
        return GMSprite.InternalFunctions.draw_sprite_tiled_ext(this.ptr,subimage,x,y,xscale,yscale,colour,alpha);
    }

}