import 'package:test/test.dart';
import 'package:zemoga_posts/core/services/api/api_provider.dart';
import 'package:zemoga_posts/core/services/api/custom_exceptions.dart';

void main() {
  group('Test api provider', () {
    String responseMock = 'Response mock';

    test('Assert Api provider should return an assertion error', () {
      expect(
          () => ApiProvider(httpClient: null), throwsA(isA<AssertionError>()));
    });

    test('Test FetchDataException response', () {
      expect(() => throw new FetchDataException(responseMock),
          throwsA(isA<FetchDataException>()));

      expect(
          () => throw new FetchDataException(responseMock),
          throwsA(predicate(
              (e) => e is FetchDataException && e.message == responseMock)));
    });

    test('Test BadRequestException response', () {
      expect(() => throw new BadRequestException(responseMock),
          throwsA(isA<BadRequestException>()));

      expect(
          () => throw new BadRequestException(responseMock),
          throwsA(predicate(
              (e) => e is BadRequestException && e.message == responseMock)));
    });

    test('Test UnauthorisedException response', () {
      expect(() => throw new UnauthorisedException(responseMock),
          throwsA(isA<UnauthorisedException>()));

      expect(
          () => throw new UnauthorisedException(responseMock),
          throwsA(predicate(
              (e) => e is UnauthorisedException && e.message == responseMock)));
    });

    test('Test InvalidInputException response', () {
      expect(() => throw new InvalidInputException(responseMock),
          throwsA(isA<InvalidInputException>()));

      expect(
          () => throw new InvalidInputException(responseMock),
          throwsA(predicate(
              (e) => e is InvalidInputException && e.message == responseMock)));
    });

    test('Test NotFoundException response', () {
      expect(() => throw new NotFoundException(responseMock),
          throwsA(isA<NotFoundException>()));

      expect(
          () => throw new NotFoundException(responseMock),
          throwsA(predicate(
              (e) => e is NotFoundException && e.message == responseMock)));
    });
  });
}
