import 'package:flutter_gemma/mobile/flutter_gemma_mobile.dart';

class SlmModel {
  SlmModel({
    required this.modelFileName,
    required this.modelUrl,
  });

  final String modelFileName;
  final String modelUrl;

  static SlmModel gemmaModel() => SlmModel(
        modelFileName: "gemma-2b-it-gpu-int4.bin",
        modelUrl:
            "https://huggingface.co/google/gemma-2b-it-tflite/resolve/main/gemma-2b-it-gpu-int4.bin",
      );

  InferenceModelSpec toInferenceSpec() =>
      MobileModelManager.createInferenceSpec(
        name: modelFileName,
        modelUrl: modelUrl,
      );
}
