/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $AssetsFavIconsGen {
  const $AssetsFavIconsGen();

  /// File path: assets/favIcons/epic.svg
  SvgGenImage get epic => const SvgGenImage('assets/favIcons/epic.svg');

  /// List of all assets
  List<SvgGenImage> get values => [epic];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/allergies.svg
  SvgGenImage get allergies => const SvgGenImage('assets/icons/allergies.svg');

  /// File path: assets/icons/care-plans.svg
  SvgGenImage get carePlans => const SvgGenImage('assets/icons/care-plans.svg');

  /// File path: assets/icons/care-team.svg
  SvgGenImage get careTeam => const SvgGenImage('assets/icons/care-team.svg');

  /// File path: assets/icons/clinical-notes.svg
  SvgGenImage get clinicalNotes =>
      const SvgGenImage('assets/icons/clinical-notes.svg');

  /// File path: assets/icons/demographics.svg
  SvgGenImage get demographics =>
      const SvgGenImage('assets/icons/demographics.svg');

  /// File path: assets/icons/epic.svg
  SvgGenImage get epic => const SvgGenImage('assets/icons/epic.svg');

  /// File path: assets/icons/facilities.svg
  SvgGenImage get facilities =>
      const SvgGenImage('assets/icons/facilities.svg');

  /// File path: assets/icons/files.svg
  SvgGenImage get files => const SvgGenImage('assets/icons/files.svg');

  /// File path: assets/icons/health-assessments.svg
  SvgGenImage get healthAssessments =>
      const SvgGenImage('assets/icons/health-assessments.svg');

  /// File path: assets/icons/health-goals.svg
  SvgGenImage get healthGoals =>
      const SvgGenImage('assets/icons/health-goals.svg');

  /// File path: assets/icons/health-issues.svg
  SvgGenImage get healthIssues =>
      const SvgGenImage('assets/icons/health-issues.svg');

  /// File path: assets/icons/immunizations.svg
  SvgGenImage get immunizations =>
      const SvgGenImage('assets/icons/immunizations.svg');

  /// File path: assets/icons/implants.svg
  SvgGenImage get implants => const SvgGenImage('assets/icons/implants.svg');

  /// File path: assets/icons/lab-results.svg
  SvgGenImage get labResults =>
      const SvgGenImage('assets/icons/lab-results.svg');

  /// File path: assets/icons/medications.svg
  SvgGenImage get medications =>
      const SvgGenImage('assets/icons/medications.svg');

  /// File path: assets/icons/moon.svg
  SvgGenImage get moon => const SvgGenImage('assets/icons/moon.svg');

  /// File path: assets/icons/procedures.svg
  SvgGenImage get procedures =>
      const SvgGenImage('assets/icons/procedures.svg');

  /// File path: assets/icons/proxyinformation.svg
  SvgGenImage get proxyinformation =>
      const SvgGenImage('assets/icons/proxyinformation.svg');

  /// File path: assets/icons/sun.svg
  SvgGenImage get sun => const SvgGenImage('assets/icons/sun.svg');

  /// File path: assets/icons/visits.svg
  SvgGenImage get visits => const SvgGenImage('assets/icons/visits.svg');

  /// File path: assets/icons/vitalsigns.svg
  SvgGenImage get vitalsigns =>
      const SvgGenImage('assets/icons/vitalsigns.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        allergies,
        carePlans,
        careTeam,
        clinicalNotes,
        demographics,
        epic,
        facilities,
        files,
        healthAssessments,
        healthGoals,
        healthIssues,
        immunizations,
        implants,
        labResults,
        medications,
        moon,
        procedures,
        proxyinformation,
        sun,
        visits,
        vitalsigns
      ];
}

class Assets {
  const Assets._();

  static const $AssetsFavIconsGen favIcons = $AssetsFavIconsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
