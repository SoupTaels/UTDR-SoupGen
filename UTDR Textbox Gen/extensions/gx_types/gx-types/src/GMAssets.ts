import { get_function } from "./GMFunctionHandler";

export enum AssetType {
    Unknown = -1,
    Sprite = 1,
    Object = 0,
    Script = 5,
    Room = 3,
    Path = 4,
    Sound = 2,
    Tileset = 13,
    Timeline = 7,
    Font = 6,
    Shader = 8,
    Sequence = 9,
    AnimationCurve = 10,
    ParticleSystem = 11,
}

function get_internal_functions() {
    return {
        asset_get_index: get_function("asset_get_index"),
        asset_get_type: get_function("asset_get_type"),
        tag_get_asset_ids: get_function("tag_get_asset_ids"),
        tag_get_assets: get_function("tag_get_assets"),
        asset_get_ids: get_function("asset_get_ids"),
        asset_get_tags: get_function("asset_get_tags"),
        asset_add_tags: get_function("asset_add_tags"),
        asset_remove_tags: get_function("asset_remove_tags"),
        asset_has_tags: get_function("asset_has_tags"),
        asset_has_any_tag: get_function("asset_has_any_tag"),
        asset_clear_tags: get_function("asset_clear_tags"),
    }
}

export default class GMAssets {
    static InternalFunctions = get_internal_functions();
    static init = function() {
        GMAssets.InternalFunctions = get_internal_functions();
    }
    static get_index(name: string) {
        return GMAssets.InternalFunctions.asset_get_index(name) as string;
    }
    static get_type(name_or_ref: string|number) {
        return GMAssets.InternalFunctions.asset_get_type(name_or_ref) as AssetType;
    }
    static get_ids(type: AssetType) {
        return GMAssets.InternalFunctions.asset_get_ids(type) as any[];
    }
    static get_tags(ref: string, type?: AssetType) {
        return GMAssets.InternalFunctions.asset_get_tags(ref,type) as string[]
    }
    static add_tags(ref: string, tags: string|string[], type?: AssetType) {
        return !!GMAssets.InternalFunctions.asset_add_tags(ref,tags,type);
    }
    static remove_tags(ref: string, tags: string|string[], type?: AssetType) {
        return !!GMAssets.InternalFunctions.asset_remove_tags(ref,tags,type);
    }
    static has_tags(ref: string, tags: string|string[], type?: AssetType) {
        return !!GMAssets.InternalFunctions.asset_has_tags(ref,tags,type);
    }
    static has_any_tag(ref: string, tags: string|string[], type?: AssetType) {
        return !!GMAssets.InternalFunctions.asset_has_any_tag(ref,tags,type);
    }
    static clear_tags(ref: string, type?: AssetType) {
        return !!GMAssets.InternalFunctions.asset_clear_tags(ref,type);
    }
    static tag_get_assets(tags: string|string[]) {
        return GMAssets.InternalFunctions.tag_get_assets(tags) as string[];
    }
    static tag_get_asset_ids(tags: string|string[], type: AssetType) {
        return GMAssets.InternalFunctions.tag_get_asset_ids(tags, type) as number[];
    }
}