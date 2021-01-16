import 'package:csgo_flutter/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mockito/mockito.dart';


class MockDataConnectionChecker extends Mock implements DataConnectionChecker
{}

void main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('is connected', () {
    test(
      'should foward the call to DataConnectionChecker.hasConnection',
      () async {
        networkInfoImpl.isConnected;
        verify(mockDataConnectionChecker.hasConnection);
      }
    );
  });

}

