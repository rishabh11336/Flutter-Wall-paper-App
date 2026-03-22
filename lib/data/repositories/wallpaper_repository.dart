import '../models/wallpaper.dart';
import '../sources/github_source.dart';

/// Repository that abstracts data access for wallpapers.
///
/// Currently delegates entirely to [GitHubSource]. Future phases may add
/// local caching, SQLite storage, or favourites persistence here.
class WallpaperRepository {
  WallpaperRepository({GitHubSource? source})
      : _source = source ?? GitHubSource();

  final GitHubSource _source;

  /// Fetches the manifest and returns categories + wallpapers.
  Future<({List<String> categories, List<Wallpaper> wallpapers})>
      getManifest() async {
    return _source.fetchManifest();
  }
}
