import GMBuffer, { BufferType, DataType, SeekType }  from './src/GMBuffer';
import GMJSON from './src/GMJSON';
import GMMap from './src/GMMap';
import GMList from './src/GMList';
import GMEvents, {AsyncEvent} from './src/GMEvents';
import GMAssets, {AssetType} from './GMAssets';
import GMSurface from './src/GMSurface';
import GMDraw from './src/GMDraw';
import GMColor, {Color} from './GMColor';
import GMSprite from './src/GMSprite';

declare global {
    interface Window {
        gxtypes_init: ()=>void,
        GMBuffer,
        BufferType,
        DataType,
        SeekType,
        GMJSON,
        GMMap,
        GMList
        GMEvents,
        AsyncEvent,
        GMAssets,
        AssetType
        GMSurface,
        GMDraw,
        GMColor,
        Color,
        GMSprite
    }
}

export {};