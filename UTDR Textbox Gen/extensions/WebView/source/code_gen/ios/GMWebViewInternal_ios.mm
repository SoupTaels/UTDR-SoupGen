// ##### extgen :: Auto-generated file do not edit!! #####

#import <objc/runtime.h>
#import "core/GMExtUtils.h"
#import "GMWebViewInternal_ios.h"


extern "C" const char* extOptGetString(char* _ext, char* _opt);

// Adapter: matches const signature expected by your C++ API
static const char* ExtOptGetString(const char* ext, const char* opt)
{
    return extOptGetString(const_cast<char*>(ext), const_cast<char*>(opt));
}

static BOOL GMIsSubclassOf(Class cls, Class base)
{
    for (Class c = cls; c != Nil; c = class_getSuperclass(c)) {
        if (c == base) return YES;
    }
    return NO;
}

static void GMInjectSelectorsIntoSubclass(Class subclass, Class base)
{
    // Build set of methods already defined on subclass
    unsigned subCount = 0;
    Method *subList = class_copyMethodList(subclass, &subCount);

    CFMutableSetRef owned = CFSetCreateMutable(kCFAllocatorDefault, 0, NULL);
    for (unsigned i = 0; i < subCount; ++i) {
        CFSetAddValue(owned, method_getName(subList[i]));
    }

    // Walk base class methods
    unsigned baseCount = 0;
    Method *baseList = class_copyMethodList(base, &baseCount);

    for (unsigned i = 0; i < baseCount; ++i) {
        SEL sel = method_getName(baseList[i]);
        const char *name = sel_getName(sel);

        // Only inject your extension selectors
        if (!name || strncmp(name, "__EXT_NATIVE__", 13) != 0) continue;

        // Add only if subclass doesn't already have it
        if (!CFSetContainsValue(owned, sel)) {
            IMP imp = method_getImplementation(baseList[i]);
            const char *types = method_getTypeEncoding(baseList[i]);
            if (class_addMethod(subclass, sel, imp, types)) {
                CFSetAddValue(owned, sel);
            }
        }
    }

    if (subList) free(subList);
    if (baseList) free(baseList);
    if (owned) CFRelease(owned);
}

@interface GMWebViewInternal ()
{
    gm::runtime::DispatchQueue __dispatch_queue;
    id<GMWebViewInterface> __impl;
}@end


@implementation GMWebViewInternal

+ (void)load
{
    // Find all loaded classes
    int num = objc_getClassList(NULL, 0);
    if (num <= 0) return;

    Class *classes = (Class *)malloc(sizeof(Class) * (unsigned)num);
    num = objc_getClassList(classes, num);

    Class base = [GMWebViewInternal class];

    for (int i = 0; i < num; ++i) {
        Class cls = classes[i];
        if (cls == base) continue;

        // We only care about direct or indirect subclasses
        if (GMIsSubclassOf(cls, base)) {
            GMInjectSelectorsIntoSubclass(cls, base);
        }
    }

    free(classes);

    gm::details::GMRTRunnerInterface ri{};
    ri.ExtOptGetString = &ExtOptGetString;
    GMExtensionInitialise(&ri, sizeof(ri));
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        __impl = (id<GMWebViewInterface>)self;
    }
    return self;
}
- (double)__EXT_NATIVE__webview_open_url:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: url, type: optional<String>
    std::optional<std::string_view> url = gm::wire::codec::readOptional<std::string_view>(__br);

    [__impl webview_open_url:url];

    return 0;
}

- (double)__EXT_NATIVE__webview_hide
{
    [__impl webview_hide];

    return 0;
}

- (double)__EXT_NATIVE__webview_show
{
    [__impl webview_show];

    return 0;
}

- (double)__EXT_NATIVE__webview_close
{
    [__impl webview_close];

    return 0;
}

- (double)__EXT_NATIVE__webview_load_html:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: html, type: optional<String>
    std::optional<std::string_view> html = gm::wire::codec::readOptional<std::string_view>(__br);

    [__impl webview_load_html:html];

    return 0;
}

- (double)__EXT_NATIVE__webview_load_local:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: path, type: optional<String>
    std::optional<std::string_view> path = gm::wire::codec::readOptional<std::string_view>(__br);

    [__impl webview_load_local:path];

    return 0;
}

- (double)__EXT_NATIVE__webview_load_blank
{
    [__impl webview_load_blank];

    return 0;
}

- (double)__EXT_NATIVE__webview_load_youtube:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: uid, type: optional<String>
    std::optional<std::string_view> uid = gm::wire::codec::readOptional<std::string_view>(__br);

    [__impl webview_load_youtube:uid];

    return 0;
}

- (double)__EXT_NATIVE__webview_load_no_internet
{
    [__impl webview_load_no_internet];

    return 0;
}

- (double)__EXT_NATIVE__webview_set_start_mode:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: mode, type: enum WebViewStartMode
    gm_enums::WebViewStartMode mode = gm::wire::codec::readValue<gm_enums::WebViewStartMode>(__br);

    [__impl webview_set_start_mode:mode];

    return 0;
}

- (double)__EXT_NATIVE__webview_set_borderless:(double)on
{
    [__impl webview_set_borderless:on];

    return 0;
}

- (char*)__EXT_NATIVE__webview_get_url
{
    static std::string __result;
    __result = [__impl webview_get_url];

    return (char*)__result.c_str();
}

- (char*)__EXT_NATIVE__webview_get_title
{
    static std::string __result;
    __result = [__impl webview_get_title];

    return (char*)__result.c_str();
}

- (double)__EXT_NATIVE__webview_is_loading
{
    bool __result = [__impl webview_is_loading];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__webview_is_running
{
    bool __result = [__impl webview_is_running];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__webview_is_visible
{
    bool __result = [__impl webview_is_visible];

    return static_cast<double>(__result);
}

- (char*)__EXT_NATIVE__webview_get_body
{
    static std::string __result;
    __result = [__impl webview_get_body];

    return (char*)__result.c_str();
}

- (char*)__EXT_NATIVE__webview_get_params
{
    static std::string __result;
    __result = [__impl webview_get_params];

    return (char*)__result.c_str();
}

- (double)__EXT_NATIVE__webview_allow_swipe_refresh:(double)allow
{
    [__impl webview_allow_swipe_refresh:allow];

    return 0;
}

- (double)__EXT_NATIVE__webview_eval_js:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: js, type: optional<String>
    std::optional<std::string_view> js = gm::wire::codec::readOptional<std::string_view>(__br);

    [__impl webview_eval_js:js];

    return 0;
}

- (double)__EXT_NATIVE__webview_set_js_callback:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: cb, type: optional<Function>
    std::optional<gm::wire::GMFunction> cb = std::nullopt;
    if (gm::wire::codec::readValue<bool>(__br))
    {
        cb = gm::wire::codec::readFunction(__br, &__dispatch_queue);
    }

    [__impl webview_set_js_callback:cb];

    return 0;
}

- (double)__EXT_NATIVE__webview_button_create:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: size_dp, type: Int32
    std::int32_t size_dp = gm::wire::codec::readValue<std::int32_t>(__br);

    // field: gravity, type: Int32
    std::int32_t gravity = gm::wire::codec::readValue<std::int32_t>(__br);

    // field: asset_type, type: optional<enum WebViewButtonAssetType>
    std::optional<gm_enums::WebViewButtonAssetType> asset_type = gm::wire::codec::readOptional<gm_enums::WebViewButtonAssetType>(__br);

    // field: asset, type: optional<String>
    std::optional<std::string_view> asset = gm::wire::codec::readOptional<std::string_view>(__br);

    std::int32_t __result = [__impl webview_button_create:size_dp gravity:gravity asset_type:asset_type asset:asset];

    return static_cast<double>(__result);
}

- (double)__EXT_NATIVE__webview_button_destroy:(double)handle
{
    [__impl webview_button_destroy:handle];

    return 0;
}

- (double)__EXT_NATIVE__webview_button_destroy_all
{
    [__impl webview_button_destroy_all];

    return 0;
}

- (double)__EXT_NATIVE__webview_button_set_alpha:(double)handle arg1:(double)alpha
{
    [__impl webview_button_set_alpha:handle alpha:static_cast<double>(alpha)];

    return 0;
}

- (double)__EXT_NATIVE__webview_button_set_auto_close:(double)handle arg1:(double)flag
{
    [__impl webview_button_set_auto_close:handle flag:static_cast<bool>(flag)];

    return 0;
}

- (double)__EXT_NATIVE__webview_button_set_margins:(double)handle arg1:(double)left arg2:(double)top arg3:(double)right arg4:(double)bottom
{
    [__impl webview_button_set_margins:handle left:static_cast<std::int32_t>(left) top:static_cast<std::int32_t>(top) right:static_cast<std::int32_t>(right) bottom:static_cast<std::int32_t>(bottom)];

    return 0;
}

- (double)__EXT_NATIVE__webview_button_set_size:(double)handle arg1:(double)size_dp
{
    [__impl webview_button_set_size:handle size_dp:static_cast<std::int32_t>(size_dp)];

    return 0;
}

- (double)__EXT_NATIVE__webview_button_set_gravity:(double)handle arg1:(double)gravity
{
    [__impl webview_button_set_gravity:handle gravity:static_cast<std::int32_t>(gravity)];

    return 0;
}

- (double)__EXT_NATIVE__webview_button_set_position:(double)handle arg1:(double)x_dp arg2:(double)y_dp
{
    [__impl webview_button_set_position:handle x_dp:static_cast<std::int32_t>(x_dp) y_dp:static_cast<std::int32_t>(y_dp)];

    return 0;
}

- (double)__EXT_NATIVE__webview_button_set_visible:(double)handle arg1:(double)visible
{
    [__impl webview_button_set_visible:handle visible:static_cast<bool>(visible)];

    return 0;
}

- (double)__EXT_NATIVE__webview_button_set_asset:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: handle, type: Int32
    std::int32_t handle = gm::wire::codec::readValue<std::int32_t>(__br);

    // field: asset_type, type: enum WebViewButtonAssetType
    gm_enums::WebViewButtonAssetType asset_type = gm::wire::codec::readValue<gm_enums::WebViewButtonAssetType>(__br);

    // field: asset, type: optional<String>
    std::optional<std::string_view> asset = gm::wire::codec::readOptional<std::string_view>(__br);

    [__impl webview_button_set_asset:handle asset_type:asset_type asset:asset];

    return 0;
}

- (double)__EXT_NATIVE__webview_button_set_callback:(char*)__arg_buffer arg1:(double)__arg_buffer_length
{
    gm::byteio::BufferReader __br{__arg_buffer, static_cast<size_t>(__arg_buffer_length)};

    // field: handle, type: Int32
    std::int32_t handle = gm::wire::codec::readValue<std::int32_t>(__br);

    // field: callback, type: optional<Function>
    std::optional<gm::wire::GMFunction> callback = std::nullopt;
    if (gm::wire::codec::readValue<bool>(__br))
    {
        callback = gm::wire::codec::readFunction(__br, &__dispatch_queue);
    }

    [__impl webview_button_set_callback:handle callback:callback];

    return 0;
}

- (double)__EXT_NATIVE__webview_shutdown
{
    [__impl webview_shutdown];

    return 0;
}

// Internal function used for fetching dispatched function calls to GML
- (double)__EXT_NATIVE__GMWebView_invocation_handler:(char*)__ret_buffer arg1:(double)__ret_buffer_length
{
    gm::byteio::BufferWriter __bw{ __ret_buffer, static_cast<size_t>(__ret_buffer_length) };
    return __dispatch_queue.fetch(__bw);
}

@end

