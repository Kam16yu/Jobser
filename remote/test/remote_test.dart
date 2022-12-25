import 'package:domain/entities/constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote/remote.dart';

void main() {
  test('', () async {

    final client = RestClient(dioInstance: DioClientFactory().getClient());
    final list = await client.getJobs(jobsEndpoint);
    expect(list.isNotEmpty, true);
  });
}
