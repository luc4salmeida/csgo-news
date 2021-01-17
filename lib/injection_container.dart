
import 'package:csgo_flutter/features/games/data/datasources/game_local_data_source.dart';
import 'package:csgo_flutter/features/games/data/datasources/game_remote_data_source.dart';
import 'package:csgo_flutter/features/games/data/repositories/game_repository_impl.dart';
import 'package:csgo_flutter/features/games/domain/repositories/game_repository.dart';
import 'package:csgo_flutter/features/games/domain/usecases/get_last_games.dart';
import 'package:csgo_flutter/features/news/data/datasources/news_local_data_source.dart';
import 'package:csgo_flutter/features/news/data/datasources/news_remote_data_source.dart';
import 'package:csgo_flutter/features/news/data/repositories/news_repository_impl.dart';
import 'package:csgo_flutter/features/news/domain/repositories/news_repository.dart';
import 'package:csgo_flutter/features/news/domain/usecases/get_last_news.dart';
import 'package:csgo_flutter/features/news/presentation/bloc/news_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_info.dart';
import 'features/games/presentation/bloc/games_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

void init() {
  //! Features Games
  initGamesFeature();

  //! Features Games
  initNewsFeature();

  //! Core stuff
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingletonAsync(() => SharedPreferences.getInstance());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}

void initGamesFeature() {
 //Bloc
  sl.registerFactory(
    () => GamesBloc(
      getLastGames: sl()
    )
  );

  //Usecases
  sl.registerLazySingleton(() => GetLastGames(
    sl()
  ));

  // Repositories
  sl.registerLazySingleton<GameRepository>(
    () => GameRepositoryImpl(
      remoteDataSource: sl(), 
      localDataSource: sl(), 
      networkInfo: sl())
  );

  //Data sources
  sl.registerLazySingleton<GameRemoteDataSource>(
    () => GameRemoteDataSourceImpl(httpClient: sl())
  );

  sl.registerLazySingleton<GameLocalDataSource>(
    () => GameLocalDataSourceImpl(sharedPreferences: sl())
  );
}

void initNewsFeature() {
   //Bloc
  sl.registerFactory(
    () => NewsBloc(
      getLastNews: sl()
    )
  );

  //Usecases
  sl.registerLazySingleton(() => GetLastNews(
    sl()
  ));

  // Repositories
  sl.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDataSource: sl(), 
      localDataSource: sl(), 
      networkInfo: sl())
  );

  //Data sources
  sl.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(httpClient: sl())
  );

  sl.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(sharedPreferences: sl())
  );
}