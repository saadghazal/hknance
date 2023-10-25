class ErrorHandler {
  final String code;
  final String message;
  final String plugin;

  const ErrorHandler({
    required this.code,
    required this.message,
    required this.plugin,
  });
  factory ErrorHandler.noError(){
    return ErrorHandler(code: '', message: '', plugin: '',);
  }

}