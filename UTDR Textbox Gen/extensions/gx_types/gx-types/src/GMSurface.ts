import { get_function } from "./GMFunctionHandler";

export enum SurfaceFormat {
    Default = 6,
    R8 = 12,
    RG8 = 13,
    RGBA4 = 11,
    RGBA16 = 14,
    R16 = 9,
    RGBA32 = 15,
    R32 = 10,

}

function get_internal_functions() {
    return {
        surface_exists: get_function("surface_exists"),
        surface_create: get_function("surface_create"),
        surface_create_ext: get_function("surface_create_ext"),
        surface_resize: get_function("surface_resize"),
        surface_set_target: get_function("surface_set_target"),
        surface_set_target_ext: get_function("surface_set_target_ext"),
        surface_get_target: get_function("surface_get_target"),
        surface_get_target_depth: get_function("surface_get_target_depth"),
        surface_get_target_ext: get_function("surface_get_target_ext"),
        surface_reset_target: get_function("surface_reset_target"),
        surface_copy: get_function("surface_copy"),
        surface_copy_part: get_function("surface_copy_part"),
        surface_depth_disable: get_function("surface_depth_disable"),
        surface_get_height: get_function("surface_get_height"),
        surface_get_width: get_function("surface_get_width"),
        surface_get_texture: get_function("surface_get_texture"),
        surface_get_texture_depth: get_function("surface_get_texture_depth"),
        surface_get_depth_disable: get_function("surface_get_depth_disable"),
        surface_has_depth: get_function("surface_has_depth"),
        surface_getpixel: get_function("surface_getpixel"),
        surface_getpixel_ext: get_function("surface_getpixel_ext"),
        surface_get_format: get_function("surface_get_format"),
        surface_format_is_supported: get_function("surface_format_is_supported"),
        surface_free: get_function("surface_free"),
        surface_save: get_function("surface_save"),
        surface_save_part: get_function("surface_save_part"),
    }
}

export default class GMSurface {
    ptr: string|null = null;
    constructor(width: number, height: number, format: SurfaceFormat = SurfaceFormat.Default, create = true) {
        if (create) {
            this.ptr = GMSurface.InternalFunctions.surface_create(width,height,format);
        }
    }
    static InternalFunctions = get_internal_functions();
    static init(){
        GMSurface.InternalFunctions = get_internal_functions();
    }
    static from(surface: string) {
        const surf = new GMSurface(1,1,SurfaceFormat.Default,false);
        surf.ptr = surface;
        return surf;
    }
    static get_target() {
        return GMSurface.from(GMSurface.InternalFunctions.surface_get_target());
    }
    static get_target_ext(render_target: 0|1|2|3) {
        return GMSurface.from(GMSurface.InternalFunctions.surface_get_target_ext(render_target));
    }
    static get_target_depth() {
        return GMSurface.from(GMSurface.InternalFunctions.surface_get_target_depth())
    }
    static depth_disable(disable: boolean) {
        return GMSurface.InternalFunctions.surface_depth_disable(disable);
    }
    static get_depth_disable() {
        return !!GMSurface.InternalFunctions.surface_get_depth_disable();
    }
    static format_is_supported(format: SurfaceFormat) {
        return !!GMSurface.InternalFunctions.surface_format_is_supported(format);
    }


    exists() {
        return !!GMSurface.InternalFunctions.surface_exists(this.ptr);
    }
    resize(w: number,h: number){
        return GMSurface.InternalFunctions.surface_resize(this.ptr,w,h);
    }
    set_target() {
        return !!GMSurface.InternalFunctions.surface_set_target(this.ptr);
    }
    set_target_ext(render_target: 0|1|2|3) {
        return !!GMSurface.InternalFunctions.surface_get_target_ext(render_target,this.ptr);
    }
    reset_target() {
        return GMSurface.InternalFunctions.surface_reset_target();
    }
    copy(x:number,y:number,source:GMSurface) {
        return GMSurface.InternalFunctions.surface_copy(this.ptr,x,y,source.ptr);
    }
    copy_part(x: number, y: number, source: GMSurface, source_x: number, source_y: number, width: number, height: number) {
        return GMSurface.InternalFunctions.surface_copy_part(this.ptr,x,y,source.ptr,source_x,source_y,width,height);
    }
    get_height() {
        return GMSurface.InternalFunctions.surface_get_height(this.ptr) as number;
    }
    get_width() {
        return GMSurface.InternalFunctions.surface_get_width(this.ptr) as number;
    }
    get_texture() {
        return GMSurface.InternalFunctions.surface_get_texture(this.ptr) as number;
    }
    get_texture_depth() {
        return GMSurface.InternalFunctions.surface_get_texture_depth(this.ptr) as number;
    }
    has_depth() {
        return !!GMSurface.InternalFunctions.surface_has_depth(this.ptr);
    }
    getpixel(x: number, y: number) {
        const format = this.get_format();
        const out = GMSurface.InternalFunctions.surface_getpixel(x,y);
        if ([SurfaceFormat.Default,SurfaceFormat.RGBA4,SurfaceFormat.R8, SurfaceFormat.RG8].includes(format)) {
            return out as number;
        } else {
            return out as [number,number,number];
        }
    }
    getpixel_ext(x: number, y: number) {
        const format = this.get_format();
        const out = GMSurface.InternalFunctions.surface_getpixel_ext(x,y);
        if ([SurfaceFormat.Default,SurfaceFormat.RGBA4,SurfaceFormat.R8, SurfaceFormat.RG8].includes(format)) {
            return out as number;
        } else {
            return out as [number,number,number,number];
        }
    }
    get_format() {
        return GMSurface.InternalFunctions.surface_get_format(this.ptr) as SurfaceFormat;
    }
    free() {
        GMSurface.InternalFunctions.surface_free(this.ptr);
        this.ptr = null;
    }
    save(fname: string) {
        return GMSurface.InternalFunctions.surface_save(this.ptr,fname);
    }
    save_part(fname: string, x: number, y: number, width: number, height: number) {
        return GMSurface.InternalFunctions.surface_save_part(this.ptr,fname,x,y,width,height);
    }
}