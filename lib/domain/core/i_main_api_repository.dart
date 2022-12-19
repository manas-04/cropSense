abstract class IMainApiRepository<T> {
  Future<T> getRecommededCrop({
    required int n,
    required int p,
    required int k,
    required double rainfall,
    required String city,
    required double ph,
  });
}
