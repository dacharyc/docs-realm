import 'package:test/test.dart';
import '../bin/models/car.dart';
import 'package:realm_dart/realm.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import './utils.dart';

void main() {
  group('Compact a Realm', () {
    test('Compact a Realm with callback', () async {
      // :snippet-start: compact-with-callback
      var config = Configuration.local([Car.schema],
          shouldCompactCallback: ((totalSize, usedSize) {
        // shouldCompactCallback sizes are in bytes.
        // For convenience, this example defines a const
        // representing a byte to MB conversion for compaction
        // at an arbitrary 10MB file size.
        const tenMB = 10 * 1048576;
        return totalSize > tenMB;
      }));
      var realm = Realm(config);
      // :snippet-end:
      realm.close();
      await cleanUpRealm(realm);
    });
    test('Compact a Realm with callback plus logic', () async {
      // :snippet-start: compact-with-callback-and-logic
      var config = Configuration.local([Car.schema],
          shouldCompactCallback: ((totalSize, usedSize) {
        // Compact if the file is over 10MB in size and less than 50% 'used'
        const tenMB = 10 * 1048576;
        return (totalSize > tenMB) &&
            (usedSize.toDouble() / totalSize.toDouble()) < 0.5;
      }));
      var realm = Realm(config);
      // :snippet-end:
      realm.close();
      await cleanUpRealm(realm);
    });
  });
}