class DeepLinkFileCache {
  static final DeepLinkFileCache instance = DeepLinkFileCache._();
  DeepLinkFileCache._();

  String? _filePath;
  String? _providerName;

  void setFile({required String filePath, String? providerName}) {
    _filePath = filePath;
    _providerName = providerName;
  }

  // ADD THIS - Check without clearing
  bool hasFile() {
    return _filePath != null;
  }

  // This clears after reading
  Map<String, String?>? getAndClearFile() {
    if (_filePath == null) return null;
    
    final data = {
      'filePath': _filePath,
      'providerName': _providerName,
    };
    
    _filePath = null;
    _providerName = null;
    
    return data;
  }
}