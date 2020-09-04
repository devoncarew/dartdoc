// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library dartdoc.templates;

import 'dart:async' show Future;
import 'dart:io' show File, Directory;
import 'dart:isolate';

import 'package:dartdoc/dartdoc.dart';
import 'package:mustache/mustache.dart';
import 'package:path/path.dart' as path;

import 'html_templates.dart' as html_templates;
import 'markdown_templates.dart' as markdown_templates;

const String _headerPlaceholder = '{{! header placeholder }}';
const String _footerPlaceholder = '{{! footer placeholder }}';
const String _footerTextPlaceholder = '{{! footer-text placeholder }}';

Map<String, String> _loadPartials(
  _TemplatesLoader templatesLoader,
  List<String> headerPaths,
  List<String> footerPaths,
  List<String> footerTextPaths,
) {
  headerPaths ??= [];
  footerPaths ??= [];
  footerTextPaths ??= [];

  var partials = templatesLoader.loadPartials();

  void replacePlaceholder(String key, String placeholder, List<String> paths) {
    var template = partials[key];
    if (template != null && paths != null && paths.isNotEmpty) {
      var replacement = paths.map((p) => File(p).readAsStringSync()).join('\n');
      template = template.replaceAll(placeholder, replacement);
      partials[key] = template;
    }
  }

  replacePlaceholder('head', _headerPlaceholder, headerPaths);
  replacePlaceholder('footer', _footerPlaceholder, footerPaths);
  replacePlaceholder('footer', _footerTextPlaceholder, footerTextPaths);

  return partials;
}

abstract class _TemplatesLoader {
  Map<String, String> loadPartials();

  String loadTemplate(String name);
}

/// Loads default templates included in the Dartdoc program.
class _DefaultTemplatesLoader extends _TemplatesLoader {
  final Map<String, String> _templates;
  final Map<String, String> _partials;

  factory _DefaultTemplatesLoader.create(String format) {
    switch (format) {
      case 'html':
        return _DefaultTemplatesLoader(
            html_templates.templates, html_templates.partials);
      case 'md':
        return _DefaultTemplatesLoader(
            markdown_templates.templates, markdown_templates.partials);
      default:
        throw Exception('unsupported format: $format');
    }
  }

  _DefaultTemplatesLoader(this._templates, this._partials);

  @override
  Map<String, String> loadPartials() {
    return _partials;
  }

  @override
  String loadTemplate(String name) {
    return _templates[name];
  }
}

/// Loads templates from a specified Directory.
class _DirectoryTemplatesLoader extends _TemplatesLoader {
  final Directory _directory;
  final String _format;

  _DirectoryTemplatesLoader(this._directory, this._format);

  @override
  Map<String, String> loadPartials() {
    var partials = <String, String>{};

    for (var file in _directory.listSync().whereType<File>()) {
      var basename = path.basename(file.path);
      if (basename.startsWith('_') && basename.endsWith('.$_format')) {
        var content = file.readAsStringSync();
        var partialName = basename.substring(1, basename.lastIndexOf('.'));
        partials[partialName] = content;
      }
    }

    return partials;
  }

  @override
  String loadTemplate(String name) {
    var file = File(path.join(_directory.path, '$name.$_format'));
    if (!file.existsSync()) {
      throw DartdocFailure('Missing required template file: $name.$_format');
    }
    return file.readAsStringSync();
  }
}

class Templates {
  final Template categoryTemplate;
  final Template classTemplate;
  final Template extensionTemplate;
  final Template enumTemplate;
  final Template constantTemplate;
  final Template constructorTemplate;
  final Template errorTemplate;
  final Template functionTemplate;
  final Template indexTemplate;
  final Template libraryTemplate;
  final Template methodTemplate;
  final Template mixinTemplate;
  final Template propertyTemplate;
  final Template topLevelConstantTemplate;
  final Template topLevelPropertyTemplate;
  final Template typeDefTemplate;

  static Future<Templates> fromContext(
      DartdocGeneratorOptionContext context) async {
    var templatesDir = context.templatesDir;
    var format = context.format;
    var footerTextPaths = context.footerText;
    // todo: remove addSdkFooter
    if (context.addSdkFooter) {
      // todo: in-line these in dart code
      var sdkFooter = await Isolate.resolvePackageUri(
          Uri.parse('package:dartdoc/resources/sdk_footer_text.$format'));
      footerTextPaths.add(path.canonicalize(sdkFooter.toFilePath()));
    }

    if (templatesDir != null) {
      return fromDirectory(
        Directory(templatesDir),
        format,
        headerPaths: context.header,
        footerPaths: context.footer,
        footerTextPaths: footerTextPaths,
      );
    } else {
      return createDefault(
        format,
        headerPaths: context.header,
        footerPaths: context.footer,
        footerTextPaths: footerTextPaths,
      );
    }
  }

  static Templates createDefault(
    String format, {
    List<String> headerPaths,
    List<String> footerPaths,
    List<String> footerTextPaths,
  }) {
    return _create(_DefaultTemplatesLoader.create(format),
        headerPaths: headerPaths,
        footerPaths: footerPaths,
        footerTextPaths: footerTextPaths);
  }

  static Templates fromDirectory(Directory dir, String format,
      {List<String> headerPaths,
      List<String> footerPaths,
      List<String> footerTextPaths}) {
    return _create(_DirectoryTemplatesLoader(dir, format),
        headerPaths: headerPaths,
        footerPaths: footerPaths,
        footerTextPaths: footerTextPaths);
  }

  static Templates _create(
    _TemplatesLoader templatesLoader, {
    List<String> headerPaths,
    List<String> footerPaths,
    List<String> footerTextPaths,
  }) {
    var partials = _loadPartials(
        templatesLoader, headerPaths, footerPaths, footerTextPaths);

    Template _partial(String name) {
      var partial = partials[name];
      if (partial == null || partial.isEmpty) {
        throw StateError('Did not find partial "$name"');
      }
      return Template(partial);
    }

    Template _loadTemplate(String templatePath) {
      var templateContents = templatesLoader.loadTemplate(templatePath);
      return Template(templateContents, partialResolver: _partial);
    }

    var indexTemplate = _loadTemplate('index');
    var libraryTemplate = _loadTemplate('library');
    var categoryTemplate = _loadTemplate('category');
    var classTemplate = _loadTemplate('class');
    var extensionTemplate = _loadTemplate('extension');
    var enumTemplate = _loadTemplate('enum');
    var functionTemplate = _loadTemplate('function');
    var methodTemplate = _loadTemplate('method');
    var constructorTemplate = _loadTemplate('constructor');
    var errorTemplate = _loadTemplate('404error');
    var propertyTemplate = _loadTemplate('property');
    var constantTemplate = _loadTemplate('constant');
    var topLevelConstantTemplate = _loadTemplate('top_level_constant');
    var topLevelPropertyTemplate = _loadTemplate('top_level_property');
    var typeDefTemplate = _loadTemplate('typedef');
    var mixinTemplate = _loadTemplate('mixin');

    return Templates._(
        indexTemplate,
        categoryTemplate,
        libraryTemplate,
        classTemplate,
        extensionTemplate,
        enumTemplate,
        functionTemplate,
        methodTemplate,
        constructorTemplate,
        errorTemplate,
        propertyTemplate,
        constantTemplate,
        topLevelConstantTemplate,
        topLevelPropertyTemplate,
        typeDefTemplate,
        mixinTemplate);
  }

  Templates._(
      this.indexTemplate,
      this.categoryTemplate,
      this.libraryTemplate,
      this.classTemplate,
      this.extensionTemplate,
      this.enumTemplate,
      this.functionTemplate,
      this.methodTemplate,
      this.constructorTemplate,
      this.errorTemplate,
      this.propertyTemplate,
      this.constantTemplate,
      this.topLevelConstantTemplate,
      this.topLevelPropertyTemplate,
      this.typeDefTemplate,
      this.mixinTemplate);
}
