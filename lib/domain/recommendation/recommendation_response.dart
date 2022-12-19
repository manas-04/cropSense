class RecommendationResponse {
  final String predictedCrop;

  const RecommendationResponse(this.predictedCrop);

  factory RecommendationResponse.fromJson(Map<String, dynamic> json) {
    return RecommendationResponse(json['prediction']);
  }
}
