import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'HUGGING_FACE_TOKEN', defaultValue: '', obfuscate: true)
  static String huggingFaceToken = _Env.huggingFaceToken;
}
