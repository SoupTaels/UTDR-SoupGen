#pragma once
#include "stdafx.h"
#include <vector>
#if ((defined(_MSVC_LANG) && _MSVC_LANG >= 201703L) || __cplusplus >= 201703L)
#include <optional>
#endif
#include <stdint.h>
#include <cstring>
#include <tuple>
using namespace std;

#define dllg /* tag */

#if defined(WIN32)
#define dllx extern "C" __declspec(dllexport)
#elif defined(GNUC)
#define dllx extern "C" __attribute__ ((visibility("default"))) 
#else
#define dllx extern "C"
#endif

#ifdef _WINDEF_
typedef HWND GAME_HWND;
#endif

struct gml_buffer {
private:
	uint8_t* _data;
	int32_t _size;
	int32_t _tell;
public:
	gml_buffer() : _data(nullptr), _tell(0), _size(0) {}
	gml_buffer(uint8_t* data, int32_t size, int32_t tell) : _data(data), _size(size), _tell(tell) {}

	inline uint8_t* data() { return _data; }
	inline int32_t tell() { return _tell; }
	inline int32_t size() { return _size; }
};

class gml_istream {
	uint8_t* pos;
	uint8_t* start;
public:
	gml_istream(void* origin) : pos((uint8_t*)origin), start((uint8_t*)origin) {}

	template<class T> T read() {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be read");
		T result{};
		std::memcpy(&result, pos, sizeof(T));
		pos += sizeof(T);
		return result;
	}

	char* read_string() {
		char* r = (char*)pos;
		while (*pos != 0) pos++;
		pos++;
		return r;
	}

	template<class T> std::vector<T> read_vector() {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be read");
		auto n = read<uint32_t>();
		std::vector<T> vec(n);
		std::memcpy(vec.data(), pos, sizeof(T) * n);
		pos += sizeof(T) * n;
		return vec;
	}

	gml_buffer read_gml_buffer() {
		auto _data = (uint8_t*)read<int64_t>();
		auto _size = read<int32_t>();
		auto _tell = read<int32_t>();
		return gml_buffer(_data, _size, _tell);
	}

	#pragma region Tuples
	#if ((defined(_MSVC_LANG) && _MSVC_LANG >= 201703L) || __cplusplus >= 201703L)
	template<typename... Args>
	std::tuple<Args...> read_tuple() {
		std::tuple<Args...> tup;
		std::apply([this](auto&&... arg) {
			((
				arg = this->read<std::remove_reference_t<decltype(arg)>>()
				), ...);
			}, tup);
		return tup;
	}

	template<class T> optional<T> read_optional() {
		if (read<bool>()) {
			return read<T>;
		} else return {};
	}
	#else
	template<class A, class B> std::tuple<A, B> read_tuple() {
		A a = read<A>();
		B b = read<B>();
		return std::tuple<A, B>(a, b);
	}

	template<class A, class B, class C> std::tuple<A, B, C> read_tuple() {
		A a = read<A>();
		B b = read<B>();
		C c = read<C>();
		return std::tuple<A, B, C>(a, b, c);
	}

	template<class A, class B, class C, class D> std::tuple<A, B, C, D> read_tuple() {
		A a = read<A>();
		B b = read<B>();
		C c = read<C>();
		D d = read<d>();
		return std::tuple<A, B, C, D>(a, b, c, d);
	}
	#endif
};

class gml_ostream {
	uint8_t* pos;
	uint8_t* start;
public:
	gml_ostream(void* origin) : pos((uint8_t*)origin), start((uint8_t*)origin) {}

	template<class T> void write(T val) {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be write");
		memcpy(pos, &val, sizeof(T));
		pos += sizeof(T);
	}

	void write_string(const char* s) {
		for (int i = 0; s[i] != 0; i++) write<char>(s[i]);
		write<char>(0);
	}

	template<class T> void write_vector(std::vector<T>& vec) {
		static_assert(std::is_trivially_copyable_v<T>, "T must be trivially copyable to be write");
		auto n = vec.size();
		write<uint32_t>(n);
		memcpy(pos, vec.data(), n * sizeof(T));
		pos += n * sizeof(T);
	}

	#if ((defined(_MSVC_LANG) && _MSVC_LANG >= 201703L) || __cplusplus >= 201703L)
	template<typename... Args>
	void write_tuple(std::tuple<Args...> tup) {
		std::apply([this](auto&&... arg) {
			(this->write(arg), ...);
			}, tup);
	}

	template<class T> void write_optional(optional<T>& val) {
		auto hasValue = val.has_value();
		write<bool>(hasValue);
		if (hasValue) write<T>(val.value());
	}
	#else
	template<class A, class B> void write_tuple(std::tuple<A, B>& tup) {
		write<A>(std::get<0>(tup));
		write<B>(std::get<1>(tup));
	}
	template<class A, class B, class C> void write_tuple(std::tuple<A, B, C>& tup) {
		write<A>(std::get<0>(tup));
		write<B>(std::get<1>(tup));
		write<C>(std::get<2>(tup));
	}
	template<class A, class B, class C, class D> void write_tuple(std::tuple<A, B, C, D>& tup) {
		write<A>(std::get<0>(tup));
		write<B>(std::get<1>(tup));
		write<C>(std::get<2>(tup));
		write<D>(std::get<3>(tup));
	}
	#endif
};
//{{NO_DEPENDENCIES}}
// Microsoft Visual C++ generated include file.
// Used by window_taskbar.rc

// Next default values for new objects
// 
#ifdef APSTUDIO_INVOKED
#ifndef APSTUDIO_READONLY_SYMBOLS
#define _APS_NEXT_RESOURCE_VALUE        101
#define _APS_NEXT_COMMAND_VALUE         40001
#define _APS_NEXT_CONTROL_VALUE         1001
#define _APS_NEXT_SYMED_VALUE           101
#endif
#endif
// stdafx.h : include file for standard system include files,
// or project specific include files that are used frequently, but
// are changed infrequently
//

#pragma once

#ifdef _WINDOWS
	#include "targetver.h"
	
	#define WIN32_LEAN_AND_MEAN // Exclude rarely-used stuff from Windows headers
	#include <windows.h>
#endif

#if defined(WIN32)
#define dllx extern "C" __declspec(dllexport)
#elif defined(GNUC)
#define dllx extern "C" __attribute__ ((visibility("default"))) 
#else
#define dllx extern "C"
#endif

#define _trace // requires user32.lib;Kernel32.lib

#ifdef _trace
#ifdef _WINDOWS
void trace(const char* format, ...);
#else
#define trace(...) { printf("[window_taskbar:%d] ", __LINE__); printf(__VA_ARGS__); printf("\n"); fflush(stdout); }
#endif
#endif

#include "gml_ext.h"

// TODO: reference additional headers your program requires here
#pragma once

// Including SDKDDKVer.h defines the highest available Windows platform.

// If you wish to build your application for a previous Windows platform, include WinSDKVer.h and
// set the _WIN32_WINNT macro to the platform you wish to support before including SDKDDKVer.h.

#include <SDKDDKVer.h>
#include "gml_ext.h"
extern bool window_progress(GAME_HWND hWnd, int status, uint64_t current, uint64_t total);
dllx double window_progress_raw(void* _in_ptr, double _in_ptr_size) {
	gml_istream _in(_in_ptr);
	GAME_HWND _arg_hWnd;
	_arg_hWnd = (GAME_HWND)_in.read<uint64_t>();
	int _arg_status;
	_arg_status = _in.read<int>();
	uint64_t _arg_current;
	if (_in.read<bool>()) {
		_arg_current = _in.read<uint64_t>();
	} else _arg_current = 0;
	uint64_t _arg_total;
	if (_in.read<bool>()) {
		_arg_total = _in.read<uint64_t>();
	} else _arg_total = 0;
	return window_progress(_arg_hWnd, _arg_status, _arg_current, _arg_total);
}

extern bool window_flash(GAME_HWND hwnd, int flags, uint32_t count, uint32_t freq);
dllx double window_flash_raw(void* _in_ptr, double _in_ptr_size) {
	gml_istream _in(_in_ptr);
	GAME_HWND _arg_hwnd;
	_arg_hwnd = (GAME_HWND)_in.read<uint64_t>();
	int _arg_flags;
	_arg_flags = _in.read<int>();
	uint32_t _arg_count;
	if (_in.read<bool>()) {
		_arg_count = _in.read<uint32_t>();
	} else _arg_count = 0;
	uint32_t _arg_freq;
	if (_in.read<bool>()) {
		_arg_freq = _in.read<uint32_t>();
	} else _arg_freq = 0;
	return window_flash(_arg_hwnd, _arg_flags, _arg_count, _arg_freq);
}

// stdafx.cpp : source file that includes just the standard includes
// window_taskbar.pch will be the pre-compiled header
// stdafx.obj will contain the pre-compiled type information

#include "stdafx.h"
#include <strsafe.h>

#if _WINDOWS
// http://computer-programming-forum.com/7-vc.net/07649664cea3e3d7.htm
extern "C" int _fltused = 0;
#endif

// TODO: reference any additional headers you need in STDAFX.H
// and not in this file
#ifdef _trace
#ifdef _WINDOWS
// https://yal.cc/printf-without-standard-library/
void trace(const char* pszFormat, ...) {
	char buf[1025];
	va_list argList;
	va_start(argList, pszFormat);
	wvsprintfA(buf, pszFormat, argList);
	va_end(argList);
	DWORD done;
	auto len = strlen(buf);
	buf[len] = '\n';
	buf[++len] = 0;
	WriteFile(GetStdHandle(STD_OUTPUT_HANDLE), buf, len, &done, NULL);
}
#endif
#endif
/// @author YellowAfterlife

#include "stdafx.h"
#include <shlobj.h>
#include <stdint.h>

///
enum window_progress_status_t {
    window_progress_none = 0,
    window_progress_unknown = 1,
    window_progress_normal = 2,
    window_progress_error = 4,
    window_progress_paused = 8,
};
dllg bool window_progress(GAME_HWND hWnd, int status, uint64_t current = 0, uint64_t total = 0) {
    static bool ready = false;
    static ITaskbarList3* taskbarList = nullptr;
    if (!ready) {
        ready = true;

        CLSID _clsid{};
        auto hr = CLSIDFromString(L"{56FDF344-FD6D-11D0-958A-006097C9A090}", &_clsid);
        if (hr != NOERROR) {
            trace("Couldn't find CLSID_TaskBarlist: %x", hr);
            return false;
        }

        IID _iid{};
        hr = IIDFromString(L"{ea1afb91-9e28-4b86-90e9-9e9f8a5eefaf}", &_iid);
        if (hr != S_OK) {
            trace("Couldn't find IID_ITaskbarList3: %x", hr);
            return false;
        }

        hr = CoCreateInstance(_clsid, NULL, CLSCTX_ALL, _iid, (void**)&taskbarList);
        if (hr != S_OK) {
            trace("Couldn't CoCreateInstance: %x", hr);
            return false;
        }
    }
    if (taskbarList == nullptr) return false;
    taskbarList->SetProgressState(hWnd, (TBPFLAG)status);
    if (status != TBPF_NOPROGRESS && status != TBPF_INDETERMINATE) {
        taskbarList->SetProgressValue(hWnd, current, total);
    }
    return true;
}
///
enum window_flash_t {
    window_flash_stop = 0,
    window_flash_window = 1,
    window_flash_tray = 2,
    window_flash_all = 3,
    window_flash_timer = 4,
    window_flash_timernofg = 12,
};
dllg bool window_flash(GAME_HWND hwnd, int flags, uint32_t count = 0, uint32_t freq = 0) {
    FLASHWINFO p;
    p.cbSize = sizeof(p);
    p.hwnd = hwnd;
    p.dwFlags = flags;
    p.uCount = count;
    p.dwTimeout = freq;
    return FlashWindowEx(&p);
}