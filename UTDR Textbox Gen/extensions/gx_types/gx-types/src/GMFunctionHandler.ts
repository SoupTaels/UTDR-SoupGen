
let gmfn: {[key: string]: Function | undefined} | null = null; 
export function fetch_gml_functions() {
    // @ts-ignore
    gmfn = __js_get_gml();

    return gmfn;
}

function noop() {};

function call_wrapper(fn:Function, ...args:any[]) {
    const out = fn(undefined,undefined,...args);
    return out;
}

export function get_function(name: string) {
    if (gmfn == null) {
        return noop;
    }
    if (gmfn[name] == undefined) {
        throw `Function ${name} not found`;
    }
    return (...args:any[])=>call_wrapper(gmfn![name]!,...args);
}
