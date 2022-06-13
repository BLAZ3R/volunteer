class ErrorMessage {
  ErrorMessage({
    required this.fieldError,
    required this.messageError,
  });

  String fieldError;
  String messageError;

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => ErrorMessage(
        fieldError: json["fieldError"],
        messageError: json["messageError"],
      );

  Map<String, dynamic> toJson() => {
        "fieldError": fieldError,
        "messageError": messageError,
      };
}
