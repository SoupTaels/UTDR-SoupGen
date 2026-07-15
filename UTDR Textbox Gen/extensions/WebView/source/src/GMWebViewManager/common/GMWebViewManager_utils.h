#pragma once

#include <string>
#include <fstream>
#include <sstream>
#include <iomanip>
#include <cstdint>
#include <nlohmann/json.hpp>
#include "GMWebViewManager.h"

namespace webviewcpp {
namespace utils {

// ──────────────────────────────────────────────────────────────
// Base64 Encoding
// ──────────────────────────────────────────────────────────────
inline std::string b64encode(const std::string& s)
{
    static const char t[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    std::string out;
    out.reserve(((s.size() + 2) / 3) * 4);
    size_t i = 0;
    while (i + 3 <= s.size()) {
        uint32_t b0 = static_cast<uint8_t>(s[i++]);
        uint32_t b1 = static_cast<uint8_t>(s[i++]);
        uint32_t b2 = static_cast<uint8_t>(s[i++]);

        uint32_t v = (b0 << 16) | (b1 << 8) | b2;
        out.push_back(t[(v >> 18) & 63]);
        out.push_back(t[(v >> 12) & 63]);
        out.push_back(t[(v >> 6) & 63]);
        out.push_back(t[v & 63]);
    }
    size_t rem = s.size() - i;
    if (rem) {
        uint32_t v = static_cast<uint8_t>(s[i++]) << 16;
        if (rem == 2) {
            v |= static_cast<uint8_t>(s[i++]) << 8;
        }
        out.push_back(t[(v >> 18) & 63]);
        out.push_back(t[(v >> 12) & 63]);
        out.push_back(rem == 2 ? t[(v >> 6) & 63] : '=');
        out.push_back('=');
    }
    return out;
}

// ──────────────────────────────────────────────────────────────
// YouTube ID Extraction
// ──────────────────────────────────────────────────────────────
inline std::string yt_extract_id(const std::string& urlOrId)
{
    const std::string s = urlOrId;

    // If it's already a bare ID (11 chars, no URL-ish chars), accept it.
    if (s.size() == 11 && s.find_first_of("?/&=#") == std::string::npos)
        return s;

    auto take_token = [&](size_t start) -> std::string {
        if (start == std::string::npos)
            return {};
        size_t end = s.find_first_of("&#?&/\"", start);
        std::string tok = s.substr(start, end == std::string::npos ? std::string::npos : end - start);
        return tok.size() >= 11 ? tok.substr(0, 11) : tok;
    };

    // watch?v=VIDEO_ID
    if (auto p = s.find("v="); p != std::string::npos)
        return take_token(p + 2);

    // youtu.be/VIDEO_ID
    if (auto p = s.find("youtu.be/"); p != std::string::npos)
        return take_token(p + 9);

    // youtube.com/embed/VIDEO_ID
    if (auto p = s.find("/embed/"); p != std::string::npos)
        return take_token(p + 7);

    // youtube-nocookie.com/embed/VIDEO_ID
    if (auto p = s.find("youtube-nocookie.com/embed/"); p != std::string::npos)
        return take_token(p + std::string("youtube-nocookie.com/embed/").size());

    return {};
}

// ──────────────────────────────────────────────────────────────
// File Loading
// ──────────────────────────────────────────────────────────────
inline std::string load_file(const std::string& path)
{
    std::ifstream file(path, std::ios::binary | std::ios::ate);
    if (!file)
        return {};
    auto size = file.tellg();
    file.seekg(0, std::ios::beg);
    std::string data(size, '\0');
    file.read(&data[0], size);
    return data;
}

// ──────────────────────────────────────────────────────────────
// JavaScript Helpers (DOM-ready wrappers)
// ──────────────────────────────────────────────────────────────
inline std::string when_ready(const std::string& body)
{
    return "(function W(){ if(window.GMUI && document.body){ " + body +
           " } else { setTimeout(W,50); } })();";
}

inline std::string when_ready_el(int handle, const std::string& body)
{
    return "(function W(){"
           " if (window.GMUI) {"
           "   var el = document.getElementById('gm_btn_" +
           std::to_string(handle) +
           "');"
           "   if (el) { " +
           body +
           " return; }"
           " }"
           " setTimeout(W,50);"
           "})();";
}

// ──────────────────────────────────────────────────────────────
// JSON Parsing Helper
// ──────────────────────────────────────────────────────────────
inline bool extract_first_arg_json(const std::string& raw, std::string& first)
{
    try {
        auto j = nlohmann::json::parse(raw);
        if (j.is_array() && !j.empty() && j[0].is_string()) {
            first = j[0].get<std::string>();
            return true;
        }
        if (j.is_string()) {
            first = j.get<std::string>();
            return true;
        }
    } catch (...) {
    }
    return false;
}

// ──────────────────────────────────────────────────────────────
// Button Image Computation
// ──────────────────────────────────────────────────────────────
// Default close button SVG
static const char* kDefaultBtnSvg =
    "data:image/svg+xml;utf8,"
    "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'>"
    "<circle cx='50' cy='50' r='50' fill='rgba(0,0,0,0.66)'/>"
    "<path d='M30 30 L70 70 M70 30 L30 70' stroke='white' stroke-width='12' stroke-linecap='round'/>"
    "</svg>";

inline std::string compute_button_image(WebViewButtonAssetType assetType, const std::string& asset)
{
    switch (assetType) {
    case WebViewButtonAssetType::DefaultIcon:
        return kDefaultBtnSvg;
    case WebViewButtonAssetType::FilePath: {
        auto raw = load_file(asset);
        return "data:image/png;base64," + b64encode(raw);
    }
    case WebViewButtonAssetType::Base64Data:
        return "data:image/png;base64," + asset;
    case WebViewButtonAssetType::RawData:
        return asset;
    }
    return asset;
}

} // namespace utils
} // namespace webviewcpp
