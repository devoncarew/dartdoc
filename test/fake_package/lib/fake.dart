/// # WOW FAKE PACKAGE IS __BEST__ [PACKAGE][pkg]
///
/// If you don't have this package yet, get it.
/// Don't ask questions.
///
/// My favorite class is [Cool].
///
/// *Why should you get this package?*
///
/// * We told you so.
/// * Everyone is doing it.
/// * It smells nice.
///
/// [pkg]: http://example.org
library fake;

import 'dart:async';

import 'example.dart';

/// Useful for annotations.
class Annotation {
  final String value;
  const Annotation(this.value);
}

class ConstantClass {
  final String value;
  const ConstantClass(this.value);
}

// No dart docs on purpose. Also, a non-primitive const class.
const ConstantClass CUSTOM_CLASS = const ConstantClass('custom');

/// Up is a direction.
///
/// Getting up in the morning can be hard.
const String UP = 'up';

/// Dynamic-typed down.
const DOWN = 'down';

/// A constant integer value,
/// which is a bit redundant.
const int ZERO = 0;

/// Takes input, returns output.
typedef String FakeProcesses(String input);

/// A typedef with a type parameter.
typedef T GenericTypedef<T>(T input);

/// Lots and lots of parameters.
typedef int LotsAndLotsOfParameters(so,many,parameters,it,should,wrap,when,
  converted,to,html,documentation);

/// This class is cool!
class Cool {

}

/// Perfect for mix-ins.
abstract class MixMeIn {

}

/// An interface that can be implemented.
abstract class Interface {

}

/// Yet another interface that can be implemented.
abstract class AnotherInterface {

}

/// A super class, with many powers.
class SuperAwesomeClass {

  /// In the super class.
  List<String> powers;

  /// In the super class.
  void fly() {}

  SuperAwesomeClass operator -(other) { return null; }

}

/// This is a very long line spread
/// across... wait for it... two physical lines.
///
/// The rest of this is not in the first paragraph.
@Annotation('value')
class LongFirstLine extends SuperAwesomeClass with MixMeIn implements Interface, AnotherInterface {

  static const THING = 'yup';
  static const int ANSWER = 42;

  /// An instance string property. Readable and writable.
  String aStringProperty;

  /// A static int property.
  static int meaningOfLife = 42;

  /// The default constructor.
  LongFirstLine();

  /// Named constructors are awesome.
  ///
  /// The map is a key/value pairs of data that helps create an instance.
  LongFirstLine.fromMap(Map data);

  /// No params.
  void noParams() {}

  /// Returns a single string.
  String returnString() => 'cool';

  /// Two params, the first has a type annotation, the second does not.
  int twoParams(String one, two) => 42;

  /// One dynamic param, two named optionals.
  bool optionalParams(first, {second, int third}) => true;

  /// Dynamic getter. Readable only.
  get dynamicGetter => 'could be anything';

  /// Only a setter, with a single param, of type double.
  void set onlySetter(double d) {}

  /// Adds another one of these thingies.
  LongFirstLine operator +(LongFirstLine other) {
    return null;
  }

  /// Multiplies a thingies to this thingie and then returns a new thingie.
  LongFirstLine operator *(LongFirstLine other) {
    return null;
  }

  static int get staticGetter => 11111;

  static void set staticOnlySetter(bool thing) {}

  /// Just a static method with no parameters.
  ///
  /// Returns an int.
  static int staticMethodNoParams() => 42;

  /// A static method that takes a single dynamic thing, and returns void.
  static void staticMethodReturnsVoid(dynamicThing) {}
}

/// My bad!
class Oops implements Exception {
  final String message;
  Oops(this.message);
}

/// Also, my bad.
class Doh extends Error {

}

/// ROYGBIV
enum Color {
  RED, ORANGE, YELLOW, GREEN, BLUE, INDIGO, VIOLET
}

/// Constant property.
const double PI = 3.14159;

/// Final property.
final int meaningOfLife = 42;

/// Simple property
String simpleProperty;

/// Just a setter. No partner getter.
void set justSetter(int value) {}

/// Just a getter. No partner setter.
bool get justGetter => false;

/// The setter for setAndGet.
void set setAndGet(String thing) {}

/// The getter for setAndGet.
String get setAndGet => 'hello';

/// A dynamic getter.
get dynamicGetter => 'i could be anything';

/// Top-level function 3 params and 1 optional positional param.
///
/// This is the second paragraph.
/// It has two lines.
///
/// The third parameter is a [Cool] object.
///
/// Here is a code snippet:
///
///     var thing = topLevelFunction(1, true, 3.4);
///
/// Thanks for using this function!
String topLevelFunction(int param1, bool param2, Cool coolBeans,
                        [double optionalPositional = 0.0]) { return null; }

/// A single optional positional param, no type annotation, no default value.

void onlyPositionalWithNoDefaultNoType([anything]) {}

/// Top-level function with 1 param and 2 optional named params, 1 with a
/// default value.
void soIntense(anything, {bool flag: true, int value}) {  }

/// [A] comes from another library.
void paramFromAnotherLib(Apple thing) {}

/// An async function. It should look like I return a Future.
thisIsAsync() async => 42;

/// Explicitly returns a Future and is marked async.
Future thisIsAlsoAsync() async => 43;