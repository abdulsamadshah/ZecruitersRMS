/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetImagesGen {
  const $AssetImagesGen();

  /// File path: asset/images/English.png
  AssetGenImage get english => const AssetGenImage('asset/images/English.png');

  /// File path: asset/images/India.png
  AssetGenImage get india => const AssetGenImage('asset/images/India.png');

  /// File path: asset/images/Support.png
  AssetGenImage get support => const AssetGenImage('asset/images/Support.png');

  /// File path: asset/images/appicon.png
  AssetGenImage get appicon => const AssetGenImage('asset/images/appicon.png');

  /// File path: asset/images/enternetlost.jpg
  AssetGenImage get enternetlost =>
      const AssetGenImage('asset/images/enternetlost.jpg');

  /// File path: asset/images/introuductionicon.png
  AssetGenImage get introuductionicon =>
      const AssetGenImage('asset/images/introuductionicon.png');

  /// File path: asset/images/lost_internets.png
  AssetGenImage get lostInternets =>
      const AssetGenImage('asset/images/lost_internets.png');

  /// File path: asset/images/profileui.png
  AssetGenImage get profileui =>
      const AssetGenImage('asset/images/profileui.png');

  /// File path: asset/images/server_error.png
  AssetGenImage get serverError =>
      const AssetGenImage('asset/images/server_error.png');

  /// File path: asset/images/steptwoillustrator.png
  AssetGenImage get steptwoillustrator =>
      const AssetGenImage('asset/images/steptwoillustrator.png');

  /// File path: asset/images/whatsapp.png
  AssetGenImage get whatsapp =>
      const AssetGenImage('asset/images/whatsapp.png');

  /// File path: asset/images/youtube.png
  AssetGenImage get youtube => const AssetGenImage('asset/images/youtube.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        english,
        india,
        support,
        appicon,
        enternetlost,
        introuductionicon,
        lostInternets,
        profileui,
        serverError,
        steptwoillustrator,
        whatsapp,
        youtube
      ];
}

class $AssetSvgGen {
  const $AssetSvgGen();

  /// File path: asset/svg/profileback.svg
  String get profileback => 'asset/svg/profileback.svg';

  /// List of all assets
  List<String> get values => [profileback];
}

class Assets {
  Assets._();

  static const $AssetImagesGen images = $AssetImagesGen();
  static const $AssetSvgGen svg = $AssetSvgGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
