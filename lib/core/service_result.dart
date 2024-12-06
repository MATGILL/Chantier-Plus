/// A generic class to handle service results and errors in a Flutter application.
///
/// This class replaces the need for external packages like `dartz` or `fpdart`
/// by providing a simple structure for managing success and error states when
/// dealing with asynchronous operations.
///
/// Example usage:
///
/// ```dart
/// Future<ServiceResult<List<Item>>> fetchItems() async {
///   try {
///     // Simulate an asynchronous operation (e.g., API call)
///     final List<Item> items = await apiClient.getItems();
///     return ServiceResult(content: items);
///   } catch (e) {
///     return ServiceResult(error: e.toString());
///   }
/// }
///
/// final result = await fetchItems();
///
/// if (result.success) {
///   // Process the data here
///   final items = result.content;
///   // ... use the items
/// } else {
///   // Display an error message
///   print(result.getErrorMessage());
/// }
/// ```
///
/// The class has the following properties:
/// - [content]: The returned value from the service of type `T`. Can be `null` if an error occurs.
/// - [error]: A string representing the error message, defaults to an empty string. If an error occurs, this contains a descriptive message.
/// - [success]: A boolean indicating whether the operation was successful. Returns `true` if `content` is not `null` and `error` is empty.
///
/// Methods:
/// - [getErrorMessage()]: Returns a descriptive error message. If `error` is empty, returns "Unknown error occurred".
class ServiceResult<T> {
  ServiceResult({this.content, this.error = ''});
  final String error;
  final T? content;
  bool get success => content != null && error.isEmpty;

  String getErrorMessage() => error.isEmpty ? "Unknown error occurred" : error;
}
