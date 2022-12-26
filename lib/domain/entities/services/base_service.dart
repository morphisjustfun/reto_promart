class BaseServiceEntity<T> {
  final T? data;
  final String message;
  final int status;

  const BaseServiceEntity({
    required this.data,
    required this.message,
    required this.status,
  });

  bool get isSuccess => status == 200;

  bool get isFailure => status != 200;
}
