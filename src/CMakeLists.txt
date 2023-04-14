# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(zbar_scan_plugin_library VERSION 0.0.1 LANGUAGES C)

add_library(zbar_scan_plugin SHARED
  "zbar_scan_plugin.c"
)

target_link_libraries(zbar_scan_plugin zbar png)

set_target_properties(zbar_scan_plugin PROPERTIES
  PUBLIC_HEADER zbar_scan_plugin.h
  OUTPUT_NAME "zbar_scan_plugin"
)

target_compile_definitions(zbar_scan_plugin PUBLIC DART_SHARED_LIB)
