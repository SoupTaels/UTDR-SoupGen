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
// Used by window_set_icon.rc

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

#if ((defined(_MSVC_LANG) && _MSVC_LANG >= 201703L) || __cplusplus >= 201703L)
#define tiny_cpp17
#endif

#if defined(WIN32)
#define dllx extern "C" __declspec(dllexport)
#elif defined(GNUC)
#define dllx extern "C" __attribute__ ((visibility("default"))) 
#else
#define dllx extern "C"
#endif

#define _trace // requires user32.lib;Kernel32.lib

#ifdef TINY // common things to implement
//#define tiny_memset
#define tiny_memcpy
#define tiny_malloc
//#define tiny_dtoui3
#endif

#ifdef _trace
static constexpr char trace_prefix[] = "[window_set_icon] ";
#ifdef _WINDOWS
void trace(const char* format, ...);
#else
#define trace(...) { printf("%s", trace_prefix); printf(__VA_ARGS__); printf("\n"); fflush(stdout); }
#endif
#endif

#pragma region typed memory helpers
template<typename T> T* malloc_arr(size_t count) {
	return (T*)malloc(sizeof(T) * count);
}
template<typename T> T* realloc_arr(T* arr, size_t count) {
	return (T*)realloc(arr, sizeof(T) * count);
}
template<typename T> T* memcpy_arr(T* dst, const T* src, size_t count) {
	return (T*)memcpy(dst, src, sizeof(T) * count);
}
#pragma endregion

#include "gml_ext.h"

// TODO: reference additional headers your program requires here
#pragma once

// Including SDKDDKVer.h defines the highest available Windows platform.

// If you wish to build your application for a previous Windows platform, include WinSDKVer.h and
// set the _WIN32_WINNT macro to the platform you wish to support before including SDKDDKVer.h.

#include <SDKDDKVer.h>
#pragma once
#include "stdafx.h"

template<typename T> class tiny_array {
	T* _data;
	size_t _size;
	size_t _capacity;

	bool add_impl(T value) {
		if (_size >= _capacity) {
			auto new_capacity = _capacity * 2;
			auto new_data = realloc_arr(_data, _capacity);
			if (new_data == nullptr) {
				trace("Failed to reallocate %u bytes in tiny_array::add", sizeof(T) * new_capacity);
				return false;
			}
			for (size_t i = _capacity; i < new_capacity; i++) new_data[i] = {};
			_data = new_data;
			_capacity = new_capacity;
		}
		_data[_size++] = value;
		return true;
	}
public:
	tiny_array() { }
	tiny_array(size_t capacity) { init(capacity); }
	inline void init(size_t capacity = 4) {
		if (capacity < 1) capacity = 1;
		_size = 0;
		_capacity = capacity;
		_data = malloc_arr<T>(capacity);
	}
	inline void free() {
		if (_data) {
			::free(_data);
			_data = nullptr;
		}
	}

	size_t size() { return _size; }
	size_t capacity() { return _capacity; }
	T* data() { return _data; }

	bool resize(size_t newsize, T value = {}) {
		if (newsize > _capacity) {
			auto new_data = realloc_arr(_data, newsize);
			if (new_data == nullptr) {
				trace("Failed to reallocate %u bytes in tiny_array::resize", sizeof(T) * newsize);
				return false;
			}
			_data = new_data;
			_capacity = newsize;
		}
		for (size_t i = _size; i < newsize; i++) _data[i] = value;
		for (size_t i = _size; --i >= newsize;) _data[i] = value;
		_size = newsize;
		return true;
	}

	#ifdef tiny_cpp17
	template<class... Args>
	inline bool add(Args... values) {
		return (add_impl(values) && ...);
	}
	#else
	inline void add(T value) {
		add_impl(value);
	}
	#endif

	bool remove(size_t index, size_t count = 1) {
		size_t end = index + count;
		if (end < _size) memcpy_arr(_data + start, _data + end, _size - end);
		_size -= end - index;
		return true;
	}

	bool set(T* values, size_t count) {
		if (!resize(count)) return false;
		memcpy_arr(_data, values, count);
		return true;
	}
	template<size_t count> inline bool set(T(&values)[count]) {
		return set(values, count);
	}

	T operator[] (size_t index) const { return _data[index]; }
	T& operator[] (size_t index) { return _data[index]; }
};#pragma once
#include "stdafx.h"

template<typename C> class tiny_string_t {
	C* _data = nullptr;
	size_t _size = 0;
	size_t _capacity = 0;
public:
	tiny_string_t() {}
	inline void init(size_t capacity = 32) {
		_data = malloc_arr<C>(capacity);
		_size = 0;
		_capacity = capacity;
	}
	inline void init(const C* val) {
		init(4);
		set(val);
	}

	inline size_t size() { return _size; }
	inline void setSize(size_t size) { _size = size; }

	inline bool empty() {
		return _size == 0;
	}
	inline C* c_str() {
		return _data;
	}
	inline C* prepare(size_t capacity) {
		if (_capacity < capacity) {
			auto new_data = realloc_arr(_data, capacity);
			if (new_data == nullptr) {
				trace("Failed to reallocate %u bytes in tiny_string::prepare", sizeof(C) * capacity);
				return nullptr;
			}
			_data = new_data;
			_capacity = capacity;
		}
		return _data;
	}
	inline const C* set(const C* value, size_t len = SIZE_MAX) {
		if (len == SIZE_MAX) {
			const C* iter = value;
			len = 1;
			while (*iter) { iter++; len++; }
		}
		C* result = prepare(len);
		memcpy_arr(result, value, len);
		_size = len - 1;
		return result;
	}
	//
	inline void operator=(const C* value) { set(value); }
	template<size_t size> inline void operator =(const C(&value)[size]) { set(value, size); }
};
struct tiny_string : public tiny_string_t<char> {
public:
	inline char* conv(const wchar_t* wstr) {
		auto size = WideCharToMultiByte(CP_UTF8, 0, wstr, -1, NULL, 0, NULL, NULL);
		auto str = prepare(size);
		WideCharToMultiByte(CP_UTF8, 0, wstr, -1, str, size, NULL, NULL);
		setSize(size);
		return str;
	}

	inline void operator=(const char* value) { set(value); }
	template<size_t size> inline void operator =(const char(&value)[size]) { set(value, size); }
};
struct tiny_wstring : public tiny_string_t<wchar_t> {
public:
	inline wchar_t* conv(const char* str) {
		auto size = MultiByteToWideChar(CP_UTF8, 0, str, -1, NULL, 0);
		auto wstr = prepare(size);
		MultiByteToWideChar(CP_UTF8, 0, str, -1, wstr, size);
		setSize(size);
		return wstr;
	}

	inline void operator=(const wchar_t* value) { set(value); }
	template<size_t size> inline void operator =(const wchar_t(&value)[size]) { set(value, size); }
};#include "gml_ext.h"
extern bool window_set_icon_init_raw(double isRGBA);
dllx double window_set_icon_init_raw_raw(void* _in_ptr, double _in_ptr_size) {
	gml_istream _in(_in_ptr);
	double _arg_isRGBA;
	_arg_isRGBA = _in.read<double>();
	return window_set_icon_init_raw(_arg_isRGBA);
}

// stdafx.cpp : source file that includes just the standard includes
// window_set_icon.pch will be the pre-compiled header
// stdafx.obj will contain the pre-compiled type information

#include "stdafx.h"
#include <strsafe.h>
#ifdef tiny_dtoui3
#include <intrin.h>
#endif

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
	char buf[1024 + sizeof(trace_prefix)];
	wsprintfA(buf, "%s", trace_prefix);
	va_list argList;
	va_start(argList, pszFormat);
	wvsprintfA(buf + sizeof(trace_prefix) - 1, pszFormat, argList);
	va_end(argList);
	DWORD done;
	auto len = strlen(buf);
	buf[len] = '\n';
	buf[++len] = 0;
	WriteFile(GetStdHandle(STD_OUTPUT_HANDLE), buf, (DWORD)len, &done, NULL);
}
#endif
#endif

#pragma warning(disable: 28251 28252)

#ifdef tiny_memset
#pragma function(memset)
void* __cdecl memset(void* _Dst, _In_ int _Val,_In_ size_t _Size) {
	auto ptr = static_cast<uint8_t*>(_Dst);
	while (_Size) {
		*ptr++ = _Val;
		_Size--;
	}
	return _Dst;
}
#endif

#ifdef tiny_memcpy
#pragma function(memcpy)
void* memcpy(void* _Dst, const void* _Src, size_t _Size) {
	auto src8 = static_cast<const uint64_t*>(_Src);
	auto dst8 = static_cast<uint64_t*>(_Dst);
	for (; _Size > 32; _Size -= 32) {
		*dst8++ = *src8++;
		*dst8++ = *src8++;
		*dst8++ = *src8++;
		*dst8++ = *src8++;
	}
	for (; _Size > 8; _Size -= 8) *dst8++ = *src8++;
	//
	auto src1 = (const uint8_t*)(src8);
	auto dst1 = (uint8_t*)(dst8);
	for (; _Size != 0; _Size--) *dst1++ = *src1++;
	return _Dst;
}
#endif

#ifdef tiny_malloc
void* __cdecl malloc(size_t _Size) {
	return HeapAlloc(GetProcessHeap(), 0, _Size);
}
void* __cdecl realloc(void* _Block, size_t _Size) {
	return HeapReAlloc(GetProcessHeap(), 0, _Block, _Size);
}
void __cdecl free(void* _Block) {
	HeapFree(GetProcessHeap(), 0, _Block);
}
#endif

#ifdef tiny_dtoui3
// https:/stackoverflow.com/a/55011686/5578773
extern "C" unsigned int _dtoui3(const double x) {
	return (unsigned int)_mm_cvttsd_si32(_mm_set_sd(x));
}
#endif

char* strncpy(char* _dest, const char* _source, size_t _size) {
	if (_size == 0) return _dest;
	auto len = strlen(_source);
	if (len > _size - 1) len = _size - 1;
	memcpy(_dest, _source, len + 1);
	return _dest;
}

#pragma warning(default: 28251 28252)
/// @author YellowAfterlife

#define _HAS_STD_BYTE 0
#include "stdafx.h"
#include <CommCtrl.h>
#include <shlobj.h>
#include "tiny_string.h"

tiny_wstring utf8;

ITaskbarList3* taskbarList3 = nullptr;

typedef struct {
	BYTE        bWidth;          // Width, in pixels, of the image
	BYTE        bHeight;         // Height, in pixels, of the image
	BYTE        bColorCount;     // Number of colors in image (0 if >=8bpp)
	BYTE        bReserved;       // Reserved ( must be 0)
	WORD        wPlanes;         // Color Planes
	WORD        wBitCount;       // Bits per pixel
	DWORD       dwBytesInRes;    // How many bytes in this resource?
	DWORD       dwImageOffset;   // Where in the file is this image?
} ICONDIRENTRY, * LPICONDIRENTRY;

struct window_set_icon_data {
	int32_t size;
	HRESULT result;
	char info[120];
	inline bool set(HRESULT _result, const char* _info, bool _ret = false) {
		result = _result;
		strncpy(info, _info, sizeof(info));
		return _ret;
	}
	inline bool setLastError(const char* _info, bool _ret = false) {
		auto e = GetLastError();
		result = HRESULT_FROM_WIN32(e);
		strncpy(info, _info, sizeof(info));
		return _ret;
	}
};

struct {
	HICON bigIcon = NULL, smallIcon = NULL;
	bool isSet = false;
	void check(HWND hwnd) {
		if (!isSet) {
			isSet = true;
			bigIcon = (HICON)SendMessageW(hwnd, WM_GETICON, ICON_BIG, 0);
			smallIcon = (HICON)SendMessageW(hwnd, WM_GETICON, ICON_SMALL, 0);
		}
	}
} defIcon;

struct PreserveIcon {
	HICON icon = NULL;
	void init() {
		icon = NULL;
	}
	void set(HICON val) {
		if (icon) DestroyIcon(icon);
		icon = val;
	}
};
struct PreserveBitmap {
	HBITMAP bitmap = NULL;
	void init() {
		bitmap = NULL;
	}
	void set(HBITMAP val) {
		if (bitmap) DeleteObject(bitmap);
		bitmap = val;
	}
};

static struct {
	HICON icons[2]{};
	bool enable = false;
	WNDPROC base = nullptr;
	void init() {
		icons[0] = false;
		icons[1] = false;
		enable = false;
		base = nullptr;
	}
} window_icon_hook;

LRESULT window_command_proc_hook(HWND hwnd, UINT msg, WPARAM wp, LPARAM lp) {
	if (msg == WM_SETICON && window_icon_hook.enable) {
		HICON icon;
		switch (wp) {
			case ICON_SMALL:
				icon = window_icon_hook.icons[0];
				break;
			case ICON_BIG:
				icon = window_icon_hook.icons[1];
				break;
			default: icon = NULL;
		}
		if (icon != NULL) lp = (LPARAM)icon;
	}
	return CallWindowProc(window_icon_hook.base, hwnd, msg, wp, lp);
}
void window_icon_hook_ensure(HWND hwnd) {
	if (window_icon_hook.base == nullptr) {
		window_icon_hook.base = (WNDPROC)SetWindowLongPtr(hwnd, GWLP_WNDPROC, (LONG_PTR)window_command_proc_hook);
	}
}

PBYTE PickBestMatchIcon(BYTE* icoData, size_t icoSize, int cx, int cy) {
	auto count = *(WORD*)(icoData + 2 * sizeof(WORD));
	if (count == 0) return NULL;
	auto entries = (ICONDIRENTRY*)(icoData + 3 * sizeof(WORD));

	// direct match?:
	for (int i = 0; i < count; i++) {
		auto& entry = entries[i];
		if (entry.bColorCount > 0) continue;
		if (entry.bWidth == cx && entry.bHeight == cy) return icoData + entry.dwImageOffset;
	}

	// smallest icon that is >=2x?:
	int bw = 0, bh = 0;
	PBYTE bb = NULL;
	for (int i = 0; i < count; i++) {
		auto& entry = entries[i];
		if (entry.bColorCount > 0) continue;
		auto w = entry.bWidth;
		auto h = entry.bHeight;
		if (w < cx * 2 || h < cy * 2) continue;
		if (bb == NULL || (w < bw && h < bh)) {
			bb = icoData + entry.dwImageOffset;
			bw = w;
			bh = h;
		}
	}
	if (bb) return bb;

	// just pick the biggest icon then:
	bw = 0; bh = 0;
	bb = NULL;
	for (int i = 0; i < count; i++) {
		auto& entry = entries[i];
		if (entry.bColorCount > 0) continue;
		auto w = entry.bWidth;
		auto h = entry.bHeight;
		if (w > bw && h > bh)
			if (w < cx * 2 || h < cy * 2) continue;
		if (bb == NULL || (w < bw && h < bh)) {
			bb = icoData + entry.dwImageOffset;
			bw = w;
			bh = h;
		}
	}
	return bb;
}

HICON LoadIconFromBuffer(BYTE* data, size_t size, int cx, int cy) {
	// https://stackoverflow.com/a/51806326/5578773
	auto icon_count = *(WORD*)(data + 2 * sizeof(WORD));
	auto resBits = PickBestMatchIcon(data, size, cx, cy);
	auto resSize = data + size - resBits;
	// "This parameter is generally set to 0x00030000."
	// https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-createiconfromresourceex
	constexpr auto ver = 0x00030000;
	return CreateIconFromResourceEx(resBits, (DWORD)resSize, TRUE, ver, cx, cy, LR_DEFAULTCOLOR);
}

PreserveIcon currSmall, currBig;
dllx double window_set_icon_raw(void* _hwnd, uint8_t* data, window_set_icon_data* out) {

	auto cx = GetSystemMetrics(SM_CXSMICON);
	auto cy = GetSystemMetrics(SM_CYSMICON);
	auto nextSmall = LoadIconFromBuffer(data, out->size, cx, cy);
	if (!nextSmall) {
		auto error = GetLastError();
		auto result = HRESULT_FROM_WIN32(error);
		out->set(result, "CreateIconFromResourceEx (small)");
		return false;
	}

	cx = GetSystemMetrics(SM_CXICON);
	cy = GetSystemMetrics(SM_CYICON);
	auto nextBig = LoadIconFromBuffer(data, out->size, cx, cy);
	if (!nextBig) {
		auto error = GetLastError();
		auto result = HRESULT_FROM_WIN32(error);
		out->set(result, "CreateIconFromResourceEx (big)");
		DestroyIcon(nextSmall);
		return false;
	}

	auto hwnd = (HWND)_hwnd;
	defIcon.check(hwnd);

	currSmall.set(nextSmall);
	currBig.set(nextBig);

	window_icon_hook.icons[0] = nextSmall;
	window_icon_hook.icons[1] = nextBig;
	window_icon_hook_ensure(hwnd);

	window_icon_hook.enable = false;
	SendMessage(hwnd, WM_SETICON, ICON_SMALL, (LPARAM)nextSmall);
	SendMessage(hwnd, WM_SETICON, ICON_BIG, (LPARAM)nextBig);
	window_icon_hook.enable = true;

	out->set(S_OK, "All good!");
	return true;
}

struct window_set_icon_surface_data {
	int32_t width;
	int32_t height;
	int32_t flags;
	HRESULT result;
	char info[112];
	inline bool set(HRESULT _result, const char* _info, bool _ret = false) {
		result = _result;
		strncpy(info, _info, sizeof(info));
		return _ret;
	}
	inline bool setLastError(const char* _info, bool _ret = false) {
		auto e = GetLastError();
		result = HRESULT_FROM_WIN32(e);
		strncpy(info, _info, sizeof(info));
		return _ret;
	}
};
inline HICON CreateIconFromBitmap(HBITMAP bmp) {
	ICONINFO inf{};
	inf.fIcon = true;
	inf.hbmMask = bmp;
	inf.hbmColor = bmp;
	return CreateIconIndirect(&inf);
}
static bool SwapRedBlue_needed = true;
void SwapRedBlue(uint8_t* buf, size_t count) {
	if (!SwapRedBlue_needed) return;
	size_t i = 0;
	const size_t count_nand_3 = count & ~3;
	while (i < count_nand_3) {
		std::swap(buf[i], buf[i + 2]);
		std::swap(buf[i + 4], buf[i + 6]);
		std::swap(buf[i + 8], buf[i + 10]);
		std::swap(buf[i + 12], buf[i + 14]);
		i += 16;
	}
	for (; i < count; i += 4) std::swap(buf[i], buf[i + 2]);
}

dllx double window_set_icon_surface_raw(void* _hwnd, uint8_t* rgba, window_set_icon_surface_data* out) {
	static PreserveIcon lastIcon[2];
	static PreserveBitmap lastBitmap[2];
	//
	SwapRedBlue(rgba, out->width * out->height * 4);
	auto bmp = CreateBitmap(out->width, out->height, 1, 32, rgba);
	if (bmp == NULL) return out->set(E_FAIL, "CreateBitmap");
	//
	auto icon = CreateIconFromBitmap(bmp);
	if (icon == NULL) {
		DeleteObject(bmp);
		return out->setLastError("CreateIconIndirect");
	}
	//
	int big = (out->flags & 1);
	lastIcon[big].set(icon);
	lastBitmap[big].set(bmp);
	window_icon_hook.icons[big] = icon;
	//
	auto hwnd = (HWND)_hwnd;
	defIcon.check(hwnd);
	WPARAM wp = big ? ICON_BIG : ICON_SMALL;

	window_icon_hook_ensure(hwnd);
	window_icon_hook.enable = false;
	SendMessage(hwnd, WM_SETICON, wp, (LPARAM)icon);
	window_icon_hook.enable = true;

	out->set(S_OK, "All good!");
	return true;
}

dllx double window_reset_icon_raw(void* _hwnd) {
	if (!defIcon.isSet) return true;
	auto hwnd = (HWND)_hwnd;
	window_icon_hook.icons[0] = NULL;
	window_icon_hook.icons[1] = NULL;

	window_icon_hook.enable = false;
	SendMessage(hwnd, WM_SETICON, ICON_SMALL, (LPARAM)defIcon.smallIcon);
	SendMessage(hwnd, WM_SETICON, ICON_BIG, (LPARAM)defIcon.bigIcon);
	window_icon_hook.enable = true;

	return true;
}

dllx double window_sync_icon_raw(void* _hwnd) {
	if (!defIcon.isSet) return true;
	auto hwnd = (HWND)_hwnd;
	HICON icon;

	window_icon_hook.enable = false;
	//
	icon = window_icon_hook.icons[0];
	if (icon == NULL) icon = defIcon.smallIcon;
	SendMessage(hwnd, WM_SETICON, ICON_SMALL, (LPARAM)icon);
	//
	icon = window_icon_hook.icons[1];
	if (icon == NULL) icon = defIcon.bigIcon;
	SendMessage(hwnd, WM_SETICON, ICON_BIG, (LPARAM)defIcon.bigIcon);
	//
	window_icon_hook.enable = true;

	return true;
}

dllx double window_set_overlay_icon_raw(void* hwnd, uint8_t* data, const char* desc, window_set_icon_data* out) {
	static PreserveIcon lastIcon;

	//
	if (!taskbarList3) {
		auto result = CoCreateInstance(CLSID_TaskbarList, NULL, CLSCTX_ALL, IID_ITaskbarList3, (void**)&taskbarList3);
		if (result != S_OK) {
			out->set(result, "CoCreateInstance(CLSID_TaskbarList)");
			return false;
		}
	}

	auto cx = GetSystemMetrics(SM_CXSMICON);
	auto cy = GetSystemMetrics(SM_CYSMICON);
	auto icon = LoadIconFromBuffer(data, out->size, cx, cy);
	if (!icon) {
		auto error = GetLastError();
		auto result = HRESULT_FROM_WIN32(error);
		out->set(result, "CreateIconFromResourceEx");
		return false;
	}

	//
	auto result = taskbarList3->SetOverlayIcon((HWND)hwnd, icon, utf8.conv(desc));
	if (result != S_OK) {
		DestroyIcon(icon);
		out->set(result, "ITaskbarList3::SetOverlayIcon");
		return false;
	}
	lastIcon.set(icon);
	out->set(S_OK, "All good!");
	return true;
}

dllx double window_set_overlay_icon_surface_raw(void* _hwnd, uint8_t* rgba, const char* desc, window_set_icon_surface_data* out) {
	static PreserveIcon lastIcon;
	static PreserveBitmap lastBitmap;

	//
	if (!taskbarList3) {
		auto result = CoCreateInstance(CLSID_TaskbarList, NULL, CLSCTX_ALL, IID_ITaskbarList3, (void**)&taskbarList3);
		if (result != S_OK) {
			out->set(result, "CoCreateInstance(CLSID_TaskbarList)");
			return false;
		}
	}

	//
	SwapRedBlue(rgba, out->width * out->height * 4);
	auto bmp = CreateBitmap(out->width, out->height, 1, 32, rgba);
	if (bmp == NULL) return out->set(E_FAIL, "CreateBitmap");

	//
	auto icon = CreateIconFromBitmap(bmp);
	if (icon == NULL) {
		DeleteObject(bmp);
		return out->setLastError("CreateIconIndirect");
	}

	//
	auto result = taskbarList3->SetOverlayIcon((HWND)_hwnd, icon, utf8.conv(desc));
	if (result != S_OK) {
		DeleteObject(bmp);
		DestroyIcon(icon);
		return out->set(result, "ITaskbarList3::SetOverlayIcon");
	}
	lastIcon.set(icon);
	lastBitmap.set(bmp);
	return out->set(S_OK, "All good!", true);
}

dllx double window_reset_overlay_icon_raw(void* hwnd) {
	if (!taskbarList3) return true;
	taskbarList3->SetOverlayIcon((HWND)hwnd, NULL, L"");
	return true;
}

dllg bool window_set_icon_init_raw(double isRGBA) {
	SwapRedBlue_needed = isRGBA > 0.5;
	return true;
}

void init() {
	utf8.init();
	currSmall.init();
	currBig.init();
	window_icon_hook.init();
}
BOOL APIENTRY DllMain(HMODULE hModule, DWORD  ul_reason_for_call, LPVOID lpReserved) {
	if (ul_reason_for_call == DLL_PROCESS_ATTACH) init();
	return TRUE;
}
