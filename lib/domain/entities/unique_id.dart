import 'package:uuid/uuid.dart';

class UniqueId {
  const UniqueId._(this.value);

  final String value;

  factory UniqueId() {
    return UniqueId._(const Uuid().v4());
  }

  factory UniqueId.fromUniqueString(String uniqueString) {
    return UniqueId._(uniqueString);
  }
}

class CollectionId extends UniqueId {
  // ignore: use_super_parameters
  const CollectionId._(String value) : super._(value);

  factory CollectionId() {
    return CollectionId._(const Uuid().v4());
  }

  factory CollectionId.fromUniqueString(String uniqueString) {
    return CollectionId._(uniqueString);
  }
}

class EntryId extends UniqueId {
  // ignore: use_super_parameters
  const EntryId._(String value) : super._(value);

  factory EntryId() {
    return EntryId._(const Uuid().v4());
  }

  factory EntryId.fromUniqueString(String uniqueString) {
    return EntryId._(uniqueString);
  }
}
