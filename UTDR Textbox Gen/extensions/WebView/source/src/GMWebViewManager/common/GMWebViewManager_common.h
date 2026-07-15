#include "GMWebViewManager.h"
#include <sstream>
#include <fstream>
#include <filesystem>
#include <thread>
#include <iomanip>
#include <iostream>

#ifdef _MSC_VER
#pragma warning(push)
#pragma warning(disable : 4005) // macro redefinition
#endif

#include <webview/webview.h>

#ifdef _MSC_VER
#pragma warning(pop)
#endif

// Global webview instance for Windows/Linux (not used by iOS/macOS)
extern std::shared_ptr<webview::webview> g_webview_instance_;

extern const char kInjectJS[];
extern const char kYTPageName[];

std::string _buildYoutubeUrl(const std::string& id);
void _writeYoutubeIframeApiPage(const std::filesystem::path& folder);