import 'package:ffi/ffi.dart';
import 'dart:ffi' as ffi;
import 'dart:io';

import 'zbar_scan_plugin_bindings_generated.dart';

class PointInfo {
  const PointInfo({
    required this.x,
    required this.y,
  });

  factory PointInfo.fromPoint(Point point) => PointInfo(
        x: point.x,
        y: point.y,
      );

  final int x;
  final int y;
}

class CodeInfo {
  const CodeInfo({
    required this.content,
    required this.points,
  });

  final String content;
  final List<PointInfo> points;

  factory CodeInfo.fromCode(Code code) => CodeInfo(
        content: code.content.cast<Utf8>().toDartString(),
        points: List<PointInfo>.generate(
          code.pointsCount,
          (index) => PointInfo.fromPoint(
            code.points.elementAt(index).ref,
          ),
        ),
      );
}

List<CodeInfo> scan(String imagePath) {
  var scanResult = _bindings.scan(
    imagePath.toNativeUtf8().cast<ffi.Char>(),
  );
  return List<CodeInfo>.generate(
    scanResult.codesCount,
    (index) => CodeInfo.fromCode(scanResult.codes.elementAt(index).ref),
  );
}

const String _libName = 'zbar_scan_plugin';

/// The dynamic library in which the symbols for [ZbarScanPluginBindings] can be found.
final ffi.DynamicLibrary _dylib = () {
  if (Platform.isMacOS || Platform.isIOS) {
    return ffi.DynamicLibrary.open('$_libName.framework/$_libName');
  }
  if (Platform.isAndroid || Platform.isLinux) {
    return ffi.DynamicLibrary.open('lib$_libName.so');
  }
  if (Platform.isWindows) {
    return ffi.DynamicLibrary.open('$_libName.dll');
  }
  throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
}();

/// The bindings to the native functions in [_dylib].
final ZbarScanPluginBindings _bindings = ZbarScanPluginBindings(_dylib);
