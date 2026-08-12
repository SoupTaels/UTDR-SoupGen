import { get_function } from "./GMFunctionHandler";
import GMBuffer from "./GMBuffer";

function get_internal_functions() {
    return {
        ds_list_create: get_function("ds_list_create"),
        ds_list_destroy: get_function("ds_list_destroy"),
        ds_list_clear: get_function("ds_list_clear"),
        ds_list_empty: get_function("ds_list_empty"),
        ds_list_size: get_function("ds_list_size"),
        ds_list_add: get_function("ds_list_add"),
        ds_list_set: get_function("ds_list_set"),
        ds_list_delete: get_function("ds_list_delete"),
        ds_list_find_index: get_function("ds_list_find_index"),
        ds_list_find_value: get_function("ds_list_find_value"),
        ds_list_insert: get_function("ds_list_insert"),
        ds_list_replace: get_function("ds_list_replace"),
        ds_list_shuffle: get_function("ds_list_shuffle"),
        ds_list_sort: get_function("ds_list_sort"),
        ds_list_copy: get_function("ds_list_copy"),
        ds_list_read: get_function("ds_list_read"),
        ds_list_write: get_function("ds_list_write"),
        ds_list_mark_as_list: get_function("ds_list_mark_as_list"),
        ds_list_mark_as_map: get_function("ds_list_mark_as_map"),
        ds_list_is_list: get_function("ds_list_is_list"),
        ds_list_is_map: get_function("ds_list_is_map"),
    }
}

export default class GMList {
    ptr: string|null = null;
    constructor(create=true){
        if (create) {
            this.ptr = GMList.InternalFunctions.ds_list_create();
        }
    }
    static InternalFunctions = get_internal_functions();
    static init(){
        GMList.InternalFunctions = get_internal_functions();
    }
    static read(string: string, legacy=false){
        const list = new GMList();
        GMList.InternalFunctions.ds_list_read(list.ptr,string,legacy);
        return list;
    }
    destroy() {
        const p = this.ptr;
        this.ptr = null;
        return GMList.InternalFunctions.ds_list_destroy(p);
    }
    clear() {
        return GMList.InternalFunctions.ds_list_clear(this.ptr)
    }
    empty() {
        return !!GMList.InternalFunctions.ds_list_empty(this.ptr);
    }
    size() {
        return GMList.InternalFunctions.ds_list_size(this.ptr) as number;
    }
    add(value: any) {
        return GMList.InternalFunctions.ds_list_add(this.ptr,value);
    }
    set(index: number, value: any) {
        return GMList.InternalFunctions.ds_list_set(this.ptr,index,value);
    }
    delete(index: number) {
        return GMList.InternalFunctions.ds_list_delete(this.ptr,index);
    }
    find_index(value: any) {
        return GMList.InternalFunctions.ds_list_find_index(this.ptr,value) as number;
    }
    find_value(index: number) {
        return GMList.InternalFunctions.ds_list_find_value(this.ptr,index);
    }
    insert(index: number,value: any) {
        return GMList.InternalFunctions.ds_list_insert(this.ptr,index,value);
    }
    replace(index: number, value: any) {
        return GMList.InternalFunctions.ds_list_replace(this.ptr,index,value);
    }
    shuffle() {
        return GMList.InternalFunctions.ds_list_shuffle(this.ptr);
    }
    sort(ascending:boolean) {
        return GMList.InternalFunctions.ds_list_sort(this.ptr,ascending);
    }
    copy(source:GMList) {
        return GMList.InternalFunctions.ds_list_copy(this.ptr,source.ptr);
    }
    write() {
        return GMList.InternalFunctions.ds_list_write(this.ptr) as string;
    }
    mark_as_list(index: number) {
        return GMList.InternalFunctions.ds_list_mark_as_list(this.ptr,index);
    }
    mark_as_map(index: number) {
        return GMList.InternalFunctions.ds_list_mark_as_map(this.ptr,index);
    }
    is_list(index: number) {
        return !!GMList.InternalFunctions.ds_list_is_list(this.ptr,index);
    }
    is_map(index: number) {
        return !!GMList.InternalFunctions.ds_list_is_map(this.ptr,index);
    }
}