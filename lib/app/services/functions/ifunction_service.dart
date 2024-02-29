abstract interface class IFunctionService {
  Future<void> increaseRating(String id);
  Future<void> decreaseRating(String id);
}
