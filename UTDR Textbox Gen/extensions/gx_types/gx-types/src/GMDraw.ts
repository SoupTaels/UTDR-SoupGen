import { get_function } from "./GMFunctionHandler";


function get_internal_functions() {
    return {
        draw_arrow: get_function("draw_arrow"),
        draw_circle: get_function("draw_circle"),
        draw_circle_colour: get_function("draw_circle_colour"),
        draw_ellipse: get_function("draw_ellipse"),
        draw_ellipse_colour: get_function("draw_ellipse_colour"),
        draw_line: get_function("draw_line"),
        draw_line_colour: get_function("draw_line_colour"),
        draw_line_width: get_function("draw_line_width"),
        draw_line_width_colour: get_function("draw_line_width_colour"),
        draw_point: get_function("draw_point"),
        draw_point_colour: get_function("draw_point_colour"),
        draw_rectangle: get_function("draw_rectangle"),
        draw_rectangle_colour: get_function("draw_rectangle_colour"),
        draw_roundrect: get_function("draw_roundrect"),
        draw_roundrect_colour: get_function("draw_roundrect_colour"),
        draw_roundrect_ext: get_function("draw_roundrect_ext"),
        draw_roundrect_colour_ext: get_function("draw_roundrect_colour_ext"),
        draw_triangle: get_function("draw_triangle"),
        draw_triangle_colour: get_function("draw_triangle_colour"),

        draw_clear: get_function("draw_clear"),
        draw_clear_alpha: get_function("draw_clear_alpha"),
        draw_set_alpha: get_function("draw_set_alpha"),
        draw_set_colour: get_function("draw_set_colour"),

        draw_getpixel: get_function("draw_getpixel"),
        draw_getpixel_ext: get_function("draw_getpixel_ext"),
        draw_get_colour: get_function("draw_get_colour"),
        draw_get_alpha: get_function("draw_get_alpha"),

        draw_enable_swf_aa: get_function("draw_enable_swf_aa"),
        draw_set_swf_aa_level: get_function("draw_set_swf_aa_level"),
        draw_get_swf_aa_level: get_function("draw_get_swf_aa_level"),
        draw_enable_svg_aa: get_function("draw_enable_svg_aa"),
        draw_set_svg_aa_level: get_function("draw_set_svg_aa_level"),
        draw_get_svg_aa_level: get_function("draw_get_svg_aa_level"),
    };
}

export default class GMDraw {
    static InternalFunctions = get_internal_functions();
    static init() {
        this.InternalFunctions = get_internal_functions();
    }
    static arrow(x1: number, y1: number, x2: number, y2: number, size: number) {
        return GMDraw.InternalFunctions.draw_arrow(x1,y1,x2,y2,size);
    }
    static circle(x: number, y: number, radius: number, outline: boolean) {
        return GMDraw.InternalFunctions.draw_circle(x,y,radius,outline);
    }
    static circle_color(x: number, y: number, radius: number, col1: number, col2: number, outline: boolean) {
        return GMDraw.InternalFunctions.draw_circle_colour(x,y,radius,col1,col2,outline);
    }
    static ellipse(x1: number, y1: number, x2: number, y2: number, outline: boolean) {
        return GMDraw.InternalFunctions.draw_ellipse(x1,y1,x2,y2,outline);
    }
    static ellipse_color(x1: number, y1: number, x2: number, y2: number, col1: number, col2: number, outline:boolean) {
        return GMDraw.InternalFunctions.draw_ellipse_colour(x1,y1,x2,y2,col1,col2,outline);
    }
    static line(x1: number,y1: number,x2: number,y2: number) {
        return GMDraw.InternalFunctions.draw_line(x1,y1,x2,y2);
    }
    static line_color(x1: number,y1: number,x2: number,y2: number,col1: number, col2: number) {
        return GMDraw.InternalFunctions.draw_line_colour(x1,y1,x2,y2,col1,col2);
    }
    static line_width(x1: number, y1: number, x2: number, y2: number, width: number) {
        return GMDraw.InternalFunctions.draw_line_width(x1,y1,x2,y2,width);
    }
    static line_width_color(x1: number, y1: number, x2: number, y2: number, width: number, col1: number, col2: number) {
        return GMDraw.InternalFunctions.draw_line_width(x1,y1,x2,y2,width,col1,col2);
    }
    static point(x: number,y: number) {
        return GMDraw.InternalFunctions.draw_point(x,y);
    }
    static point_color(x: number,y: number,col: number) {
        return GMDraw.InternalFunctions.draw_point_colour(x,y,col);
    }
    static rectangle(x1: number,y1: number,x2: number,y2: number, outline: boolean) {
        return GMDraw.InternalFunctions.draw_rectangle(x1,y1,x2,y2,outline);
    }
    static rectangle_color(x1: number,y1: number,x2: number,y2: number, col1: number, col2: number, col3: number, col4: number, outline: boolean) {
        return GMDraw.InternalFunctions.draw_rectangle_colour(x1,y1,x2,y2,col1, col2, col3, col4, outline);
    }
    static rounded_rectangle(x1: number, y1: number, x2: number, y2: number, outline: boolean) {
        return GMDraw.InternalFunctions.draw_roundrect(x1,y1,x2,y2,outline);
    }
    static rounded_rectangle_color(x1: number, y1: number, x2: number, y2: number, col1: number, col2: number, outline: boolean) {
        return GMDraw.InternalFunctions.draw_roundrect_colour(x1,y1,x2,y2,col1,col2,outline);
    }
    static rounded_rectangle_ext(x1:number, y1: number, x2: number, y2: number, x_radius: number, y_radius: number, outline: boolean) {
        return GMDraw.InternalFunctions.draw_roundrect_ext(x1,y1,x2,y2,x_radius,y_radius,outline);
    }
    static rounded_rectangle_color_ext(x1:number, y1: number, x2: number, y2: number, x_radius: number, y_radius: number, col1: number, col2: number, outline: boolean) {
        return GMDraw.InternalFunctions.draw_roundrect_colour_ext(x1,y1,x2,y2,x_radius,y_radius,col1,col2,outline);
    }
    static triangle(x1: number, y1: number, x2: number, y2: number, x3: number, y3: number, outline: boolean){
        return GMDraw.InternalFunctions.draw_triangle(x1,y1,x2,y2,x3,y3,outline);
    }
    static triangle_color(x1: number, y1: number, x2: number, y2: number, x3: number, y3: number, col1: number, col2: number, col3: number, outline: boolean){
        return GMDraw.InternalFunctions.draw_triangle(x1,y1,x2,y2,x3,y3,col1,col2,col3,outline);
    }

    static clear(col: number) {
        return GMDraw.InternalFunctions.draw_clear(col);
    }
    static clear_alpha(col: number, alpha: number) {
        return GMDraw.InternalFunctions.draw_clear_alpha(col, alpha);
    }
    static set_alpha(alpha: number) {
        return GMDraw.InternalFunctions.draw_set_alpha(alpha);
    }
    static set_color(col: number) {
        return GMDraw.InternalFunctions.draw_set_colour(col);
    }

    static getpixel(x: number, y: number) {
        return GMDraw.InternalFunctions.draw_getpixel(x,y) as number;
    }
    static getpixel_ext(x: number, y: number) {
        return GMDraw.InternalFunctions.draw_getpixel_ext(x,y) as number;
    }
    static get_color() {
        return GMDraw.InternalFunctions.draw_get_colour() as number;
    }
    static get_alpha() {
        return GMDraw.InternalFunctions.draw_get_alpha() as number;
    }

    static enable_swf_aa(enable: boolean) {
        return GMDraw.InternalFunctions.draw_enable_swf_aa(enable);
    }
    static set_swf_aa_level(level: number) {
        return GMDraw.InternalFunctions.draw_set_swf_aa_level(level);
    }
    static get_swf_aa_level() {
        return GMDraw.InternalFunctions.draw_get_svg_aa_level() as number;
    }

    static enable_svg_aa(enable: boolean) {
        return GMDraw.InternalFunctions.draw_enable_svg_aa(enable);
    }
    static set_svg_aa_level(level: number) {
        return GMDraw.InternalFunctions.draw_set_svg_aa_level(level);
    }
    static get_svg_aa_level() {
        return GMDraw.InternalFunctions.draw_get_svg_aa_level() as number;
    }

}