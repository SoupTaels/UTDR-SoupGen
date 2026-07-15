struct GMRTRunnerInterface
{
    const char* (*ExtOptGetString)(const char* _ext, const char* _opt);
};
void Init_GMWebView()
{
    GMRTRunnerInterface ri;
    ri.ExtOptGetString = &ExtensionOptions_GetValue;

    using FunctionPointer = void (*)(GMRTRunnerInterface*, size_t);
    FunctionPointer fnHandle = nullptr;
    void* libHandle = nullptr;

    libHandle = ExtUtils_GetLibraryHandle("WebView.ext");
    if (libHandle)
    {
        fnHandle = (FunctionPointer)SharedLibrary_GetFunctionAddress(libHandle, "GMExtensionInitialise");
        if (fnHandle) fnHandle(&ri, sizeof(GMRTRunnerInterface));
    }
}
void Startup_GMWebView()
{
    if (isInitialized) return;

    using FunctionPointer = void (*)();
    FunctionPointer fnHandle = nullptr;
    void* libHandle = nullptr;

    isInitialized = true;
}
void Shutdown_GMWebView()
{
    if (!isInitialized) return;

    using FunctionPointer = void (*)();
    FunctionPointer fnHandle = nullptr;
    void* libHandle = nullptr;

    libHandle = ExtUtils_GetLibraryHandle("WebView.ext");
    if (libHandle)
    {
        fnHandle = (FunctionPointer)SharedLibrary_GetFunctionAddress(libHandle, "__EXT_NATIVE__webview_shutdown");
        if (fnHandle) fnHandle();
    }
    isInitialized = false;
}
