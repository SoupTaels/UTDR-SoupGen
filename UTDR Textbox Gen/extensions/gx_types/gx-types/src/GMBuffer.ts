import { get_function } from "./GMFunctionHandler";

export enum BufferType {
    Fixed= 0,
    Grow= 1,
    Wrap= 2,
    Fast= 3,
    VertexBufer=4,
}

export enum DataType {
    U8 = 1,
    S8 = 2,
    U16 = 3,
    S16 = 4,
    U32 = 5,
    S32 = 6,
    U64 = 12,
    F16 = 7,
    F32 = 8,
    F64 = 9,
    Bool = 10,
    String = 11,
    Text = 13,
}

export enum SeekType {
    Start = 0,
    Relative = 1,
    End = 2,
}

function get_internal_functions() {
    return {
        buffer_exists: get_function("buffer_exists"),
        buffer_create: get_function("buffer_create"),
        buffer_create_from_vertex_buffer: get_function("buffer_create_from_vertex_buffer"),
        buffer_create_from_vertex_buffer_ext: get_function("buffer_create_from_vertex_buffer_ext"),
        buffer_delete: get_function("buffer_delete"),
        buffer_read: get_function("buffer_read"),
        buffer_write: get_function("buffer_write"),
        buffer_fill: get_function("buffer_fill"),
        buffer_seek: get_function("buffer_seek"),
        buffer_tell: get_function("buffer_tell"),
        buffer_peek: get_function("buffer_peek"),
        buffer_poke: get_function("buffer_poke"),
        buffer_save: get_function("buffer_save"),
        buffer_save_ext: get_function("buffer_save_ext"),
        buffer_save_async: get_function("buffer_save_async"),
        buffer_load: get_function("buffer_load"),
        buffer_load_ext: get_function("buffer_load_ext"),
        buffer_load_async: get_function("buffer_load_async"),
        buffer_load_partial: get_function("buffer_load_partial"),
        buffer_compress: get_function("buffer_compress"),
        buffer_decompress: get_function("buffer_decompress"),
        buffer_async_group_begin: get_function("buffer_async_group_begin"),
        buffer_async_group_option: get_function("buffer_async_group_option"),
        buffer_async_group_end: get_function("buffer_async_group_end"),
        buffer_copy: get_function("buffer_copy"),
        buffer_copy_from_vertex_buffer: get_function("buffer_copy_from_vertex_buffer"),
        buffer_get_type: get_function("buffer_get_type"),
        buffer_get_alignment: get_function("buffer_get_alignment"),
        buffer_get_address: get_function("buffer_get_address"),
        buffer_get_size: get_function("buffer_get_size"),
        buffer_get_used_size: get_function("buffer_get_used_size"),
        buffer_get_surface: get_function("buffer_get_surface"),
        buffer_set_surface: get_function("buffer_set_surface"),
        buffer_resize: get_function("buffer_resize"),
        buffer_sizeof: get_function("buffer_sizeof"),
        buffer_md5: get_function("buffer_md5"),
        buffer_sha1: get_function("buffer_sha1"),
        buffer_crc32: get_function("buffer_crc32"),
        buffer_base64_encode: get_function("buffer_base64_encode"),
        buffer_base64_decode: get_function("buffer_base64_decode"),
        buffer_base64_decode_ext: get_function("buffer_base64_decode_ext"),
        buffer_set_used_size: get_function("buffer_set_used_size")
    }
}

export default class GMBuffer {
    ptr: string|null = null;
    constructor(size: number,type: BufferType, alignment: number, create=true) {
        if (create) {
            this.ptr = GMBuffer.InternalFunctions.buffer_create(size,type,alignment);
        }
    }
    static InternalFunctions = get_internal_functions();
    static init() {
        GMBuffer.InternalFunctions = get_internal_functions();
    }
    static from(buffer: string){
        const buff = new GMBuffer(1,BufferType.Fixed,1,false);
        buff.ptr = buffer;
        return buff;
    }
    static from_vertex_buffer(vbuff: string, type: BufferType, alignment: number) {
        return GMBuffer.from(GMBuffer.InternalFunctions.buffer_create_from_vertex_buffer(vbuff,type,alignment));
    }
    static from_vertex_buffer_ext(vbuff: string, type: BufferType, alignment: number, start_vertex: number, num_vertices: number) {
        return GMBuffer.from(GMBuffer.InternalFunctions.buffer_create_from_vertex_buffer_ext(vbuff,type,alignment,start_vertex,num_vertices));
    }
    static load(fname: string) {
        return GMBuffer.from(GMBuffer.InternalFunctions.buffer_load(fname));
    }
    static base64_decode(string: string) {
        return GMBuffer.from(GMBuffer.InternalFunctions.buffer_base64_decode(string));
    }

    exists() {
        return this.ptr != null && !!GMBuffer.InternalFunctions.buffer_exists(this.ptr);
    }
    delete(){
        const p = this.ptr;
        this.ptr = null;
        return GMBuffer.InternalFunctions.buffer_delete(p);
    }
    read(type: DataType) {
        const out = GMBuffer.InternalFunctions.buffer_read(this.ptr,type);
        if (type == DataType.String || type == DataType.Text) {
            return out as string;
        } else if (type == DataType.Bool) {
            return out as boolean;
        }
        return out as number;
    }
    write(type: DataType, data: number|string) {
        return GMBuffer.InternalFunctions.buffer_write(this.ptr,type,data);
    }
    fill(offset: number, type: DataType, value: string|number,size: number) {
        return GMBuffer.InternalFunctions.buffer_fill(this.ptr,offset,type,value,size);
    }
    seek(type: SeekType, offset: number) {
        return GMBuffer.InternalFunctions.buffer_seek(this.ptr,type,offset);
    }
    tell() {
        return GMBuffer.InternalFunctions.buffer_tell(this.ptr) as number;
    }
    peek(offset: number, type: DataType) {
        const out = GMBuffer.InternalFunctions.buffer_peek(this.ptr,offset,type);
        if (type == DataType.String || type == DataType.Text) {
            return out as string;
        } else if (type == DataType.Bool) {
            return out as boolean;
        }
        return out as number;
    }
    poke(offset: number, type: DataType, value: any) {
        return GMBuffer.InternalFunctions.buffer_poke(this.ptr,offset,type,value);
    }
    save(fname: string) {
        return GMBuffer.InternalFunctions.buffer_save(this.ptr,fname);
    }
    save_ext(fname: string, offset: number, size: number) {
        return GMBuffer.InternalFunctions.buffer_save_ext(fname,offset,size);
    }
    save_async(fname: string, offset: number, size: number) {
        return GMBuffer.InternalFunctions.buffer_save_async(fname,offset,size) as number;
    }
    load_ext(fname: string,offset: number) {
        return GMBuffer.InternalFunctions.buffer_load_ext(this.ptr,fname,offset);
    }
    load_async(fname: string, offset: number, size: number) {
        return GMBuffer.InternalFunctions.buffer_load_async(this.ptr,fname,offset,size)
    }
    load_partial(fname: string, source_offset: number, size: number, dest_offset: number) {
        return GMBuffer.InternalFunctions.buffer_load_partial(this.ptr,fname,source_offset,size,dest_offset);
    }
    compress(offset: number,size: number) {
        return GMBuffer.from(GMBuffer.InternalFunctions.buffer_compress(this.ptr,offset,size));
    }
    decompress() {
        return GMBuffer.from(GMBuffer.InternalFunctions.buffer_decompress(this.ptr));
    }
    async_group_begin() {
        alert('not yet implemented');
    }
    async_group_option() {
        alert('not yet implemented');
    }
    async_group_end() {
        alert('not yet implemented');
    }
    copy(source_buffer: GMBuffer, source_offset: number, size: number, dest_offset: number) {
        return GMBuffer.InternalFunctions.buffer_copy(source_buffer,source_offset,size,this.ptr,dest_offset);
    }
    copy_from_vertex_buffer(vbuff: string, start_vertex: number, num_vertices: number, offset: number) {
        return GMBuffer.InternalFunctions.buffer_copy_from_vertex_buffer(vbuff,start_vertex,num_vertices,this.ptr,offset);
    }
    get_type() {
        return GMBuffer.InternalFunctions.buffer_get_type(this.ptr) as BufferType;
    }
    get_alignment() {
        return GMBuffer.InternalFunctions.buffer_get_alignment(this.ptr) as number;
    }
    get_address() {
        return GMBuffer.InternalFunctions.buffer_get_address(this.ptr) as string;
    }
    get_size() {
        return GMBuffer.InternalFunctions.buffer_get_size(this.ptr) as number;
    }
    get_used_size() {
        return GMBuffer.InternalFunctions.buffer_get_size(this.ptr) as number;
    }
    copy_from_surface(surface: string, offset: number){
        return GMBuffer.InternalFunctions.buffer_get_surface(this.ptr,surface,offset);
    }
    copy_to_surface(surface: string, offset: number) {
        return GMBuffer.InternalFunctions.buffer_set_surface(this.ptr,surface,offset);
    }
    resize(new_size: number) {
        GMBuffer.InternalFunctions.buffer_resize(this.ptr,new_size);
    }
    md5(offset: number, size: number) {
        return GMBuffer.InternalFunctions.buffer_md5(this.ptr,offset,size) as string;
    }
    sha1(offset: number, size: number) {
        return GMBuffer.InternalFunctions.buffer_sha1(this.ptr,offset,size) as string;
    }
    crc32(offset: number, size: number) {
        return GMBuffer.InternalFunctions.buffer_crc32(this.ptr,offset,size) as number;
    }
    base64_encode(offset: number, size: number) {
        return GMBuffer.InternalFunctions.buffer_base64_encode(this.ptr,offset,size) as string;
    }
    base64_decode_ext(string: string, offset: number) {
        return GMBuffer.InternalFunctions.buffer_base64_decode_ext(this.ptr,string,offset);
    }
    set_used_size(size: number) {
        return GMBuffer.InternalFunctions.buffer_set_used_size(this.ptr,size);
    }
} 