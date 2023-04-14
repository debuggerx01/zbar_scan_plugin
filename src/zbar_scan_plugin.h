#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zbar.h"
#include "png.h"

#if _WIN32
#include <windows.h>
#else
#include <pthread.h>
#include <unistd.h>
#endif

#if _WIN32
#define FFI_PLUGIN_EXPORT __declspec(dllexport)
#else
#define FFI_PLUGIN_EXPORT
#endif

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    char *content;
    unsigned int pointsCount;
    Point *points;
} Code;

typedef struct {
    unsigned int codesCount;
    Code *codes;
} ScanResult;

FFI_PLUGIN_EXPORT ScanResult scan(char *imagePath);
