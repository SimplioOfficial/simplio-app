import 'package:hive/hive.dart';

abstract class BoxProvider<T> {
  /// `box` holds an instance of a Hive box that stores data types of [T].
  /// Instance of a box is initialized late which means we need to run
  /// `init` method asynchronously to assign this property a value.
  late final Box<T> box;

  /// `_isOpen` is a private property that blocks instance from re-running
  /// `registerAdapters` method and re-running initialization of a box.
  bool _isOpen = false;

  /// `isOpen` is a read-only property that provides with a state of a inherited
  /// private property `_isOpen` in all subclasses.
  bool get isOpen => _isOpen;

  /// `boxName` is a identifier of a box which Hive manages. This property
  /// must be a unique value inside a Hive instance.
  String get boxName;

  /// `init` is an implementation of a late initialization of all late
  /// properties. This method handles duplicated late property initialization,
  /// opening a Hive box,and registering all defined hive object adapters
  /// provided in all subclasses.
  Future<BoxProvider<T>> init() async {
    /// Blocking execution context if a box is already opened and all adapters
    /// are registered.
    if (_isOpen) return this;

    /// Registering adapters provided in all subclasses.
    try {
      registerAdapters();
    } catch (e) {
      throw Exception("Initialization of $toString() has failed.");
    }

    /// Late initialization od a Hive box.
    box = await Hive.openBox<T>(boxName);

    /// Changing a value of a `_isOpen` property.
    _open();

    return this;
  }

  _open() {
    _isOpen = true;
  }

  /// A method definition that registers all Hive adapters that are used
  /// inside defined box.
  void registerAdapters();

  @override
  String toString() {
    return "BoxProvider of $T";
  }
}
