import { get_function } from "./GMFunctionHandler";
import GMMap from "./GMMap";

function get_internal_functions() {
    return {
        json_encode: get_function("json_encode"),
        json_decode: get_function("json_decode"),
    }
}

export default class GMJSON {
    static InternalFunctions = get_internal_functions();
    static init() {
        GMJSON.InternalFunctions = get_internal_functions();
    }
    static struct = {
        stringify() {},
        parse(){},
    }
    static ds = {
        stringify(ds: GMMap, prettify=false){
            return GMJSON.InternalFunctions.json_encode(ds.ptr, prettify);
        },
        parse(string: string){
            const map = new GMMap(false);
            map.ptr = GMJSON.InternalFunctions.json_decode(string);
            return map;
        },
    }
}