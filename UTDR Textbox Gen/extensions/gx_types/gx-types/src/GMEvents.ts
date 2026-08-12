import { get_function } from "./GMFunctionHandler"
import GMMap from "./GMMap";

export enum AsyncEvent {
    SysteMEvent = 75,
    PushNotification = 71,
    WebIAP = 66,
    Social = 70,
    HTTP = 62,
    Cloud = 67,
    ImageLoad = 60,
    Networking = 68,
    Steam = 69,
    AudioPlayback = 74,
    AudioRecording = 73,
    Dialog = 63,
    SaveLoad = 72,
}

function get_internal_functions() {
    return {
        event_perform: get_function("event_perform"),
        event_perform_async: get_function("event_perform_async"),
        event_perform_object: get_function("event_perform_object"),
    }
}

export default class GMEvents {
    static InternalFunctions = get_internal_functions();
    static init() {
        GMEvents.InternalFunctions = get_internal_functions();
    }
    static perform_async(type: AsyncEvent,map: GMMap) {
        GMEvents.InternalFunctions.event_perform_async(type,map.ptr);
    }
}