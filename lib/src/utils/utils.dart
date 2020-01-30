final String _imageUrlLarge = "https://image.tmdb.org/t/p/w500/";
final String _imageUrlMedium = "https://image.tmdb.org/t/p/w300/";

String getMediumPictureUrl(String path) => _imageUrlMedium + path;

String getLargePictureUrl(String path) => _imageUrlLarge + path;

enum LoadingState { DONE, LOADING, WAITING, ERROR }

Map<int, String> _genreMap = {
  28: 'Action',
  12: 'Adventure',
  16: 'Animation',
  35: 'Comedy',
  80: 'Crime',
  99: 'Documentary',
  18: 'Drama',
  10751: 'Family',
  10762: 'Kids',
  10759: 'Action & Adventure',
  14: 'Fantasy',
  36: 'History',
  27: 'Horror',
  10402: 'Music',
  9648: 'Mystery',
  10749: 'Romance',
  878: 'Science Fiction',
  10770: 'TV Movie',
  53: 'Thriller',
  10752: 'War',
  37: 'Western',
  10763: '',
  10764: 'Reality',
  10765: 'Sci-Fi & Fantasy',
  10766: 'Soap',
  10767: 'Talk',
  10768: 'War & Politics',
};

List<String> getGenresForIds(List<int> genreIds) =>
    genreIds.map((id) => _genreMap[id]).toList();

String getGenreString(List<int> genreIds) {
  StringBuffer buffer = StringBuffer();
  buffer.writeAll(getGenresForIds(genreIds), ", ");
  return buffer.toString();
}