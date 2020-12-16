import 'package:http/http.dart' as http;
import 'package:zemoga_posts/core/services/api/api_provider.dart';

import 'repositories.dart';

http.Client httpClient = http.Client();

final PostsRepository postsRepository =
    PostsRepository(apiProvider: ApiProvider(httpClient: httpClient));
