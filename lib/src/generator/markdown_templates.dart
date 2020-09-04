// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

final Map<String, String> templates = {
  '404error': _404error,
  'category': _category,
  'class': _class,
  'constant': _constant,
  'constructor': _constructor,
  'enum': _enum,
  'extension': _extension,
  'function': _function,
  'index': _index,
  'library': _library,
  'method': _method,
  'mixin': _mixin,
  'property': _property,
  'top_level_constant': _top_level_constant,
  'top_level_property': _top_level_property,
  'typedef': _typedef,
};

final Map<String, String> partials = {
  'accessor_getter': __accessor_getter,
  'accessor_setter': __accessor_setter,
  'callable': __callable,
  'callable_multiline': __callable_multiline,
  'categorization': __categorization,
  'class': __class,
  'constant': __constant,
  'documentation': __documentation,
  'extension': __extension,
  'feature_set': __feature_set,
  'features': __features,
  'footer': __footer,
  'head': __head,
  'library': __library,
  'mixin': __mixin,
  'name_summary': __name_summary,
  'property': __property,
  'source_code': __source_code,
  'source_link': __source_link,
};

final String _404error = '''
# 404

Oops, something's gone wrong :-(

You've tried to visit a page that doesn't exist. Luckily this site has other
[pages](index.md).
''';

final String _category = '''
{{>head}}

{{#self}}
# {{name}} {{kind}}

{{>documentation}}

{{#hasPublicLibraries}}
## Libraries

{{#publicLibraries}}
{{>library}}

{{/publicLibraries}}
{{/hasPublicLibraries}}

{{#hasPublicClasses}}
## Classes

{{#publicClasses}}
{{>class}}

{{/publicClasses}}
{{/hasPublicClasses}}

{{#hasPublicMixins}}
## Mixins

{{#publicMixins}}
{{>mixin}}

{{/publicMixins}}
{{/hasPublicMixins}}

{{#hasPublicConstants}}
## Constants

{{#publicConstants}}
{{>constant}}

{{/publicConstants}}
{{/hasPublicConstants}}

{{#hasPublicProperties}}
## Properties

{{#publicProperties}}
{{>property}}

{{/publicProperties}}
{{/hasPublicProperties}}

{{#hasPublicFunctions}}
## Functions

{{#publicFunctions}}
{{>callable}}

{{/publicFunctions}}
{{/hasPublicFunctions}}

{{#hasPublicEnums}}
## Enums

{{#publicEnums}}
{{>class}}

{{/publicEnums}}
{{/hasPublicEnums}}

{{#hasPublicTypedefs}}
## Typedefs

{{#publicTypedefs}}
{{>callable}}

{{/publicTypedefs}}
{{/hasPublicTypedefs}}

{{#hasPublicExceptions}}
## Exceptions / Errors

{{#publicExceptions}}
{{>class}}

{{/publicExceptions}}
{{/hasPublicExceptions}}
{{/self}}

{{>footer}}
''';

final String _class = '''
{{>head}}

{{#self}}
# {{{nameWithGenerics}}} {{kind}}

{{>source_link}}
{{>categorization}}
{{>feature_set}}
{{/self}}

{{#clazz}}
{{>documentation}}

{{#hasModifiers}}
{{#hasPublicSuperChainReversed}}
**Inheritance**

- {{{linkedObjectType}}}
{{#publicSuperChainReversed}}
- {{{linkedName}}}
{{/publicSuperChainReversed}}
- {{{name}}}
{{/hasPublicSuperChainReversed}}

{{#hasPublicInterfaces}}
**Implemented types**

{{#publicInterfaces}}
- {{{linkedName}}}
{{/publicInterfaces}}
{{/hasPublicInterfaces}}

{{#hasPublicMixins}}
**Mixed in types**

{{#publicMixins}}
- {{{linkedName}}}
{{/publicMixins}}
{{/hasPublicMixins}}

{{#hasPublicImplementors}}
**Implementers**

{{#publicImplementors}}
- {{{linkedName}}}
{{/publicImplementors}}
{{/hasPublicImplementors}}

{{#hasPotentiallyApplicableExtensions}}
**Available Extensions**

{{#potentiallyApplicableExtensions}}
- {{{linkedName}}}
{{/potentiallyApplicableExtensions}}
{{/hasPotentiallyApplicableExtensions}}

{{#hasAnnotations}}
**Annotations**

{{#annotations}}
- {{{.}}}
{{/annotations}}
{{/hasAnnotations}}
{{/hasModifiers}}

{{#hasPublicConstructors}}
## Constructors

{{#publicConstructorsSorted}}
{{{linkedName}}} ({{{ linkedParams }}})

{{{ oneLineDoc }}} {{{ extendedDocLink }}}  {{!two spaces intentional}}
{{#isConst}}_const_{{/isConst}} {{#isFactory}}_factory_{{/isFactory}}

{{/publicConstructorsSorted}}
{{/hasPublicConstructors}}

{{#hasPublicInstanceFields}}
## Properties

{{#publicInstanceFieldsSorted}}
{{>property}}

{{/publicInstanceFieldsSorted}}
{{/hasPublicInstanceFields}}

{{#hasPublicInstanceMethods}}
## Methods

{{#publicInstanceMethodsSorted}}
{{>callable}}

{{/publicInstanceMethodsSorted}}
{{/hasPublicInstanceMethods}}

{{#hasPublicInstanceOperators}}
## Operators

{{#publicInstanceOperatorsSorted}}
{{>callable}}

{{/publicInstanceOperatorsSorted}}
{{/hasPublicInstanceOperators}}

{{#hasPublicVariableStaticFields}}
## Static Properties

{{#publicVariableStaticFieldsSorted}}
{{>property}}

{{/publicVariableStaticFieldsSorted}}
{{/hasPublicVariableStaticFields}}

{{#hasPublicStaticMethods}}
## Static Methods

{{#publicStaticMethodsSorted}}
{{>callable}}

{{/publicStaticMethodsSorted}}
{{/hasPublicStaticMethods}}

{{#hasPublicConstantFields}}
## Constants

{{#publicConstantFieldsSorted}}
{{>constant}}

{{/publicConstantFieldsSorted}}
{{/hasPublicConstantFields}}
{{/clazz}}

{{>footer}}
''';

final String _constant = '''
{{>head}}

{{#self}}
# {{{name}}} {{kind}}

{{>source_link}}
{{>feature_set}}
{{/self}}

{{#property}}
{{{ linkedReturnType }}} {{>name_summary}} = {{{ constantValue }}}

{{>documentation}}

{{>source_code}}
{{/property}}

{{>footer}}
''';

final String _constructor = '''
{{>head}}

{{#self}}
# {{{nameWithGenerics}}} {{kind}}

{{>source_link}}
{{>feature_set}}
{{/self}}

{{#constructor}}
{{#hasAnnotations}}
{{#annotations}}
- {{{.}}}
{{/annotations}}
{{/hasAnnotations}}

{{#isConst}}const{{/isConst}}
{{{nameWithGenerics}}}({{#hasParameters}}{{{linkedParamsLines}}}{{/hasParameters}})

{{>documentation}}

{{>source_code}}

{{/constructor}}

{{>footer}}
''';

final String _enum = '''
{{>head}}

{{#self}}
# {{{name}}} {{kind}}

{{>source_link}}
{{>feature_set}}
{{/self}}

{{#eNum}}
{{>documentation}}

{{#hasModifiers}}
{{#hasPublicSuperChainReversed}}
**Inheritance**

- {{{linkedObjectType}}}
{{#publicSuperChainReversed}}
- {{{linkedName}}}
{{/publicSuperChainReversed}}
- {{{name}}}
{{/hasPublicSuperChainReversed}}

{{#hasPublicInterfaces}}
**Implemented types**

{{#publicInterfaces}}
- {{{linkedName}}}
{{/publicInterfaces}}
{{/hasPublicInterfaces}}

{{#hasPublicMixins}}
**Mixed in types**

{{#publicMixins}}
- {{{linkedName}}}
{{/publicMixins}}
{{/hasPublicMixins}}

{{#hasPublicImplementors}}
**Implementers**

{{#publicImplementors}}
- {{{linkedName}}}
{{/publicImplementors}}
{{/hasPublicImplementors}}

{{#hasAnnotations}}
**Annotations**

{{#annotations}}
- {{{.}}}
{{/annotations}}
{{/hasAnnotations}}
{{/hasModifiers}}

{{#hasPublicConstantFields}}
## Constants

{{#publicConstantFieldsSorted}}
{{>constant}}

{{/publicConstantFieldsSorted}}
{{/hasPublicConstantFields}}

{{#hasPublicConstructors}}
## Constructors

{{#publicConstructorsSorted}}
{{{linkedName}}}({{{ linkedParams }}})

{{{ oneLineDoc }}} {{{ extendedDocLink }}}  {{!two spaces intentional}}
{{#isConst}}_const_{{/isConst}} {{#isFactory}}_factory_{{/isFactory}}

{{/publicConstructorsSorted}}
{{/hasPublicConstructors}}

{{#hasPublicInstanceFields}}
## Properties

{{#publicInstanceFieldsSorted}}
{{>property}}

{{/publicInstanceFieldsSorted}}
{{/hasPublicInstanceFields}}

{{#hasPublicInstanceMethods}}
## Methods

{{#publicInstanceMethodsSorted}}
{{>callable}}

{{/publicInstanceMethodsSorted}}
{{/hasPublicInstanceMethods}}

{{#hasPublicInstanceOperators}}
## Operators

{{#publicInstanceOperatorsSorted}}
{{>callable}}

{{/publicInstanceOperatorsSorted}}
{{/hasPublicInstanceOperators}}

{{#hasPublicVariableStaticFields}}
## Static Properties

{{#publicVariableStaticFieldsSorted}}
{{>property}}

{{/publicVariableStaticFieldsSorted}}
{{/hasPublicVariableStaticFields}}

{{#hasPublicStaticMethods}}
## Static Methods

{{#publicStaticMethodsSorted}}
{{>callable}}

{{/publicStaticMethodsSorted}}
{{/hasPublicStaticMethods}}
{{/eNum}}

{{>footer}}
''';

final String _extension = '''
{{>head}}

{{#self}}
# {{{nameWithGenerics}}} {{kind}}
on {{#extendedType}}{{{linkedName}}}{{/extendedType}}

{{>source_link}}

{{>categorization}}
{{>feature_set}}
{{/self}}

{{#extension}}
{{>documentation}}

{{#hasPublicInstanceFields}}
## Properties

{{#publicInstanceFieldsSorted}}
{{>property}}

{{/publicInstanceFieldsSorted}}
{{/hasPublicInstanceFields}}

{{#hasPublicInstanceMethods}}
## Methods

{{#publicInstanceMethodsSorted}}
{{>callable}}

{{/publicInstanceMethodsSorted}}
{{/hasPublicInstanceMethods}}

{{#hasPublicInstanceOperators}}
## Operators

{{#publicInstanceOperatorsSorted}}
{{>callable}}

{{/publicInstanceOperatorsSorted}}
{{/hasPublicInstanceOperators}}

{{#hasPublicVariableStaticFields}}
## Static Properties

{{#publicVariableStaticFieldsSorted}}
{{>property}}

{{/publicVariableStaticFieldsSorted}}
{{/hasPublicVariableStaticFields}}

{{#hasPublicStaticMethods}}
## Static Methods

{{#publicStaticMethodsSorted}}
{{>callable}}

{{/publicStaticMethodsSorted}}
{{/hasPublicStaticMethods}}

{{#hasPublicConstantFields}}
## Constants

{{#publicConstantFieldsSorted}}
{{>constant}}

{{/publicConstantFieldsSorted}}
{{/hasPublicConstantFields}}
{{/extension}}

{{>footer}}
''';

final String _function = '''
{{>head}}

{{#self}}
# {{{nameWithGenerics}}} {{kind}}

{{>source_link}}
{{>categorization}}
{{>feature_set}}
{{/self}}

{{#function}}
{{>callable_multiline}}

{{>documentation}}

{{>source_code}}

{{/function}}

{{>footer}}
''';

final String _index = '''
{{>head}}

# {{ title }}

{{#packageGraph.defaultPackage}}
{{>documentation}}
{{/packageGraph.defaultPackage}}

{{#packageGraph}}
{{#localPackages}}
{{#isFirstPackage}}
## Libraries
{{/isFirstPackage}}
{{^isFirstPackage}}
## {{name}}
{{/isFirstPackage}}

{{#defaultCategory.publicLibraries}}
{{>library}}
{{/defaultCategory.publicLibraries}}

{{#categoriesWithPublicLibraries}}
### Category {{{categoryLabel}}}

{{#publicLibraries}}
{{>library}}
{{/publicLibraries}}
{{/categoriesWithPublicLibraries}}
{{/localPackages}}
{{/packageGraph}}

{{>footer}}
''';

final String _library = '''
{{>head}}

{{#self}}
# {{{ name }}} {{ kind }}

{{>source_link}}
{{>categorization}}
{{>feature_set}}
{{/self}}

{{#library}}
{{>documentation}}
{{/library}}

{{#library.hasPublicClasses}}
## Classes

{{#library.publicClasses}}
{{>class}}

{{/library.publicClasses}}
{{/library.hasPublicClasses}}

{{#library.hasPublicMixins}}
## Mixins

{{#library.publicMixins}}
{{>mixin}}

{{/library.publicMixins}}
{{/library.hasPublicMixins}}

{{#library.hasPublicExtensions}}
## Extensions

{{#library.publicExtensions}}
{{>extension}}

{{/library.publicExtensions}}
{{/library.hasPublicExtensions}}

{{#library.hasPublicConstants}}
## Constants

{{#library.publicConstants}}
{{>constant}}

{{/library.publicConstants}}
{{/library.hasPublicConstants}}

{{#library.hasPublicProperties}}
## Properties

{{#library.publicProperties}}
{{>property}}

{{/library.publicProperties}}
{{/library.hasPublicProperties}}

{{#library.hasPublicFunctions}}
## Functions

{{#library.publicFunctions}}
{{>callable}}

{{/library.publicFunctions}}
{{/library.hasPublicFunctions}}

{{#library.hasPublicEnums}}
## Enums

{{#library.publicEnums}}
{{>class}}

{{/library.publicEnums}}
{{/library.hasPublicEnums}}

{{#library.hasPublicTypedefs}}
## Typedefs

{{#library.publicTypedefs}}
{{>callable}}

{{/library.publicTypedefs}}
{{/library.hasPublicTypedefs}}

{{#library.hasPublicExceptions}}
## Exceptions / Errors

{{#library.publicExceptions}}
{{>class}}

{{/library.publicExceptions}}
{{/library.hasPublicExceptions}}

{{>footer}}
''';

final String _method = '''
{{>head}}

{{#self}}
# {{{nameWithGenerics}}} {{kind}}

{{>source_link}}
{{>feature_set}}
{{/self}}

{{#method}}
{{>callable_multiline}}
{{>features}}

{{>documentation}}

{{>source_code}}

{{/method}}

{{>footer}}
''';

final String _mixin = '''
{{>head}}

{{#self}}
# {{{nameWithGenerics}}} {{kind}}

{{>source_link}}
{{>categorization}}
{{>feature_set}}
{{/self}}

{{#mixin}}
{{>documentation}}

{{#hasModifiers}}
{{#hasPublicSuperclassConstraints}}
**Superclass Constraints**

{{#publicSuperclassConstraints}}
- {{{linkedName}}}
{{/publicSuperclassConstraints}}
{{/hasPublicSuperclassConstraints}}

{{#hasPublicSuperChainReversed}}
**Inheritance**

- {{{linkedObjectType}}}
{{#publicSuperChainReversed}}
- {{{linkedName}}}
{{/publicSuperChainReversed}}
- {{{name}}}
{{/hasPublicSuperChainReversed}}

{{#hasPublicInterfaces}}
**Implemented types**

{{#publicInterfaces}}
- {{{linkedName}}}
{{/publicInterfaces}}
{{/hasPublicInterfaces}}

{{#hasPublicMixins}}
**Mixed in types**

{{#publicMixins}}
- {{{linkedName}}}
{{/publicMixins}}
{{/hasPublicMixins}}

{{#hasPublicImplementors}}
**Implementers**

{{#publicImplementors}}
- {{{linkedName}}}
{{/publicImplementors}}
{{/hasPublicImplementors}}

{{#hasAnnotations}}
**Annotations**

{{#annotations}}
- {{{.}}}
{{/annotations}}
{{/hasAnnotations}}
{{/hasModifiers}}

{{#hasPublicConstructors}}
## Constructors

{{#publicConstructorsSorted}}
{{{linkedName}}}({{{ linkedParams }}})

{{{ oneLineDoc }}} {{{ extendedDocLink }}}  {{!two spaces intentional}}
{{#isConst}}_const_{{/isConst}} {{#isFactory}}_factory_{{/isFactory}}

{{/publicConstructorsSorted}}
{{/hasPublicConstructors}}

{{#hasPublicInstanceFields}}
## Properties

{{#publicInstanceFieldsSorted}}
{{>property}}

{{/publicInstanceFieldsSorted}}
{{/hasPublicInstanceFields}}

{{#hasPublicInstanceMethods}}
## Methods

{{#publicInstanceMethodsSorted}}
{{>callable}}

{{/publicInstanceMethodsSorted}}
{{/hasPublicInstanceMethods}}

{{#hasPublicInstanceOperators}}
## Operators

{{#publicInstanceOperatorsSorted}}
{{>callable}}

{{/publicInstanceOperatorsSorted}}
{{/hasPublicInstanceOperators}}

{{#hasPublicVariableStaticFields}}
## Static Properties

{{#publicVariableStaticFieldsSorted}}
{{>property}}

{{/publicVariableStaticFieldsSorted}}
{{/hasPublicVariableStaticFields}}

{{#hasPublicStaticMethods}}
## Static Methods

{{#publicStaticMethodsSorted}}
{{>callable}}

{{/publicStaticMethodsSorted}}
{{/hasPublicStaticMethods}}

{{#hasPublicConstantFields}}
## Constants

{{#publicConstantFieldsSorted}}
{{>constant}}

{{/publicConstantFieldsSorted}}
{{/hasPublicConstantFields}}
{{/mixin}}

{{>footer}}
''';

final String _property = '''
{{>head}}

{{#self}}
# {{name}} {{kind}}

{{>source_link}}
{{>feature_set}}
{{/self}}

{{#self}}
{{#hasNoGetterSetter}}
{{{ linkedReturnType }}} {{>name_summary}}  {{!two spaces intentional}}
{{>features}}

{{>documentation}}

{{>source_code}}
{{/hasNoGetterSetter}}

{{#hasGetterOrSetter}}
{{#hasGetter}}
{{>accessor_getter}}
{{/hasGetter}}

{{#hasSetter}}
{{>accessor_setter}}
{{/hasSetter}}
{{/hasGetterOrSetter}}
{{/self}}

{{>footer}}
''';

final String _top_level_constant = '''
{{>head}}

{{#self}}
# {{{name}}} {{kind}}

{{>source_link}}
{{>categorization}}
{{>feature_set}}

{{>name_summary}} = {{{ constantValue }}}  {{!two spaces intentional}}
{{>features}}

{{>documentation}}

{{>source_code}}
{{/self}}

{{>footer}}
''';

final String _top_level_property = '''
{{>head}}

{{#self}}
# {{{name}}} {{kind}}

{{>source_link}}
{{>categorization}}
{{>feature_set}}

{{#hasNoGetterSetter}}
{{{ linkedReturnType }}} {{>name_summary}}  {{!two spaces intentional}}
{{>features}}

{{>documentation}}

{{>source_code}}
{{/hasNoGetterSetter}}

{{#hasExplicitGetter}}
{{>accessor_getter}}
{{/hasExplicitGetter}}

{{#hasExplicitSetter}}
{{>accessor_setter}}
{{/hasExplicitSetter}}
{{/self}}

{{>footer}}
''';

final String _typedef = '''
{{>head}}

{{#self}}
# {{{nameWithGenerics}}} {{kind}}

{{>source_link}}
{{>categorization}}
{{>feature_set}}
{{/self}}

{{#typeDef}}
{{>callable_multiline}}

{{>documentation}}

{{>source_code}}
{{/typeDef}}

{{>footer}}
''';

final String __accessor_getter = '''
{{#getter}}
{{{ linkedReturnType }}} {{>name_summary}}  {{!two spaces intentional}}
{{>features}}

{{>documentation}}

{{>source_code}}
{{/getter}}
''';

final String __accessor_setter = '''
{{#setter}}
{{>name_summary}}({{{ linkedParamsNoMetadata }}})  {{!two spaces intentional}}
{{>features}}

{{>documentation}}

{{>source_code}}
{{/setter}}
''';

final String __callable = '''
##### {{{linkedName}}}{{{linkedGenericParameters}}}({{{ linkedParamsNoMetadata }}}) {{{ linkedReturnType }}}
{{>categorization}}

{{{ oneLineDoc }}} {{{ extendedDocLink }}}  {{!two spaces intentional}}
{{>features}}
''';

final String __callable_multiline = '''
{{#hasAnnotations}}
{{#annotations}}
- {{{.}}}
{{/annotations}}
{{/hasAnnotations}}

{{{ linkedReturnType }}} {{>name_summary}}{{{genericParameters}}}({{#hasParameters}}{{{linkedParamsLines}}}{{/hasParameters}})
''';

final String __categorization = '''
{{#hasDisplayedCategories}}
Categories:
{{#displayedCategories}}
{{{categoryLabel}}}
{{/displayedCategories}}
{{/hasDisplayedCategories}}
''';

final String __class = '''
##### {{{linkedName}}}{{{linkedGenericParameters}}}
{{>categorization}}

{{{ oneLineDoc }}} {{{ extendedDocLink }}}
''';

final String __constant = '''
##### {{{ linkedName }}} const {{{ linkedReturnType }}}
{{>categorization}}

{{{ oneLineDoc }}} {{{ extendedDocLink }}}  {{!two spaces intentional}}
{{>features}}
''';

final String __documentation = '''
{{#hasDocumentation}}
{{{ documentationAsHtml }}}
{{/hasDocumentation}}
''';

final String __extension = '''
##### {{{linkedName}}}
{{>categorization}}

{{{ oneLineDoc }}} {{{ extendedDocLink }}}
''';

final String __feature_set = '''
{{#hasFeatureSet}}
  {{#displayedLanguageFeatures}}
    {{{featureLabel}}}
  {{/displayedLanguageFeatures}}
{{/hasFeatureSet}}
''';

final String __features = '''
{{ #featuresAsString.isNotEmpty }}_{{{featuresAsString}}}_{{ /featuresAsString.isNotEmpty }}
''';

final String __footer = '''
{{! markdown has no dedicated footer element, so both placeholders are siblings }}
{{! footer-text placeholder }}
{{! footer placeholder }}
''';

final String __head = '''
{{! header placeholder }}
''';

final String __library = '''
##### {{{ linkedName }}}
{{#isDocumented}}
{{{ oneLineDoc }}} {{{ extendedDocLink }}}

{{/isDocumented}}
''';

final String __mixin = '''
##### {{{linkedName}}}{{{linkedGenericParameters}}}
{{>categorization}}

{{{ oneLineDoc }}} {{{ extendedDocLink }}}
''';

final String __name_summary = '''
{{#isConst}}const {{/isConst}}{{#isDeprecated}}~~{{/isDeprecated}}{{name}}{{#isDeprecated}}~~{{/isDeprecated}}
''';

final String __property = '''
##### {{{linkedName}}} {{{ arrow }}} {{{ linkedReturnType }}}
{{>categorization}}

{{{ oneLineDoc }}} {{{ extendedDocLink }}}  {{!two spaces intentional}}
{{>features}}
''';

final String __source_code = '''
{{#hasSourceCode}}
## Implementation

```dart
{{{ sourceCode }}}
```
{{/hasSourceCode}}
''';

final String __source_link = '''
{{#hasSourceHref}}
[view source]({{{sourceHref}}})
{{/hasSourceHref}}
''';
