import { get_function } from "./GMFunctionHandler";
import GMBuffer from "./GMBuffer";
import GMList from "./GMList";

export type MapKey = string|number;

function get_internal_functions() {
    return {
        ds_map_create: get_function("ds_map_create"),
        ds_map_exists: get_function("ds_map_exists"),
        ds_map_destroy: get_function("ds_map_destroy"),
        ds_map_add: get_function("ds_map_add"),
        ds_map_clear: get_function("ds_map_clear"),
        ds_map_copy: get_function("ds_map_copy"),
        ds_map_replace: get_function("ds_map_replace"),
        ds_map_delete: get_function("ds_map_delete"),
        ds_map_empty: get_function("ds_map_empty"),
        ds_map_size: get_function("ds_map_size"),
        ds_map_find_first: get_function("ds_map_find_first"),
        ds_map_find_last: get_function("ds_map_find_last"),
        ds_map_find_next: get_function("ds_map_find_next"),
        ds_map_find_previous: get_function("ds_map_find_previous"),
        ds_map_find_value: get_function("ds_map_find_value"),
        ds_map_keys_to_array: get_function("ds_map_keys_to_array"),
        ds_map_values_to_array: get_function("ds_map_values_to_array"),
        ds_map_set: get_function("ds_map_set"),
        ds_map_read: get_function("ds_map_read"),
        ds_map_write: get_function("ds_map_write"),
        ds_map_secure_save: get_function("ds_map_secure_save"),
        ds_map_secure_save_buffer: get_function("ds_map_secure_save_buffer"),
        ds_map_secure_load: get_function("ds_map_secure_load"),
        ds_map_secure_load_buffer: get_function("ds_map_secure_load_buffer"),
        ds_map_add_list: get_function("ds_map_add_list"),
        ds_map_add_map: get_function("ds_map_add_map"),
        ds_map_replace_list: get_function("ds_map_replace_list"),
        ds_map_replace_map: get_function("ds_map_replace_map"),
        ds_map_is_list: get_function("ds_map_is_list"),
        ds_map_is_map: get_function("ds_map_is_map"),
    }
}

export default class GMMap {
    ptr: string|null = null;
    constructor(create=true) {
        if (create) {
            this.ptr = GMMap.InternalFunctions.ds_map_create();
        }
    }
    static InternalFunctions = get_internal_functions();
    static init() {
        GMMap.InternalFunctions = get_internal_functions();
    }
    static from(ptr: string) {
        const map = new GMMap(false);
        map.ptr = ptr;
        return map;
    }
    static read(string: string, is_legacy: boolean=false){
        const map = new GMMap(false);
        map.ptr = GMMap.InternalFunctions.ds_map_read(string, is_legacy);
        return map;
    }
    static secure_load(fname: string) {
        const map = new GMMap(false);
        map.ptr = GMMap.InternalFunctions.ds_map_secure_load(fname);
        return map;
    }
    static secure_load_buffer(buffer: GMBuffer) {
        const map = new GMMap(false);
        map.ptr = GMMap.InternalFunctions.ds_map_secure_load_buffer(buffer.ptr!);
        return map;
    }
    
    exists(key: MapKey){
        return !!GMMap.InternalFunctions.ds_map_exists(this.ptr, key);
    }
    destroy(){
        const p = this.ptr;
        this.ptr = null;
        return GMMap.InternalFunctions.ds_map_destroy(p);
    }
    add(key: MapKey, value: any){
        return !!GMMap.InternalFunctions.ds_map_add(this.ptr, key, value);
    }
    clear() {
        return GMMap.InternalFunctions.ds_map_clear(this.ptr);
    }
    copy(source: GMMap){
        return GMMap.InternalFunctions.ds_map_copy(this.ptr, source);
    }
    replace(key: MapKey, value: any){
        return !!GMMap.InternalFunctions.ds_map_replace(this.ptr, key, value);
    }
    delete(key: MapKey) {
        return GMMap.InternalFunctions.ds_map_delete(this.ptr, key);
    }
    empty() {
        return !!GMMap.InternalFunctions.ds_map_empty(this.ptr);
    }
    size(){
        return GMMap.InternalFunctions.ds_map_size(this.ptr) as number;
    }
    find_first() {
        return GMMap.InternalFunctions.ds_map_find_first(this.ptr) as string|undefined;
    }
    find_last() {
        return GMMap.InternalFunctions.ds_map_find_last(this.ptr) as string|undefined;
    }
    find_next(key: MapKey) {
        return GMMap.InternalFunctions.ds_map_find_next(this.ptr, key) as string|undefined;
    }
    find_previous(key: MapKey) {
        return GMMap.InternalFunctions.ds_map_find_previous(this.ptr, key);
    }
    find_value(key: MapKey) {
        return GMMap.InternalFunctions.ds_map_find_value(this.ptr, key);
    }
    keys_to_array(){
        return GMMap.InternalFunctions.ds_map_keys_to_array(this.ptr) as MapKey[];
    }
    values_to_array(): ()=>any[] {
        return GMMap.InternalFunctions.ds_map_values_to_array(this.ptr);
    }
    set(key: MapKey, value: any) {
        return GMMap.InternalFunctions.ds_map_set(this.ptr, key, value);
    }
    write() {
        return GMMap.InternalFunctions.ds_map_write(this.ptr) as string;
    }
    secure_save(fname: string) {
        return GMMap.InternalFunctions.ds_map_secure_save(this.ptr, fname);
    }
    secure_save_buffer() {
        return GMBuffer.from(GMMap.InternalFunctions.ds_map_secure_save_buffer(this.ptr) as string);
    }
    add_list(key: MapKey, list: GMList) {
        return GMMap.InternalFunctions.ds_map_add_list(this.ptr,key,list.ptr)
    }
    add_map(key: MapKey, map: GMMap) {
        return GMMap.InternalFunctions.ds_map_add_map(this.ptr,key,map.ptr);
    }
    replace_list(key: MapKey, list: GMList) {
        return GMMap.InternalFunctions.ds_map_replace_list(this.ptr,key,list.ptr);
    }
    replace_map(key: MapKey, map: GMMap) {
        return GMMap.InternalFunctions.ds_map_replace_map(this.ptr,key,map.ptr);
    }
    is_list(key: MapKey) {
        return !!GMMap.InternalFunctions.ds_map_is_list(this.ptr,key);
    }
    is_map(key: MapKey) {
        return !!GMMap.InternalFunctions.ds_map_is_map(this.ptr,key);
    }
};