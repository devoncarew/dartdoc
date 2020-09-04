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
  'packages': __packages,
  'property': __property,
  'search_sidebar': __search_sidebar,
  'sidebar_for_category': __sidebar_for_category,
  'sidebar_for_class': __sidebar_for_class,
  'sidebar_for_container': __sidebar_for_container,
  'sidebar_for_enum': __sidebar_for_enum,
  'sidebar_for_extension': __sidebar_for_extension,
  'sidebar_for_library': __sidebar_for_library,
  'source_code': __source_code,
  'source_link': __source_link,
};

final String _404error = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5><span class="package-name">{{self.name}}</span> <span class="package-kind">{{self.kind}}</span></h5>
    {{>packages}}
  </div>

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    <h1>404: Something's gone wrong :-(</h1>

    <section class="desc">
      <p>You've tried to visit a page that doesn't exist.  Luckily this site
         has other <a href="index.html">pages</a>.</p>
      <p>If you were looking for something specific, try searching:
      <form class="search-body" role="search">
        <input type="text" id="search-body" autocomplete="off" disabled class="form-control typeahead" placeholder="Loading search...">
      </form>
      </p>

    </section>
  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
  </div>

{{>footer}}
''';

final String _category = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5><span class="package-name">{{parent.name}}</span> <span class="package-kind">{{parent.kind}}</span></h5>
    {{>packages}}
  </div>

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <h1><span class="kind-category">{{name}}</span> {{kind}}</h1>
      {{>documentation}}

      {{#hasPublicLibraries}}
        <section class="summary offset-anchor" id="libraries">
        <h2>Libraries</h2>

        <dl>
          {{#publicLibraries}}
            {{>library}}
          {{/publicLibraries}}
        </dl>
        </section>
      {{/hasPublicLibraries}}

      {{#hasPublicClasses}}
        <section class="summary offset-anchor" id="classes">
        <h2>Classes</h2>

        <dl>
          {{#publicClasses}}
            {{>class}}
          {{/publicClasses}}
        </dl>
      </section>
      {{/hasPublicClasses}}

      {{#hasPublicMixins}}
      <section class="summary offset-anchor" id="mixins">
        <h2>Mixins</h2>

        <dl>
          {{#publicMixins}}
          {{>mixin}}
          {{/publicMixins}}
        </dl>
      </section>
      {{/hasPublicMixins}}

      {{#hasPublicConstants}}
      <section class="summary offset-anchor" id="constants">
        <h2>Constants</h2>

        <dl class="properties">
          {{#publicConstants}}
            {{>constant}}
          {{/publicConstants}}
        </dl>
      </section>
      {{/hasPublicConstants}}

      {{#hasPublicProperties}}
      <section class="summary offset-anchor" id="properties">
        <h2>Properties</h2>

        <dl class="properties">
          {{#publicProperties}}
            {{>property}}
          {{/publicProperties}}
        </dl>
      </section>
      {{/hasPublicProperties}}

      {{#hasPublicFunctions}}
      <section class="summary offset-anchor" id="functions">
        <h2>Functions</h2>

        <dl class="callables">
          {{#publicFunctions}}
            {{>callable}}
          {{/publicFunctions}}
        </dl>
      </section>
      {{/hasPublicFunctions}}

      {{#hasPublicEnums}}
      <section class="summary offset-anchor" id="enums">
        <h2>Enums</h2>

        <dl>
          {{#publicEnums}}
            {{>class}}
          {{/publicEnums}}
        </dl>
      </section>
      {{/hasPublicEnums}}

      {{#hasPublicTypedefs}}
      <section class="summary offset-anchor" id="typedefs">
        <h2>Typedefs</h2>

        <dl class="callables">
          {{#publicTypedefs}}
            {{>callable}}
          {{/publicTypedefs}}
        </dl>
      </section>
      {{/hasPublicTypedefs}}

      {{#hasPublicExceptions}}
      <section class="summary offset-anchor" id="exceptions">
        <h2>Exceptions / Errors</h2>

        <dl>
          {{#publicExceptions}}
            {{>class}}
          {{/publicExceptions}}
        </dl>
      </section>
      {{/hasPublicExceptions}}
    {{/self}}

  </div> <!-- /.main-content -->
  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
    <h5>{{self.name}} {{self.kind}}</h5>
    {{>sidebar_for_category}}
  </div><!--/sidebar-offcanvas-right-->
{{>footer}}
''';

final String _class = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5>{{parent.name}} {{parent.kind}}</h5>
    {{>sidebar_for_library}}
  </div>

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <div>{{>source_link}}<h1><span class="kind-class">{{{nameWithGenerics}}}</span> {{kind}} {{>feature_set}} {{>categorization}}</h1></div>
    {{/self}}

    {{#clazz}}
    {{>documentation}}

    {{#hasModifiers}}
    <section>
      <dl class="dl-horizontal">
        {{#hasPublicSuperChainReversed}}
        <dt>Inheritance</dt>
        <dd><ul class="gt-separated dark clazz-relationships">
          <li>{{{linkedObjectType}}}</li>
          {{#publicSuperChainReversed}}
          <li>{{{linkedName}}}</li>
          {{/publicSuperChainReversed}}
          <li>{{{name}}}</li>
        </ul></dd>
        {{/hasPublicSuperChainReversed}}

        {{#hasPublicInterfaces}}
        <dt>Implemented types</dt>
        <dd>
          <ul class="comma-separated clazz-relationships">
            {{#publicInterfaces}}
            <li>{{{linkedName}}}</li>
            {{/publicInterfaces}}
          </ul>
        </dd>
        {{/hasPublicInterfaces}}

        {{#hasPublicMixins}}
        <dt>Mixed in types</dt>
        <dd><ul class="comma-separated clazz-relationships">
          {{#publicMixins}}
          <li>{{{linkedName}}}</li>
          {{/publicMixins}}
        </ul></dd>
        {{/hasPublicMixins}}

        {{#hasPublicImplementors}}
        <dt>Implementers</dt>
        <dd><ul class="comma-separated clazz-relationships">
          {{#publicImplementors}}
          <li>{{{linkedName}}}</li>
          {{/publicImplementors}}
        </ul></dd>
        {{/hasPublicImplementors}}

        {{#hasPotentiallyApplicableExtensions}}
        <dt>Available Extensions</dt>
        <dd><ul class="comma-separated clazz-relationships">
          {{#potentiallyApplicableExtensionsSorted}}
          <li>{{{linkedName}}}</li>
          {{/potentiallyApplicableExtensionsSorted}}
        </ul></dd>
        {{/hasPotentiallyApplicableExtensions}}

        {{#hasAnnotations}}
        <dt>Annotations</dt>
        <dd><ul class="annotation-list clazz-relationships">
          {{#annotations}}
          <li>{{{.}}}</li>
          {{/annotations}}
        </ul></dd>
        {{/hasAnnotations}}
      </dl>
    </section>
    {{/hasModifiers}}

    {{#hasPublicConstructors}}
    <section class="summary offset-anchor" id="constructors">
      <h2>Constructors</h2>

      <dl class="constructor-summary-list">
        {{#publicConstructorsSorted}}
        <dt id="{{htmlId}}" class="callable">
          <span class="name">{{{linkedName}}}</span><span class="signature">({{{ linkedParams }}})</span>
        </dt>
        <dd>
          {{{ oneLineDoc }}} {{{ extendedDocLink }}}
          {{#isConst}}
          <div class="constructor-modifier features">const</div>
          {{/isConst}}
          {{#isFactory}}
          <div class="constructor-modifier features">factory</div>
          {{/isFactory}}
        </dd>
        {{/publicConstructorsSorted}}
      </dl>
    </section>
    {{/hasPublicConstructors}}

    {{#hasPublicInstanceFields}}
    <section class="summary offset-anchor{{ #publicInheritedInstanceFields }} inherited{{ /publicInheritedInstanceFields }}" id="instance-properties">
      <h2>Properties</h2>

      <dl class="properties">
        {{#publicInstanceFieldsSorted}}
        {{>property}}
        {{/publicInstanceFieldsSorted}}
      </dl>
    </section>
    {{/hasPublicInstanceFields}}

    {{#hasPublicInstanceMethods}}
    <section class="summary offset-anchor{{ #publicInheritedInstanceMethods }} inherited{{ /publicInheritedInstanceMethods }}" id="instance-methods">
      <h2>Methods</h2>
      <dl class="callables">
        {{#publicInstanceMethodsSorted}}
        {{>callable}}
        {{/publicInstanceMethodsSorted}}
      </dl>
    </section>
    {{/hasPublicInstanceMethods}}

    {{#hasPublicInstanceOperators}}
    <section class="summary offset-anchor{{ #publicInheritedInstanceOperators }} inherited{{ /publicInheritedInstanceOperators}}" id="operators">
      <h2>Operators</h2>
      <dl class="callables">
        {{#publicInstanceOperatorsSorted}}
        {{>callable}}
        {{/publicInstanceOperatorsSorted}}
      </dl>
    </section>
    {{/hasPublicInstanceOperators}}

    {{#hasPublicVariableStaticFields}}
    <section class="summary offset-anchor" id="static-properties">
      <h2>Static Properties</h2>

      <dl class="properties">
        {{#publicVariableStaticFieldsSorted}}
        {{>property}}
        {{/publicVariableStaticFieldsSorted}}
      </dl>
    </section>
    {{/hasPublicVariableStaticFields}}

    {{#hasPublicStaticMethods}}
    <section class="summary offset-anchor" id="static-methods">
      <h2>Static Methods</h2>
      <dl class="callables">
        {{#publicStaticMethodsSorted}}
        {{>callable}}
        {{/publicStaticMethodsSorted}}
      </dl>
    </section>
    {{/hasPublicStaticMethods}}

    {{#hasPublicConstantFields}}
    <section class="summary offset-anchor" id="constants">
      <h2>Constants</h2>

      <dl class="properties">
        {{#publicConstantFieldsSorted}}
        {{>constant}}
        {{/publicConstantFieldsSorted}}
      </dl>
    </section>
    {{/hasPublicConstantFields}}
    {{/clazz}}

  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
    {{>sidebar_for_class}}
  </div><!--/.sidebar-offcanvas-->

{{>footer}}
''';

final String _constant = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5>{{parent.name}} {{parent.kind}}</h5>
    {{>sidebar_for_container}}
  </div><!--/.sidebar-offcanvas-left-->

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <div>{{>source_link}}<h1><span class="kind-constant">{{{name}}}</span> {{kind}} {{>feature_set}}</h1></div>
    {{/self}}

    <section class="multi-line-signature">
      {{#property}}
        <span class="returntype">{{{ linkedReturnType }}}</span>
        {{>name_summary}}
        =
        <span class="constant-value">{{{ constantValue }}}</span>
      {{/property}}
    </section>

    {{#property}}
    {{>documentation}}
    {{>source_code}}
    {{/property}}

  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
  </div><!--/.sidebar-offcanvas-->

{{>footer}}
''';

final String _constructor = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5>{{parent.name}} {{parent.kind}}</h5>
    {{>sidebar_for_class}}
  </div><!--/.sidebar-offcanvas-left-->

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <div>{{>source_link}}<h1><span class="kind-constructor">{{{nameWithGenerics}}}</span> {{kind}} {{>feature_set}}</h1></div>
    {{/self}}

    {{#constructor}}
    <section class="multi-line-signature">
      {{#hasAnnotations}}
      <div>
        <ol class="annotation-list">
          {{#annotations}}
          <li>{{{.}}}</li>
          {{/annotations}}
        </ol>
      </div>
      {{/hasAnnotations}}
      {{#isConst}}const{{/isConst}}
      <span class="name {{#isDeprecated}}deprecated{{/isDeprecated}}">{{{nameWithGenerics}}}</span>(<wbr>{{#hasParameters}}{{{linkedParamsLines}}}{{/hasParameters}})
    </section>

    {{>documentation}}

    {{>source_code}}

    {{/constructor}}
  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
  </div><!--/.sidebar-offcanvas-->

{{>footer}}
''';

final String _enum = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5>{{parent.name}} {{parent.kind}}</h5>
    {{>sidebar_for_library}}
  </div>

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <div>{{>source_link}}<h1><span class="kind-enum">{{{name}}}</span> {{kind}} {{>feature_set}} {{>categorization}}</h1></div>
    {{/self}}

    {{#eNum}}
    {{>documentation}}

    {{#hasModifiers}}
    <section>
      <dl class="dl-horizontal">
        {{#hasPublicSuperChainReversed}}
        <dt>Inheritance</dt>
        <dd><ul class="gt-separated dark eNum-relationships">
          <li>{{{linkedObjectType}}}</li>
          {{#publicSuperChainReversed}}
          <li>{{{linkedName}}}</li>
          {{/publicSuperChainReversed}}
          <li>{{{name}}}</li>
        </ul></dd>
        {{/hasPublicSuperChainReversed}}

        {{#hasPublicInterfaces}}
        <dt>Implemented types</dt>
        <dd>
          <ul class="comma-separated eNum-relationships">
            {{#publicInterfaces}}
            <li>{{{linkedName}}}</li>
            {{/publicInterfaces}}
          </ul>
        </dd>
        {{/hasPublicInterfaces}}

        {{#hasPublicMixins}}
        <dt>Mixed in types</dt>
        <dd><ul class="comma-separated eNum-relationships">
          {{#publicMixins}}
          <li>{{{linkedName}}}</li>
          {{/publicMixins}}
        </ul></dd>
        {{/hasPublicMixins}}

        {{#hasPublicImplementors}}
        <dt>Implementers</dt>
        <dd><ul class="comma-separated eNum-relationships">
          {{#publicImplementors}}
          <li>{{{linkedName}}}</li>
          {{/publicImplementors}}
        </ul></dd>
        {{/hasPublicImplementors}}

        {{#hasAnnotations}}
        <dt>Annotations</dt>
        <dd><ul class="annotation-list eNum-relationships">
          {{#annotations}}
          <li>{{{.}}}</li>
          {{/annotations}}
        </ul></dd>
        {{/hasAnnotations}}
      </dl>
    </section>
    {{/hasModifiers}}

    {{#hasPublicConstantFields}}
    <section class="summary offset-anchor" id="constants">
      <h2>Constants</h2>

      <dl class="properties">
        {{#publicConstantFieldsSorted}}
        {{>constant}}
        {{/publicConstantFieldsSorted}}
      </dl>
    </section>
    {{/hasPublicConstantFields}}

    {{#hasPublicConstructors}}
    <section class="summary offset-anchor" id="constructors">
      <h2>Constructors</h2>

      <dl class="constructor-summary-list">
        {{#publicConstructorsSorted}}
        <dt id="{{htmlId}}" class="callable">
          <span class="name">{{{linkedName}}}</span><span class="signature">({{{ linkedParams }}})</span>
        </dt>
        <dd>
          {{{ oneLineDoc }}} {{{ extendedDocLink }}}
          {{#isConst}}
          <div class="constructor-modifier features">const</div>
          {{/isConst}}
          {{#isFactory}}
          <div class="constructor-modifier features">factory</div>
          {{/isFactory}}
        </dd>
        {{/publicConstructorsSorted}}
      </dl>
    </section>
    {{/hasPublicConstructors}}

    {{#hasPublicInstanceFields}}
    <section class="summary offset-anchor{{ #publicInheritedInstanceFields }} inherited{{ /publicInheritedInstanceFields }}" id="instance-properties">
      <h2>Properties</h2>

      <dl class="properties">
        {{#publicInstanceFieldsSorted}}
        {{>property}}
        {{/publicInstanceFieldsSorted}}
      </dl>
    </section>
    {{/hasPublicInstanceFields}}

    {{#hasPublicInstanceMethods}}
    <section class="summary offset-anchor{{ #publicInheritedInstanceMethods }} inherited{{ /publicInheritedInstanceMethods }}" id="instance-methods">
      <h2>Methods</h2>
      <dl class="callables">
        {{#publicInstanceMethodsSorted}}
        {{>callable}}
        {{/publicInstanceMethodsSorted}}
      </dl>
    </section>
    {{/hasPublicInstanceMethods}}

    {{#hasPublicInstanceOperators}}
    <section class="summary offset-anchor{{ #publicInheritedInstanceOperators }} inherited{{ /publicInheritedInstanceOperators}}" id="operators">
      <h2>Operators</h2>
      <dl class="callables">
        {{#publicInstanceOperatorsSorted}}
        {{>callable}}
        {{/publicInstanceOperatorsSorted}}
      </dl>
    </section>
    {{/hasPublicInstanceOperators}}

    {{#hasPublicVariableStaticFields}}
    <section class="summary offset-anchor" id="static-properties">
      <h2>Static Properties</h2>

      <dl class="properties">
        {{#publicVariableStaticFieldsSorted}}
        {{>property}}
        {{/publicVariableStaticFieldsSorted}}
      </dl>
    </section>
    {{/hasPublicVariableStaticFields}}

    {{#hasPublicStaticMethods}}
    <section class="summary offset-anchor" id="static-methods">
      <h2>Static Methods</h2>
      <dl class="callables">
        {{#publicStaticMethodsSorted}}
        {{>callable}}
        {{/publicStaticMethodsSorted}}
      </dl>
    </section>
    {{/hasPublicStaticMethods}}
    {{/eNum}}
  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
    {{>sidebar_for_enum}}
  </div><!--/.sidebar-offcanvas-->

{{>footer}}
''';

final String _extension = '''
{{>head}}

<div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5>{{parent.name}} {{parent.kind}}</h5>
    {{>sidebar_for_library}}
</div>

<div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
    <div>{{>source_link}}<h1><span class="kind-class">{{{nameWithGenerics}}}</span> {{kind}} {{>feature_set}} {{>categorization}}</h1></div>
    {{/self}}

    {{#extension}}
    {{>documentation}}
    <section>
        <dl class="dl-horizontal">
        <dt>on</dt>
        <dd>
            <ul class="comma-separated clazz-relationships">
            {{#extendedType}}
            <li>{{{linkedName}}}</li>
            {{/extendedType}}
            </ul>
        </dd>
        </dl>
    </section>

    {{#hasPublicInstanceFields}}
    <section class="summary offset-anchor" id="instance-properties">
        <h2>Properties</h2>

        <dl class="properties">
            {{#publicInstanceFieldsSorted}}
            {{>property}}
            {{/publicInstanceFieldsSorted}}
        </dl>
    </section>
    {{/hasPublicInstanceFields}}

    {{#hasPublicInstanceMethods}}
    <section class="summary offset-anchor" id="instance-methods">
        <h2>Methods</h2>
        <dl class="callables">
            {{#publicInstanceMethodsSorted}}
            {{>callable}}
            {{/publicInstanceMethodsSorted}}
        </dl>
    </section>
    {{/hasPublicInstanceMethods}}

    {{#hasPublicInstanceOperators}}
    <section class="summary offset-anchor" id="operators">
        <h2>Operators</h2>
        <dl class="callables">
            {{#publicInstanceOperatorsSorted}}
            {{>callable}}
            {{/publicInstanceOperatorsSorted}}
        </dl>
    </section>
    {{/hasPublicInstanceOperators}}

    {{#hasPublicVariableStaticFields}}
    <section class="summary offset-anchor" id="static-properties">
        <h2>Static Properties</h2>

        <dl class="properties">
            {{#publicVariableStaticFieldsSorted}}
            {{>property}}
            {{/publicVariableStaticFieldsSorted}}
        </dl>
    </section>
    {{/hasPublicVariableStaticFields}}

    {{#hasPublicStaticMethods}}
    <section class="summary offset-anchor" id="static-methods">
        <h2>Static Methods</h2>
        <dl class="callables">
            {{#publicStaticMethodsSorted}}
            {{>callable}}
            {{/publicStaticMethodsSorted}}
        </dl>
    </section>
    {{/hasPublicStaticMethods}}

    {{#hasPublicConstantFields}}
    <section class="summary offset-anchor" id="constants">
        <h2>Constants</h2>

        <dl class="properties">
            {{#publicConstantFieldsSorted}}
            {{>constant}}
            {{/publicConstantFieldsSorted}}
        </dl>
    </section>
    {{/hasPublicConstantFields}}
    {{/extension}}

</div> <!-- /.main-content -->

<div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
    {{>sidebar_for_extension}}
</div><!--/.sidebar-offcanvas-->

{{>footer}}
''';

final String _function = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5>{{parent.name}} {{parent.kind}}</h5>
    {{>sidebar_for_library}}
  </div><!--/.sidebar-offcanvas-left-->

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <div>{{>source_link}}<h1><span class="kind-function">{{{nameWithGenerics}}}</span> {{kind}} {{>feature_set}} {{>categorization}}</h1></div>
    {{/self}}

    {{#function}}
    <section class="multi-line-signature">
        {{>callable_multiline}}
    </section>
    {{>documentation}}

    {{>source_code}}

    {{/function}}
  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
  </div><!--/.sidebar-offcanvas-->

{{>footer}}
''';

final String _index = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5 class="hidden-xs"><span class="package-name">{{self.name}}</span> <span class="package-kind">{{self.kind}}</span></h5>
    {{>packages}}
  </div>

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#packageGraph.defaultPackage}}
      {{>documentation}}
    {{/packageGraph.defaultPackage}}

    {{#packageGraph}}
      {{#localPackages}}
        <section class="summary">
          {{#isFirstPackage}}
            <h2>Libraries</h2>
          {{/isFirstPackage}}
          {{^isFirstPackage}}
            <h2>{{name}}</h2>
          {{/isFirstPackage}}
          <dl>
          {{#defaultCategory.publicLibraries}}
            {{>library}}
          {{/defaultCategory.publicLibraries}}
          {{#categoriesWithPublicLibraries}}
            <h3>{{name}}</h3>
            {{#publicLibraries}}
              {{>library}}
            {{/publicLibraries}}
          {{/categoriesWithPublicLibraries}}
          </dl>
        </section>
      {{/localPackages}}
    {{/packageGraph}}

  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
  </div>

{{>footer}}
''';

final String _library = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5><span class="package-name">{{parent.name}}</span> <span class="package-kind">{{parent.kind}}</span></h5>
    {{>packages}}
  </div>

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <div>{{>source_link}}<h1><span class="kind-library">{{{name}}}</span> {{kind}} {{>feature_set}} {{>categorization}}</h1></div>
    {{/self}}

    {{#library}}
    {{>documentation}}
    {{/library}}

    {{#library.hasPublicClasses}}
    <section class="summary offset-anchor" id="classes">
      <h2>Classes</h2>

      <dl>
        {{#library.publicClasses}}
        {{>class}}
        {{/library.publicClasses}}
      </dl>
    </section>
    {{/library.hasPublicClasses}}

    {{#library.hasPublicMixins}}
    <section class="summary offset-anchor" id="mixins">
      <h2>Mixins</h2>

      <dl>
        {{#library.publicMixins}}
        {{>mixin}}
        {{/library.publicMixins}}
      </dl>
    </section>
    {{/library.hasPublicMixins}}

    {{#library.hasPublicExtensions}}
    <section class="summary offset-anchor" id="extensions">
      <h2>Extensions</h2>

      <dl>
        {{#library.publicExtensions}}
        {{>extension}}
        {{/library.publicExtensions}}
      </dl>
    </section>
    {{/library.hasPublicExtensions}}

    {{#library.hasPublicConstants}}
    <section class="summary offset-anchor" id="constants">
      <h2>Constants</h2>

      <dl class="properties">
        {{#library.publicConstants}}
        {{>constant}}
        {{/library.publicConstants}}
      </dl>
    </section>
    {{/library.hasPublicConstants}}

    {{#library.hasPublicProperties}}
    <section class="summary offset-anchor" id="properties">
      <h2>Properties</h2>

      <dl class="properties">
        {{#library.publicProperties}}
        {{>property}}
        {{/library.publicProperties}}
      </dl>
    </section>
    {{/library.hasPublicProperties}}

    {{#library.hasPublicFunctions}}
    <section class="summary offset-anchor" id="functions">
      <h2>Functions</h2>

      <dl class="callables">
        {{#library.publicFunctions}}
        {{>callable}}
        {{/library.publicFunctions}}
      </dl>
    </section>
    {{/library.hasPublicFunctions}}

    {{#library.hasPublicEnums}}
    <section class="summary offset-anchor" id="enums">
      <h2>Enums</h2>

      <dl>
        {{#library.publicEnums}}
        {{>class}}
        {{/library.publicEnums}}
      </dl>
    </section>
    {{/library.hasPublicEnums}}

    {{#library.hasPublicTypedefs}}
    <section class="summary offset-anchor" id="typedefs">
      <h2>Typedefs</h2>

      <dl class="callables">
        {{#library.publicTypedefs}}
        {{>callable}}
        {{/library.publicTypedefs}}
      </dl>
    </section>
    {{/library.hasPublicTypedefs}}

    {{#library.hasPublicExceptions}}
    <section class="summary offset-anchor" id="exceptions">
      <h2>Exceptions / Errors</h2>

      <dl>
        {{#library.publicExceptions}}
        {{>class}}
        {{/library.publicExceptions}}
      </dl>
    </section>
    {{/library.hasPublicExceptions}}

  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
    <h5>{{self.name}} {{self.kind}}</h5>
    {{>sidebar_for_library}}
  </div><!--/sidebar-offcanvas-right-->

{{>footer}}
''';

final String _method = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5>{{parent.name}} {{parent.kind}}</h5>
    {{>sidebar_for_container}}
  </div><!--/.sidebar-offcanvas-->

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <div>{{>source_link}}<h1><span class="kind-method">{{{nameWithGenerics}}}</span> {{kind}} {{>feature_set}}</h1></div>
    {{/self}}

    {{#method}}
    <section class="multi-line-signature">
      {{>callable_multiline}}
      {{>features}}
    </section>
    {{>documentation}}

    {{>source_code}}

    {{/method}}
  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
  </div><!--/.sidebar-offcanvas-->

{{>footer}}
''';

final String _mixin = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5>{{parent.name}} {{parent.kind}}</h5>
    {{>sidebar_for_library}}
  </div>

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <div>{{>source_link}}<h1><span class="kind-mixin">{{{nameWithGenerics}}}</span> {{kind}} {{>feature_set}} {{>categorization}}</h1></div>
    {{/self}}

    {{#mixin}}
    {{>documentation}}

    {{#hasModifiers}}
    <section>
      <dl class="dl-horizontal">
        {{#hasPublicSuperclassConstraints}}
        <dt>Superclass Constraints</dt>
        <dd><ul class="comma-separated dark mixin-relationships">
          {{#publicSuperclassConstraints}}
          <li>{{{linkedName}}}</li>
          {{/publicSuperclassConstraints}}
        </ul></dd>
        {{/hasPublicSuperclassConstraints}}

        {{#hasPublicSuperChainReversed}}
        <dt>Inheritance</dt>
        <dd><ul class="gt-separated dark mixin-relationships">
          <li>{{{linkedObjectType}}}</li>
          {{#publicSuperChainReversed}}
          <li>{{{linkedName}}}</li>
          {{/publicSuperChainReversed}}
          <li>{{{name}}}</li>
        </ul></dd>
        {{/hasPublicSuperChainReversed}}

        {{#hasPublicInterfaces}}
        <dt>Implements</dt>
        <dd>
          <ul class="comma-separated mixin-relationships">
            {{#publicInterfaces}}
            <li>{{{linkedName}}}</li>
            {{/publicInterfaces}}
          </ul>
        </dd>
        {{/hasPublicInterfaces}}

        {{#hasPublicMixins}}
        <dt>Mixes-in</dt>
        <dd><ul class="comma-separated mixin-relationships">
          {{#publicMixins}}
          <li>{{{linkedName}}}</li>
          {{/publicMixins}}
        </ul></dd>
        {{/hasPublicMixins}}

        {{#hasPublicImplementors}}
        <dt>Implemented by</dt>
        <dd><ul class="comma-separated mixin-relationships">
          {{#publicImplementors}}
          <li>{{{linkedName}}}</li>
          {{/publicImplementors}}
        </ul></dd>
        {{/hasPublicImplementors}}

        {{#hasAnnotations}}
        <dt>Annotations</dt>
        <dd><ul class="annotation-list mixin-relationships">
          {{#annotations}}
          <li>{{{.}}}</li>
          {{/annotations}}
        </ul></dd>
        {{/hasAnnotations}}
      </dl>
    </section>
    {{/hasModifiers}}

    {{#hasPublicConstructors}}
    <section class="summary offset-anchor" id="constructors">
      <h2>Constructors</h2>

      <dl class="constructor-summary-list">
        {{#publicConstructors}}
        <dt id="{{htmlId}}" class="callable">
          <span class="name">{{{linkedName}}}</span><span class="signature">({{{ linkedParams }}})</span>
        </dt>
        <dd>
          {{{ oneLineDoc }}} {{{ extendedDocLink }}}
          {{#isConst}}
          <div class="constructor-modifier features">const</div>
          {{/isConst}}
          {{#isFactory}}
          <div class="constructor-modifier features">factory</div>
          {{/isFactory}}
        </dd>
        {{/publicConstructors}}
      </dl>
    </section>
    {{/hasPublicConstructors}}

    {{#hasPublicInstanceFields}}
    <section class="summary offset-anchor{{ #publicInheritedInstanceFields }} inherited{{ /publicInheritedInstanceFields }}" id="instance-properties">
      <h2>Properties</h2>

      <dl class="properties">
        {{#publicInstanceFields}}
        {{>property}}
        {{/publicInstanceFields}}
      </dl>
    </section>
    {{/hasPublicInstanceFields}}

    {{#hasPublicInstanceMethods}}
    <section class="summary offset-anchor{{ #publicInheritedInstanceMethods }} inherited{{ /publicInheritedInstanceMethods }}" id="instance-methods">
      <h2>Methods</h2>
      <dl class="callables">
        {{#publicInstanceMethods}}
        {{>callable}}
        {{/publicInstanceMethods}}
      </dl>
    </section>
    {{/hasPublicInstanceMethods}}

    {{#hasPublicInstanceOperators}}
    <section class="summary offset-anchor{{ #publicInheritedInstanceOperators }} inherited{{ /publicInheritedInstanceOperators}}" id="operators">
      <h2>Operators</h2>
      <dl class="callables">
        {{#publicInstanceOperatorsSorted}}
        {{>callable}}
        {{/publicInstanceOperatorsSorted}}
      </dl>
    </section>
    {{/hasPublicInstanceOperators}}

    {{#hasPublicVariableStaticFields}}
    <section class="summary offset-anchor" id="static-properties">
      <h2>Static Properties</h2>

      <dl class="properties">
        {{#publicVariableStaticFieldsSorted}}
        {{>property}}
        {{/publicVariableStaticFieldsSorted}}
      </dl>
    </section>
    {{/hasPublicVariableStaticFields}}

    {{#hasPublicStaticMethods}}
    <section class="summary offset-anchor" id="static-methods">
      <h2>Static Methods</h2>
      <dl class="callables">
        {{#publicStaticMethods}}
        {{>callable}}
        {{/publicStaticMethods}}
      </dl>
    </section>
    {{/hasPublicStaticMethods}}

    {{#hasPublicConstantFields}}
    <section class="summary offset-anchor" id="constants">
      <h2>Constants</h2>

      <dl class="properties">
        {{#publicConstantFieldsSorted}}
        {{>constant}}
        {{/publicConstantFieldsSorted}}
      </dl>
    </section>
    {{/hasPublicConstantFields}}
    {{/mixin}}
  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
    {{>sidebar_for_class}}
  </div><!--/.sidebar-offcanvas-->

{{>footer}}
''';

final String _property = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5>{{parent.name}} {{parent.kind}}</h5>
    {{>sidebar_for_container}}
  </div><!--/.sidebar-offcanvas-->

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <div>{{>source_link}}<h1><span class="kind-property">{{name}}</span> {{kind}} {{>feature_set}}</h1></div>
    {{/self}}

    {{#self}}
      {{#hasNoGetterSetter}}
        <section class="multi-line-signature">
          <span class="returntype">{{{ linkedReturnType }}}</span>
          {{>name_summary}}
          {{>features}}
        </section>
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
  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
  </div><!--/.sidebar-offcanvas-->

{{>footer}}
''';

final String _top_level_constant = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5>{{parent.name}} {{parent.kind}}</h5>
    {{>sidebar_for_library}}
  </div><!--/.sidebar-offcanvas-left-->

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <div>{{>source_link}}<h1><span class="kind-top-level-constant">{{{name}}}</span> {{kind}} {{>feature_set}} {{>categorization}}</h1></div>

      <section class="multi-line-signature">
        {{>name_summary}}
        =
        <span class="constant-value">{{{ constantValue }}}</span>
        {{>features}}
      </section>
      {{>documentation}}
      {{>source_code}}
    {{/self}}

  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
  </div><!--/.sidebar-offcanvas-->

{{>footer}}
''';

final String _top_level_property = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5>{{parent.name}} {{parent.kind}}</h5>
    {{>sidebar_for_library}}
  </div><!--/.sidebar-offcanvas-left-->

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <div>{{>source_link}}<h1><span class="kind-top-level-property">{{{name}}}</span> {{kind}} {{>feature_set}} {{>categorization}}</h1></div>

      {{#hasNoGetterSetter}}
        <section class="multi-line-signature">
          <span class="returntype">{{{ linkedReturnType }}}</span>
          {{>name_summary}}
          {{>features}}
        </section>
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
  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
  </div><!--/.sidebar-offcanvas-->

{{>footer}}
''';

final String _typedef = '''
{{>head}}

  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">
    {{>search_sidebar}}
    <h5>{{parent.name}} {{parent.kind}}</h5>
    {{>sidebar_for_library}}
  </div><!--/.sidebar-offcanvas-left-->

  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">
    {{#self}}
      <div>{{>source_link}}<h1><span class="kind-typedef">{{{nameWithGenerics}}}</span> {{kind}} {{>feature_set}} {{>categorization}}</h1></div>
    {{/self}}

    <section class="multi-line-signature">
      {{#typeDef}}
        {{>callable_multiline}}
      {{/typeDef}}
    </section>

    {{#typeDef}}
    {{>documentation}}
    {{>source_code}}
    {{/typeDef}}

  </div> <!-- /.main-content -->

  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">
  </div><!--/.sidebar-offcanvas-->

{{>footer}}
''';

final String __accessor_getter = '''
{{#getter}}
<section id="getter">

<section class="multi-line-signature">
  <span class="returntype">{{{ linkedReturnType }}}</span>
  {{>name_summary}}
  {{>features}}
</section>

{{>documentation}}
{{>source_code}}
</section>
{{/getter}}
''';

final String __accessor_setter = '''
{{#setter}}
<section id="setter">

<section class="multi-line-signature">
  <span class="returntype">void</span>
  {{>name_summary}}<span class="signature">(<wbr>{{{ linkedParamsNoMetadata }}})</span>
  {{>features}}
</section>

{{>documentation}}
{{>source_code}}
</section>
{{/setter}}
''';

final String __callable = '''
<dt id="{{htmlId}}" class="callable{{ #isInherited }} inherited{{ /isInherited}}">
  <span class="name{{#isDeprecated}} deprecated{{/isDeprecated}}">{{{linkedName}}}</span>{{{linkedGenericParameters}}}<span class="signature">(<wbr>{{{ linkedParamsNoMetadata }}})
    <span class="returntype parameter">&#8594; {{{ linkedReturnType }}}</span>
  </span>
  {{>categorization}}
</dt>
<dd{{ #isInherited }} class="inherited"{{ /isInherited}}>
  {{{ oneLineDoc }}} {{{ extendedDocLink }}}
  {{>features}}
</dd>
''';

final String __callable_multiline = '''
{{#hasAnnotations}}
<div>
  <ol class="annotation-list">
    {{#annotations}}
    <li>{{{.}}}</li>
    {{/annotations}}
  </ol>
</div>
{{/hasAnnotations}}
<span class="returntype">{{{ linkedReturnType }}}</span>
{{>name_summary}}{{{genericParameters}}}(<wbr>{{#hasParameters}}{{{linkedParamsLines}}}{{/hasParameters}})
''';

final String __categorization = '''
{{#hasCategoryNames}}
  {{#displayedCategories}}
    {{{categoryLabel}}}
  {{/displayedCategories}}
{{/hasCategoryNames}}
''';

final String __class = '''
<dt id="{{htmlId}}">
  <span class="name {{#isDeprecated}}deprecated{{/isDeprecated}}">{{{linkedName}}}{{{linkedGenericParameters}}}</span> {{>categorization}}
</dt>
<dd>
  {{{ oneLineDoc }}} {{{ extendedDocLink }}}
</dd>
''';

final String __constant = '''
<dt id="{{htmlId}}" class="constant">
  <span class="name {{#isDeprecated}}deprecated{{/isDeprecated}}">{{{ linkedName }}}</span>
  <span class="signature">&#8594; const {{{ linkedReturnType }}}</span>
  {{>categorization}}
</dt>
<dd>
  {{{ oneLineDoc }}} {{{ extendedDocLink }}}
  {{>features}}
  <div>
    <span class="signature"><code>{{{ constantValueTruncated }}}</code></span>
  </div>
</dd>
''';

final String __documentation = '''
{{#hasDocumentation}}
<section class="desc markdown">
  {{{ documentationAsHtml }}}
</section>
{{/hasDocumentation}}
''';

final String __extension = '''
<dt id="{{htmlId}}">
    <span class="name {{#isDeprecated}}deprecated{{/isDeprecated}}">{{{linkedName}}}</span> {{>categorization}}
</dt>
<dd>
    {{{ oneLineDoc }}} {{{ extendedDocLink }}}
</dd>
''';

final String __feature_set = '''
{{#hasFeatureSet}}
  {{#displayedLanguageFeatures}}
    {{{featureLabel}}}
  {{/displayedLanguageFeatures}}
{{/hasFeatureSet}}
''';

final String __features = '''
{{ #featuresAsString.isNotEmpty }}<div class="features">{{{featuresAsString}}}</div>{{ /featuresAsString.isNotEmpty }}
''';

final String __footer = '''
</main>

<footer>
  <span class="no-break">
    {{packageGraph.defaultPackage.name}}
    {{#packageGraph.hasFooterVersion}}
      {{packageGraph.defaultPackage.version}}
    {{/packageGraph.hasFooterVersion}}
  </span>

  {{! footer-text placeholder }}
</footer>

{{! TODO(jdkoren): unwrap ^useBaseHref sections when the option is removed.}}
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/typeahead.bundle.min.js"></script>
<script src="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/highlight.pack.js"></script>
<script src="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/URI.js"></script>
<script src="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/script.js"></script>

{{! footer placeholder }}

</body>

</html>
''';

final String __head = '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1, user-scalable=no">
  {{#includeVersion}}
  <meta name="generator" content="made with love by dartdoc {{version}}">
  {{/includeVersion}}
  <meta name="description" content="{{ metaDescription }}">
  <title>{{ title }}</title>
  {{ #relCanonicalPrefix }}
  <link rel="canonical" href="{{{relCanonicalPrefix}}}/{{{bareHref}}}">
  {{ /relCanonicalPrefix}}

  {{#useBaseHref}}{{! TODO(jdkoren): remove when the useBaseHref option is removed.}}
  {{#htmlBase}}
  <!-- required because all the links are pseudo-absolute -->
  <base href="{{{htmlBase}}}">
  {{/htmlBase}}
  {{/useBaseHref}}

  {{! TODO(jdkoren): unwrap ^useBaseHref sections when the option is removed.}}
  <link href="https://fonts.googleapis.com/css?family=Source+Code+Pro:500,400i,400,300|Source+Sans+Pro:400,300,700" rel="stylesheet">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <link rel="stylesheet" href="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/github.css">
  <link rel="stylesheet" href="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/styles.css">
  <link rel="icon" href="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/favicon.png">

  {{! header placeholder }}
</head>

{{! We don't use <base href>, but we do lookup the htmlBase from javascript. }}
<body data-base-href="{{{htmlBase}}}"
      data-using-base-href="{{{useBaseHref}}}">

<div id="overlay-under-drawer"></div>

<header id="title">
  <button id="sidenav-left-toggle" type="button">&nbsp;</button>
  <ol class="breadcrumbs gt-separated dark hidden-xs">
    {{#navLinks}}
    <li><a href="{{{href}}}">{{name}}</a></li>
    {{/navLinks}}
    {{#navLinksWithGenerics}}
    <li><a href="{{{href}}}">{{name}}{{#hasGenericParameters}}<span class="signature">{{{genericParameters}}}</span>{{/hasGenericParameters}}</a></li>
    {{/navLinksWithGenerics}}
    {{^hasHomepage}}
    <li class="self-crumb">{{{ layoutTitle }}}</li>
    {{/hasHomepage}}
    {{#hasHomepage}}
    <li><a href="{{{homepage}}}">{{{ layoutTitle }}}</a></li>
    {{/hasHomepage}}
  </ol>
  <div class="self-name">{{self.name}}</div>
  <form class="search navbar-right" role="search">
    <input type="text" id="search-box" autocomplete="off" disabled class="form-control typeahead" placeholder="Loading search...">
  </form>
</header>

<main>
''';

final String __library = '''
<dt id="{{htmlId}}">
  <span class="name">{{{ linkedName }}}</span> {{>categorization}}
</dt>
<dd>
  {{#isDocumented}}{{{ oneLineDoc }}} {{{ extendedDocLink }}}{{/isDocumented}}
</dd>
''';

final String __mixin = '''
<dt id="{{htmlId}}">
  <span class="name {{#isDeprecated}}deprecated{{/isDeprecated}}">{{{linkedName}}}{{{linkedGenericParameters}}}</span> {{>categorization}}
</dt>
<dd>
  {{{ oneLineDoc }}} {{{ extendedDocLink }}}
</dd>
''';

final String __name_summary = '''
{{#isConst}}const {{/isConst}}<span class="name {{#isDeprecated}}deprecated{{/isDeprecated}}">{{name}}</span>
''';

final String __packages = '''
<ol>
  {{#packageGraph.localPackages}}
    {{#isFirstPackage}}
      {{#hasDocumentedCategories}}
      <li class="section-title">Topics</li>
        {{#documentedCategories}}
        <li>{{{linkedName}}}</li>
        {{/documentedCategories}}
      {{/hasDocumentedCategories}}
      <li class="section-title">Libraries</li>
    {{/isFirstPackage}}
    {{^isFirstPackage}}
      <li class="section-title">{{name}}</li>
    {{/isFirstPackage}}
    {{#defaultCategory.publicLibraries}}
      <li>{{{linkedName}}}</li>
    {{/defaultCategory.publicLibraries}}
    {{#categoriesWithPublicLibraries}}
      <li class="section-subtitle">{{name}}</li>
      {{#publicLibraries}}
        <li class="section-subitem">{{{linkedName}}}</li>
      {{/publicLibraries}}
    {{/categoriesWithPublicLibraries}}
  {{/packageGraph.localPackages}}
</ol>
''';

final String __property = '''
<dt id="{{htmlId}}" class="property{{ #isInherited }} inherited{{ /isInherited}}">
  <span class="name">{{{linkedName}}}</span>
  <span class="signature">{{{ arrow }}} {{{ linkedReturnType }}}</span> {{>categorization}}
</dt>
<dd{{ #isInherited }} class="inherited"{{ /isInherited}}>
  {{{ oneLineDoc }}} {{{ extendedDocLink }}}
  {{>features}}
</dd>
''';

final String __search_sidebar = '''
<header id="header-search-sidebar" class="hidden-l">
  <form class="search-sidebar" role="search">
    <input type="text" id="search-sidebar" autocomplete="off" disabled class="form-control typeahead" placeholder="Loading search...">
  </form>
</header>

<ol class="breadcrumbs gt-separated dark hidden-l" id="sidebar-nav">
  {{#navLinks}}
  <li><a href="{{{href}}}">{{name}}</a></li>
  {{/navLinks}}
  {{#navLinksWithGenerics}}
  <li><a href="{{{href}}}">{{name}}{{#hasGenericParameters}}<span class="signature">{{{genericParameters}}}</span>{{/hasGenericParameters}}</a></li>
  {{/navLinksWithGenerics}}
  {{^hasHomepage}}
  <li class="self-crumb">{{{ layoutTitle }}}</li>
  {{/hasHomepage}}
  {{#hasHomepage}}
  <li><a href="{{{homepage}}}">{{{ layoutTitle }}}</a></li>
  {{/hasHomepage}}
</ol>
''';

final String __sidebar_for_category = '''
<ol>
  {{#self.hasPublicLibraries}}
  <li class="section-title"><a href="{{{self.href}}}#libraries">Libraries</a></li>
  {{#self.publicLibraries}}
  <li>{{{ linkedName }}}</li>
  {{/self.publicLibraries}}
  {{/self.hasPublicLibraries}}

  {{#self.hasPublicMixins}}
  <li class="section-title"><a href="{{{library.href}}}#mixins">Mixins</a></li>
  {{#self.publicMixins}}
  <li>{{{ linkedName }}}</li>
  {{/self.publicMixins}}
  {{/self.hasPublicMixins}}

  {{#self.hasPublicClasses}}
  <li class="section-title"><a href="{{{self.href}}}#classes">Classes</a></li>
  {{#self.publicClasses}}
  <li>{{{ linkedName }}}</li>
  {{/self.publicClasses}}
  {{/self.hasPublicClasses}}

  {{#self.hasPublicConstants}}
  <li class="section-title"><a href="{{{self.href}}}#constants">Constants</a></li>
  {{#self.publicConstants}}
  <li>{{{ linkedName }}}</li>
  {{/self.publicConstants}}
  {{/self.hasPublicConstants}}

  {{#self.hasPublicProperties}}
  <li class="section-title"><a href="{{{self.href}}}#properties">Properties</a></li>
  {{#self.publicProperties}}
  <li>{{{ linkedName }}}</li>
  {{/self.publicProperties}}
  {{/self.hasPublicProperties}}

  {{#self.hasPublicFunctions}}
  <li class="section-title"><a href="{{{self.href}}}#functions">Functions</a></li>
  {{#self.publicFunctions}}
  <li>{{{ linkedName }}}</li>
  {{/self.publicFunctions}}
  {{/self.hasPublicFunctions}}

  {{#self.hasPublicEnums}}
  <li class="section-title"><a href="{{{self.href}}}#enums">Enums</a></li>
  {{#self.publicEnums}}
  <li>{{{ linkedName }}}</li>
  {{/self.publicEnums}}
  {{/self.hasPublicEnums}}

  {{#self.hasPublicTypedefs}}
  <li class="section-title"><a href="{{{self.href}}}#typedefs">Typedefs</a></li>
  {{#self.publicTypedefs}}
  <li>{{{ linkedName }}}</li>
  {{/self.publicTypedefs}}
  {{/self.hasPublicTypedefs}}

  {{#self.hasPublicExceptions}}
  <li class="section-title"><a href="{{{self.href}}}#exceptions">Exceptions</a></li>
  {{#self.publicExceptions}}
  <li>{{{ linkedName }}}</li>
  {{/self.publicExceptions}}
  {{/self.hasPublicExceptions}}
</ol>
''';

final String __sidebar_for_class = '''
<ol>
  {{#clazz}}

  {{#hasPublicConstructors}}
  <li class="section-title"><a href="{{{href}}}#constructors">Constructors</a></li>
  {{#publicConstructorsSorted}}
  <li><a{{#isDeprecated}} class="deprecated"{{/isDeprecated}} href="{{{href}}}">{{shortName}}</a></li>
  {{/publicConstructorsSorted}}
  {{/hasPublicConstructors}}

  {{#hasPublicInstanceFields}}
  <li class="section-title{{ #publicInheritedInstanceFields }} inherited{{ /publicInheritedInstanceFields }}">
    <a href="{{{href}}}#instance-properties">Properties</a>
  </li>
  {{#publicInstanceFieldsSorted}}
  <li{{ #isInherited }} class="inherited"{{ /isInherited}}>{{{ linkedName }}}</li>
  {{/publicInstanceFieldsSorted}}
  {{/hasPublicInstanceFields}}

  {{#hasPublicInstanceMethods}}
  <li class="section-title{{ #publicInheritedInstanceMethods }} inherited{{ /publicInheritedInstanceMethods }}"><a href="{{{href}}}#instance-methods">Methods</a></li>
  {{#publicInstanceMethodsSorted}}
  <li{{ #isInherited }} class="inherited"{{ /isInherited}}>{{{ linkedName }}}</li>
  {{/publicInstanceMethodsSorted}}
  {{/hasPublicInstanceMethods}}

  {{#hasPublicInstanceOperators}}
  <li class="section-title{{ #publicInheritedInstanceOperators }} inherited{{ /publicInheritedInstanceOperators}}"><a href="{{{href}}}#operators">Operators</a></li>
  {{#publicInstanceOperatorsSorted}}
  <li{{ #isInherited }} class="inherited"{{ /isInherited}}>{{{ linkedName }}}</li>
  {{/publicInstanceOperatorsSorted}}
  {{/hasPublicInstanceOperators}}

  {{#hasPublicVariableStaticFields}}
  <li class="section-title"><a href="{{{href}}}#static-properties">Static properties</a></li>
  {{#publicVariableStaticFieldsSorted}}
  <li>{{{ linkedName }}}</li>
  {{/publicVariableStaticFieldsSorted}}
  {{/hasPublicVariableStaticFields}}

  {{#hasPublicStaticMethods}}
  <li class="section-title"><a href="{{{href}}}#static-methods">Static methods</a></li>
  {{#publicStaticMethodsSorted}}
  <li>{{{ linkedName }}}</li>
  {{/publicStaticMethodsSorted}}
  {{/hasPublicStaticMethods}}

  {{#hasPublicConstantFields}}
  <li class="section-title"><a href="{{{href}}}#constants">Constants</a></li>
  {{#publicConstantFieldsSorted}}
  <li>{{{linkedName}}}</li>
  {{/publicConstantFieldsSorted}}
  {{/hasPublicConstantFields}}

  {{/clazz}}
</ol>
''';

final String __sidebar_for_container = '''
<ol>
    {{#container}}

    {{#isClass}}
    {{#hasPublicConstructors}}
    <li class="section-title"><a href="{{{href}}}#constructors">Constructors</a></li>
    {{#publicConstructorsSorted}}
    <li><a{{#isDeprecated}} class="deprecated"{{/isDeprecated}} href="{{{href}}}">{{shortName}}</a></li>
    {{/publicConstructorsSorted}}
    {{/hasPublicConstructors}}

    {{#hasPublicInstanceFields}}
    <li class="section-title{{ #publicInheritedInstanceFields }} inherited{{ /publicInheritedInstanceFields }}">
        <a href="{{{href}}}#instance-properties">Properties</a>
    </li>
    {{#publicInstanceFieldsSorted}}
    <li{{ #isInherited }} class="inherited"{{ /isInherited}}>{{{ linkedName }}}</li>
    {{/publicInstanceFieldsSorted}}
    {{/hasPublicInstanceFields}}

    {{#hasPublicInstanceMethods}}
    <li class="section-title{{ #publicInheritedInstanceMethods }} inherited{{ /publicInheritedInstanceMethods }}"><a href="{{{href}}}#instance-methods">Methods</a></li>
    {{#publicInstanceMethodsSorted}}
    <li{{ #isInherited }} class="inherited"{{ /isInherited}}>{{{ linkedName }}}</li>
    {{/publicInstanceMethodsSorted}}
    {{/hasPublicInstanceMethods}}

    {{#hasPublicInstanceOperators}}
    <li class="section-title{{ #publicInheritedInstanceOperators }} inherited{{ /publicInheritedInstanceOperators}}"><a href="{{{href}}}#operators">Operators</a></li>
    {{#publicInstanceOperatorsSorted}}
    <li{{ #isInherited }} class="inherited"{{ /isInherited}}>{{{ linkedName }}}</li>
    {{/publicInstanceOperatorsSorted}}
    {{/hasPublicInstanceOperators}}

    {{#hasPublicVariableStaticFields}}
    <li class="section-title"><a href="{{{href}}}#static-properties">Static properties</a></li>
    {{#publicVariableStaticFieldsSorted}}
    <li>{{{ linkedName }}}</li>
    {{/publicVariableStaticFieldsSorted}}
    {{/hasPublicVariableStaticFields}}

    {{#hasPublicStaticMethods}}
    <li class="section-title"><a href="{{{href}}}#static-methods">Static methods</a></li>
    {{#publicStaticMethodsSorted}}
    <li>{{{ linkedName }}}</li>
    {{/publicStaticMethodsSorted}}
    {{/hasPublicStaticMethods}}

    {{#hasPublicConstantFields}}
    <li class="section-title"><a href="{{{href}}}#constants">Constants</a></li>
    {{#publicConstantFieldsSorted}}
    <li>{{{linkedName}}}</li>
    {{/publicConstantFieldsSorted}}
    {{/hasPublicConstantFields}}
    {{/isClass}}

    {{#isExtension}}
    {{#hasPublicInstanceFields}}
    <li class="section-title"> <a href="{{{href}}}#instance-properties">Properties</a>
    </li>
    {{#publicInstanceFieldsSorted}}
    <li>{{{ linkedName }}}</li>
    {{/publicInstanceFieldsSorted}}
    {{/hasPublicInstanceFields}}

    {{#hasPublicInstanceMethods}}
    <li class="section-title"><a href="{{{href}}}#instance-methods">Methods</a></li>
    {{#publicInstanceMethodsSorted}}
    <li>{{{ linkedName }}}</li>
    {{/publicInstanceMethodsSorted}}
    {{/hasPublicInstanceMethods}}

    {{#hasPublicInstanceOperators}}
    <li class="section-title"><a href="{{{href}}}#operators">Operators</a></li>
    {{#publicInstanceOperatorsSorted}}
    <li>{{{ linkedName }}}</li>
    {{/publicInstanceOperatorsSorted}}
    {{/hasPublicInstanceOperators}}

    {{#hasPublicVariableStaticFields}}
    <li class="section-title"><a href="{{{href}}}#static-properties">Static properties</a></li>
    {{#publicVariableStaticFieldsSorted}}
    <li>{{{ linkedName }}}</li>
    {{/publicVariableStaticFieldsSorted}}
    {{/hasPublicVariableStaticFields}}

    {{#hasPublicStaticMethods}}
    <li class="section-title"><a href="{{{href}}}#static-methods">Static methods</a></li>
    {{#publicStaticMethodsSorted}}
    <li>{{{ linkedName }}}</li>
    {{/publicStaticMethodsSorted}}
    {{/hasPublicStaticMethods}}

    {{#hasPublicConstantFields}}
    <li class="section-title"><a href="{{{href}}}#constants">Constants</a></li>
    {{#publicConstantFieldsSorted}}
    <li>{{{linkedName}}}</li>
    {{/publicConstantFieldsSorted}}
    {{/hasPublicConstantFields}}
    {{/isExtension}}

    {{/container}}
</ol>
''';

final String __sidebar_for_enum = '''
<ol>
  {{#eNum}}
  {{#hasPublicConstantFields}}
  <li class="section-title"><a href="{{{href}}}#constants">Constants</a></li>
  {{#publicConstantFieldsSorted}}
  <li>{{{linkedName}}}</li>
  {{/publicConstantFieldsSorted}}
  {{/hasPublicConstantFields}}

  {{#hasPublicConstructors}}
  <li class="section-title"><a href="{{{href}}}#constructors">Constructors</a></li>
  {{#publicConstructorsSorted}}
  <li><a{{#isDeprecated}} class="deprecated"{{/isDeprecated}} href="{{{href}}}">{{shortName}}</a></li>
  {{/publicConstructorsSorted}}
  {{/hasPublicConstructors}}

  {{#hasPublicInstanceFields}}
  <li class="section-title{{ #publicInheritedInstanceFields }} inherited{{ /publicInheritedInstanceFields }}">
    <a href="{{{href}}}#instance-properties">Properties</a>
  </li>
  {{#publicInstanceFieldsSorted}}
  <li{{ #isInherited }} class="inherited"{{ /isInherited}}>{{{ linkedName }}}</li>
  {{/publicInstanceFieldsSorted}}
  {{/hasPublicInstanceFields}}

  {{#hasPublicInstanceMethods}}
  <li class="section-title{{ #publicInheritedInstanceMethods }} inherited{{ /publicInheritedInstanceMethods }}"><a href="{{{href}}}#instance-methods">Methods</a></li>
  {{#publicInstanceMethodsSorted}}
  <li{{ #isInherited }} class="inherited"{{ /isInherited}}>{{{ linkedName }}}</li>
  {{/publicInstanceMethodsSorted}}
  {{/hasPublicInstanceMethods}}

  {{#hasPublicInstanceOperators}}
  <li class="section-title{{ #publicInheritedInstanceOperators }} inherited{{ /publicInheritedInstanceOperators}}"><a href="{{{href}}}#operators">Operators</a></li>
  {{#publicInstanceOperatorsSorted}}
  <li{{ #isInherited }} class="inherited"{{ /isInherited}}>{{{ linkedName }}}</li>
  {{/publicInstanceOperatorsSorted}}
  {{/hasPublicInstanceOperators}}

  {{#hasPublicVariableStaticFields}}
  <li class="section-title"><a href="{{{href}}}#static-properties">Static properties</a></li>
  {{#publicVariableStaticFieldsSorted}}
  <li>{{{ linkedName }}}</li>
  {{/publicVariableStaticFieldsSorted}}
  {{/hasPublicVariableStaticFields}}

  {{#hasPublicStaticMethods}}
  <li class="section-title"><a href="{{{href}}}#static-methods">Static methods</a></li>
  {{#publicStaticMethodsSorted}}
  <li>{{{ linkedName }}}</li>
  {{/publicStaticMethodsSorted}}
  {{/hasPublicStaticMethods}}
  {{/eNum}}
</ol>
''';

final String __sidebar_for_extension = '''
<ol>
    {{#extension}}

    {{#hasPublicInstanceFields}}
    <li class="section-title"> <a href="{{{href}}}#instance-properties">Properties</a>
    </li>
    {{#publicInstanceFieldsSorted}}
    <li>{{{ linkedName }}}</li>
    {{/publicInstanceFieldsSorted}}
    {{/hasPublicInstanceFields}}

    {{#hasPublicInstanceMethods}}
    <li class="section-title"><a href="{{{href}}}#instance-methods">Methods</a></li>
    {{#publicInstanceMethodsSorted}}
    <li>{{{ linkedName }}}</li>
    {{/publicInstanceMethodsSorted}}
    {{/hasPublicInstanceMethods}}

    {{#hasPublicInstanceOperators}}
    <li class="section-title"><a href="{{{href}}}#operators">Operators</a></li>
    {{#publicInstanceOperatorsSorted}}
    <li>{{{ linkedName }}}</li>
    {{/publicInstanceOperatorsSorted}}
    {{/hasPublicInstanceOperators}}

    {{#hasPublicVariableStaticFields}}
    <li class="section-title"><a href="{{{href}}}#static-properties">Static properties</a></li>
    {{#publicVariableStaticFieldsSorted}}
    <li>{{{ linkedName }}}</li>
    {{/publicVariableStaticFieldsSorted}}
    {{/hasPublicVariableStaticFields}}

    {{#hasPublicStaticMethods}}
    <li class="section-title"><a href="{{{href}}}#static-methods">Static methods</a></li>
    {{#publicStaticMethodsSorted}}
    <li>{{{ linkedName }}}</li>
    {{/publicStaticMethodsSorted}}
    {{/hasPublicStaticMethods}}

    {{#hasPublicConstantFields}}
    <li class="section-title"><a href="{{{href}}}#constants">Constants</a></li>
    {{#publicConstantFieldsSorted}}
    <li>{{{linkedName}}}</li>
    {{/publicConstantFieldsSorted}}
    {{/hasPublicConstantFields}}

    {{/extension}}
</ol>
''';

final String __sidebar_for_library = '''
<ol>
  {{#library}}
  {{#hasPublicClasses}}
  <li class="section-title"><a href="{{{href}}}#classes">Classes</a></li>
  {{#publicClasses}}
  <li>{{{ linkedName }}}</li>
  {{/publicClasses}}
  {{/hasPublicClasses}}

  {{#hasPublicExtensions}}
  <li class="section-title"><a href="{{{href}}}#extension">Extensions</a></li>
  {{#publicExtensions}}
  <li>{{{ linkedName }}}</li>
  {{/publicExtensions}}
  {{/hasPublicExtensions}}

  {{#hasPublicMixins}}
  <li class="section-title"><a href="{{{href}}}#mixins">Mixins</a></li>
  {{#publicMixins}}
  <li>{{{ linkedName }}}</li>
  {{/publicMixins}}
  {{/hasPublicMixins}}

  {{#hasPublicConstants}}
  <li class="section-title"><a href="{{{href}}}#constants">Constants</a></li>
  {{#publicConstants}}
  <li>{{{ linkedName }}}</li>
  {{/publicConstants}}
  {{/hasPublicConstants}}

  {{#hasPublicProperties}}
  <li class="section-title"><a href="{{{href}}}#properties">Properties</a></li>
  {{#publicProperties}}
  <li>{{{ linkedName }}}</li>
  {{/publicProperties}}
  {{/hasPublicProperties}}

  {{#hasPublicFunctions}}
  <li class="section-title"><a href="{{{href}}}#functions">Functions</a></li>
  {{#publicFunctions}}
  <li>{{{ linkedName }}}</li>
  {{/publicFunctions}}
  {{/hasPublicFunctions}}

  {{#hasPublicEnums}}
  <li class="section-title"><a href="{{{href}}}#enums">Enums</a></li>
  {{#publicEnums}}
  <li>{{{ linkedName }}}</li>
  {{/publicEnums}}
  {{/hasPublicEnums}}

  {{#hasPublicTypedefs}}
  <li class="section-title"><a href="{{{href}}}#typedefs">Typedefs</a></li>
  {{#publicTypedefs}}
  <li>{{{ linkedName }}}</li>
  {{/publicTypedefs}}
  {{/hasPublicTypedefs}}

  {{#hasPublicExceptions}}
  <li class="section-title"><a href="{{{href}}}#exceptions">Exceptions</a></li>
  {{#publicExceptions}}
  <li>{{{ linkedName }}}</li>
  {{/publicExceptions}}
  {{/hasPublicExceptions}}
  {{/library}}
</ol>
''';

final String __source_code = '''
{{#hasSourceCode}}
<section class="summary source-code" id="source">
  <h2><span>Implementation</span></h2>
  <pre class="language-dart"><code class="language-dart">{{{ sourceCode }}}</code></pre>
</section>{{/hasSourceCode}}
''';

final String __source_link = '''
{{#hasSourceHref}}
  <div id="external-links" class="btn-group"><a title="View source code" class="source-link" href="{{{sourceHref}}}"><i class="material-icons">description</i></a></div>
{{/hasSourceHref}}
''';
