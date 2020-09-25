import 'dart:io';

RegExp templateRegEx = RegExp(r'^\s*{{>([_a-zA-Z0-9]+)}}$');
// todo: move this logic out of a regex
// todo: publicInheritedInstanceMethods, publicInheritedInstanceFields,
//   publicInheritedInstanceOperators
RegExp boolCheckRegEx = RegExp(
    r'^\s*{{#((is|has|use|library\.has|self\.has|container\.is|packageGraph\.has|include)[_a-zA-Z0-9]+)}}$');
RegExp negBoolCheckRegEx = RegExp(r'^\s*{{\^((is|has)[_a-zA-Z0-9]+)}}$');
RegExp identifierRegEx = RegExp(r'^\s*{{#([_a-zA-Z0-9\.]+)}}$');
RegExp endBlockRegEx = RegExp(r'^\s*{{/([_a-zA-Z0-9\.]+)}}$');

RegExp inlineUnescapedRegEx = RegExp(r'{{{\s*([_a-zA-Z0-9\.]+)\s*}}}');
RegExp inlineEscapedRegEx = RegExp(r'{{\s*([_a-zA-Z0-9\.]+)\s*}}');
RegExp inlineTemplateRegEx = RegExp(r'{{>([_a-zA-Z0-9\.]+)}}');

// todo: switch to breaking things into lines, then into {{ }} tokens

// todo: support comments {{! foo }} - remove them
// except for {{! foo placeholder }} ones

void main(List<String> args) {
  var dir = Directory(args.first);
  var out = File('${dir.path}/html_generator.dart');
  if (out.existsSync()) {
    out.deleteSync();
  }

  out.writeAsStringSync(_header, mode: FileMode.append);

  var buf = StringBuffer();

  buf.writeln();
  buf.writeln('class HtmlGenerator extends Generator {');

  var files = dir
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.html'))
      .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  var first = true;
  for (var file in files) {
    var name = file.path.split('/').last;
    if (!name.startsWith('_')) {
      if (!first) {
        buf.writeln();
      }
      first = false;
      generateFor(file, buf);
    }
  }

  for (var file in files) {
    var name = file.path.split('/').last;
    if (name.startsWith('_')) {
      name = name.substring(1).split('.').first;
      buf.writeln();
      generateInline(file, name, buf);
      buf.writeln();
      generateFor(file, buf);
    }
  }

  buf.writeln('}');

  out.writeAsStringSync(buf.toString(), mode: FileMode.append);
  print('write ${out.path}');
}

void generateFor(File file, StringBuffer out) {
  var fileName = file.path.split('/').last;
  var typeName = fileName.split('.').first;

  var isInclude = false;
  if (typeName.startsWith('_')) {
    isInclude = true;
    typeName = typeName.substring(1);
  }

  var camelName = toCamelCase(typeName);
  var paramType = fileNameToParamType[fileName];

  if (isInclude) {
    out.writeln('  void _include$camelName($paramType ref) {');
  } else {
    out.writeln('  void generate$camelName($paramType ref) {');
  }

  var stack = <String>[];
  var refs = <String>['ref'];

  void push(String token, [String newRef]) {
    stack.add(token);
    refs.add(newRef);
  }

  bool pop(String token) {
    if (stack.isEmpty) return false;

    if (stack.last == token) {
      stack.removeLast();
      refs.removeLast();
      return true;
    } else {
      return false;
    }
  }

  for (var line in file.readAsLinesSync()) {
    var indent = '  ' * (stack.length + 1);

    var refText = refs.lastWhere((element) => element != null);

    if (templateRegEx.hasMatch(line)) {
      var templateName = templateRegEx.firstMatch(line).group(1);
      out.writeln('$indent  _include${toCamelCase(templateName)}($refText);');
    } else if (boolCheckRegEx.hasMatch(line)) {
      var checkName = boolCheckRegEx.firstMatch(line).group(1);
      out.writeln('$indent  if ($refText.$checkName) {');
      push(checkName);
    } else if (negBoolCheckRegEx.hasMatch(line)) {
      var checkName = negBoolCheckRegEx.firstMatch(line).group(1);
      out.writeln('$indent  if (!$refText.$checkName) {');
      push(checkName);
    } else if (identifierRegEx.hasMatch(line)) {
      var name = identifierRegEx.firstMatch(line).group(1);
      if (!name.endsWith('Class') &&
          (name.endsWith('s') ||
              name.endsWith('sSorted') ||
              name.endsWith('Reversed'))) {
        // Handle plurals.
        out.writeln('$indent  for (var item in $refText.$name) {');
        push(name, 'item');
      } else {
        out.writeln('$indent  {');
        if (name.contains('.')) {
          out.writeln('$indent    // $refText.$name');
          push(name, '$refText.$name');
        } else {
          out.writeln('$indent    var $name = $refText.$name;');
          push(name, name);
        }
      }
    } else if (endBlockRegEx.hasMatch(line)) {
      var name = endBlockRegEx.firstMatch(line).group(1);
      if (pop(name)) {
        out.writeln('$indent}');
      } else {
        // todo:
        out.writeln("$indent  write('${line.replaceAll('\'', '\\\'')}');");
      }
    } else {
      line = line.replaceAll('\'', '\\\'');

      // inlineUnescapedRegEx
      line = line.replaceAllMapped(inlineUnescapedRegEx, (Match match) {
        var id = match.group(1);
        if (id == '.') {
          // todo: is this right? What does {{{.}}} mean?
          return '\$$refText';
        } else {
          return '\${$refText.$id}';
        }
      });

      // inlineEscapedRegEx
      line = line.replaceAllMapped(inlineEscapedRegEx, (Match match) {
        var id = match.group(1);
        return '\${escape($refText.$id)}';
      });

      // inlineTemplateRegEx
      line = line.replaceAllMapped(inlineTemplateRegEx, (Match match) {
        var id = match.group(1);
        var camel = toCamelCase(id);
        return '\${_inline$camel($refText)}';
      });

      out.writeln("$indent  write('${line}');");
    }
  }

  out.writeln('  }');
}

void generateInline(File file, String name, StringBuffer out) {
  var fileName = file.path.split('/').last;
  var camelName = toCamelCase(name);
  var paramType = fileNameToParamType[fileName];

  out.writeln('  String _inline$camelName($paramType ref) {');
  out.writeln('    pushBuffer();');
  out.writeln('    _include$camelName(ref);');
  out.writeln('    return popBuffer();');
  out.writeln('  }');
}

String toCamelCase(String name) {
  return name.split('_').map((segment) {
    return segment.substring(0, 1).toUpperCase() + segment.substring(1);
  }).join('');
}

final String _header = r'''
import 'dart:convert';

import 'package:dartdoc/src/generator/template_data.dart';
import 'package:dartdoc/src/model/model.dart';

abstract class Generator {
  static const HtmlEscape _htmlEscape = HtmlEscape();

  StringBuffer _out;
  List<StringBuffer> stack = [];
  
  void start() {
    _out = StringBuffer();
  }

  String finish() {
    return _out.toString();
  }

  void write(String text) {
    _out.write(text);
  }

  String escape(String value) {
    return _htmlEscape.convert(value);
  }

  void comment(String text) {
    write('<!-- $text -->\n');
  }
  
  void pushBuffer() {
    stack.add(_out);
    _out = StringBuffer();
  }
  
  String popBuffer() {
    var ret = finish();
    _out = stack.removeLast();
    return ret;
  }
}
''';

final Map<String, String> fileNameToParamType = {
  '404error.html': 'PackageTemplateData',
  'category.html': 'CategoryTemplateData',
  'class.html': 'ClassTemplateData',
  'constant.html': 'PropertyTemplateData',
  'constructor.html': 'ConstructorTemplateData',
  'enum.html': 'EnumTemplateData',
  'extension.html': 'ExtensionTemplateData',
  'function.html': 'FunctionTemplateData',
  'index.html': 'TemplateData',
  'library.html': 'LibraryTemplateData',
  'method.html': 'MethodTemplateData',
  'mixin.html': 'MixinTemplateData',
  'property.html': 'PropertyTemplateData',
  'top_level_constant.html': 'TopLevelPropertyTemplateData',
  'top_level_property.html': 'TopLevelPropertyTemplateData',
  'typedef.html': 'TypedefTemplateData',
  '_accessor_getter.html': 'GetterSetterCombo',
  '_accessor_setter.html': 'GetterSetterCombo',
  '_callable.html': 'ModelElement',
  '_callable_multiline.html': 'ModelElement',
  '_categorization.html': 'Categorization',
  '_class.html': 'ModelElement',
  '_constant.html': 'GetterSetterCombo',
  '_documentation.html': 'Documentable',
  '_extension.html': 'ModelElement',
  '_feature_set.html': 'ModelElement',
  '_features.html': 'ModelElement',
  '_footer.html': 'TemplateData',
  '_head.html': 'TemplateData',
  '_library.html': 'ModelElement',
  '_mixin.html': 'ModelElement',
  '_name_summary.html': 'ModelElement',
  '_packages.html': 'TemplateData',
  '_property.html': 'GetterSetterCombo',
  '_search_sidebar.html': 'TemplateData',
  '_sidebar_for_category.html': 'CategoryTemplateData',
  '_sidebar_for_class.html': 'ClassTemplateData',
  '_sidebar_for_container.html': 'MemberTemplateData',
  '_sidebar_for_enum.html': 'EnumTemplateData',
  '_sidebar_for_extension.html': 'ExtensionTemplateData',
  '_sidebar_for_library.html': 'TemplateData',
  '_source_code.html': 'ModelElement',
  '_source_link.html': 'ModelElement',
};
