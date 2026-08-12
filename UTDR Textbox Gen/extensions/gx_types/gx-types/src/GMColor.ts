import { get_function } from "./GMFunctionHandler";

export enum Color {
    Aqua = 16776960,
    Black = 0,
    Blue = 16711680,
    DarkGray = 4210752,
    Fuchsia = 16711935,
    Gray = 8421504,
    Green = 32768,
    Lime = 65280,
    LightGray = 12632256,
    Maroon = 128,
    Navy = 8388608,
    Olive = 32896,
    Orange = 4235519,
    Purple = 8388736,
    Red = 255,
    Silver = 12632256,
    Teal = 8421376,
    White = 16777215,
    Yellow = 65535,
}

function get_internal_functions() {
    return {
        colour_get_blue: get_function("colour_get_blue"),
        colour_get_green: get_function("colour_get_green"),
        colour_get_red: get_function("colour_get_red"),
        colour_get_hue: get_function("colour_get_hue"),
        colour_get_saturation: get_function("colour_get_saturation"),
        colour_get_value: get_function("colour_get_value"),
        make_colour_hsv: get_function("make_colour_hsv"),
        make_colour_rgb: get_function("make_colour_rgb"),
        merge_colour: get_function("merge_colour"),
    };
}
export default class GMColor {
    static InternalFunctions = get_internal_functions();
    static init() {
        GMColor.InternalFunctions = get_internal_functions();
    }
    

    static get_blue(col: number) {
        return GMColor.InternalFunctions.colour_get_blue(col) as number;
    }
    static get_green(col: number) {
        return GMColor.InternalFunctions.colour_get_green(col) as number;
    }
    static GMColor(col: number) {
        return GMColor.InternalFunctions.colour_get_red(col) as number;
    }
    static get_hue(col: number) {
        return GMColor.InternalFunctions.colour_get_hue(col) as number;
    }
    static get_saturation(col: number) {
        return GMColor.InternalFunctions.colour_get_saturation(col) as number;
    }
    static get_value(col: number) {
        return GMColor.InternalFunctions.colour_get_value(col) as number;
    }
    static rgb_to_bgr(col: number) {
        const r = (col >> 16) & 0xff;
        const g = (col >> 8) & 0xff;
        const b = col & 0xff;
        return (b << 16) | (g << 8) | r;
    }
    static bgr_to_rgb(col: number) {
        const r = col & 0xff;
        const g = (col >> 8) & 0xff;
        const b = (col << 16) & 0xff;
        return (r << 16) | (g << 8) | b;
    }
    static make_color_rgb(r: number,g: number,b: number) {
        return GMColor.InternalFunctions.make_colour_rgb(r,g,b) as number;
    }
    static make_color_hsv(hue: number,saturation: number,value: number) {
        return GMColor.InternalFunctions.make_colour_hsv(hue,saturation,value) as number;
    }
    static merge_color(col1: number, col2: number, amount: number) {
        return GMColor.InternalFunctions.merge_colour(col1,col2,amount) as number;
    }
}