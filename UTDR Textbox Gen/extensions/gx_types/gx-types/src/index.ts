import { fetch_gml_functions } from "./GMFunctionHandler";
import GMBuffer, { BufferType, DataType, SeekType } from "./GMBuffer";
import GMJSON from "./GMJSON";
import GMMap from "./GMMap";
import GMList from "./GMList";
import GMEvents, { AsyncEvent } from "./GMEvents";
import GMAssets, { AssetType } from "./GMAssets";
import GMSurface from "./GMSurface";
import GMDraw from "./GMDraw";
import GMColor, {Color} from "./GMColor";
import GMSprite from "./GMSprite";




window.gxtypes_init = function() {
    
    const out = fetch_gml_functions();
    console.log(out)
    
    GMBuffer.init();
    GMJSON.init();
    GMMap.init();
    GMList.init();
    GMEvents.init();
    GMAssets.init();
    GMSurface.init();
    GMDraw.init();
    GMColor.init();
    GMSprite.init();




    window.GMBuffer = GMBuffer;
    window.BufferType = BufferType;
    window.DataType = DataType;
    window.SeekType = SeekType;
    window.GMJSON = GMJSON;
    window.GMMap = GMMap;
    window.GMList = GMList;
    window.GMEvents = GMEvents;
    window.GMAssets = GMAssets;
    window.AssetType = AssetType;
    window.AsyncEvent = AsyncEvent;
    window.GMSurface = GMSurface;
    window.GMDraw = GMDraw;
    window.GMColor = GMColor;
    window.Color = Color;
    window.GMSprite = GMSprite;

}

// @ts-ignore
window.gxtypes_test = function() {
    
    const map = new window.GMMap();
    map.set('test',true);
    map.set('test123',false);
    map.set('a string','blah blah blah');
    map.set('a number',42069);
    map.set('undefined',undefined);
    map.set('array',['a',1,2,3,'b']);
    
    const buff = new GMBuffer(128,BufferType.Fixed,1);
    buff.write(DataType.String,"Hello, world!");
    buff.seek(SeekType.Start,0);

    const list = new GMList();
    list.add(1);
    list.add(2);
    list.add(3);
    list.add("string");

    const sprite = GMSprite.from('spr_test')!;
    const surface = new GMSurface(128,128);
    surface.set_target();
    GMDraw.set_color(Color.White);
    GMDraw.circle(64,64,64,false);
    sprite.draw(0,64,64);
    surface.reset_target();

    const arr = [
        map.ptr,buff.ptr,list.ptr,surface.ptr
    ];

    return arr;
}
