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

class HtmlGenerator extends Generator {
  void generate404error(PackageTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5><span class="package-name">${escape(ref.self.name)}</span> <span class="package-kind">${escape(ref.self.kind)}</span></h5>');
    _includePackages(ref);
    write('  </div>');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    write('    <h1>404: Something\'s gone wrong :-(</h1>');
    write('');
    write('    <section class="desc">');
    write('      <p>You\'ve tried to visit a page that doesn\'t exist. Luckily this site');
    write('         has other <a href="index.html">pages</a>.</p>');
    write('      <p>If you were looking for something specific, try searching:');
    write('      <form class="search-body" role="search">');
    write('        <input type="text" id="search-body" autocomplete="off" disabled class="form-control typeahead" placeholder="Loading search...">');
    write('      </form>');
    write('      </p>');
    write('');
    write('    </section>');
    write('  </div>');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    write('  </div>');
    write('');
    _includeFooter(ref);
  }

  void generateCategory(CategoryTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5><span class="package-name">${escape(ref.parent.name)}</span> <span class="package-kind">${escape(ref.parent.kind)}</span></h5>');
    _includePackages(ref);
    write('  </div>');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <h1><span class="kind-category">${escape(self.name)}</span> ${escape(self.kind)}</h1>');
      _includeDocumentation(self);
      write('');
      if (self.hasPublicLibraries) {
        write('        <section class="summary offset-anchor" id="libraries">');
        write('        <h2>Libraries</h2>');
        write('');
        write('        <dl>');
        for (var item in self.publicLibraries) {
          _includeLibrary(item);
        }
        write('        </dl>');
        write('        </section>');
      }
      write('');
      if (self.hasPublicClasses) {
        write('        <section class="summary offset-anchor" id="classes">');
        write('        <h2>Classes</h2>');
        write('');
        write('        <dl>');
        for (var item in self.publicClasses) {
          _includeClass(item);
        }
        write('        </dl>');
        write('      </section>');
      }
      write('');
      if (self.hasPublicMixins) {
        write('      <section class="summary offset-anchor" id="mixins">');
        write('        <h2>Mixins</h2>');
        write('');
        write('        <dl>');
        for (var item in self.publicMixins) {
          _includeMixin(item);
        }
        write('        </dl>');
        write('      </section>');
      }
      write('');
      if (self.hasPublicConstants) {
        write('      <section class="summary offset-anchor" id="constants">');
        write('        <h2>Constants</h2>');
        write('');
        write('        <dl class="properties">');
        for (var item in self.publicConstants) {
          _includeConstant(item);
        }
        write('        </dl>');
        write('      </section>');
      }
      write('');
      if (self.hasPublicProperties) {
        write('      <section class="summary offset-anchor" id="properties">');
        write('        <h2>Properties</h2>');
        write('');
        write('        <dl class="properties">');
        for (var item in self.publicProperties) {
          _includeProperty(item);
        }
        write('        </dl>');
        write('      </section>');
      }
      write('');
      if (self.hasPublicFunctions) {
        write('      <section class="summary offset-anchor" id="functions">');
        write('        <h2>Functions</h2>');
        write('');
        write('        <dl class="callables">');
        for (var item in self.publicFunctions) {
          _includeCallable(item);
        }
        write('        </dl>');
        write('      </section>');
      }
      write('');
      if (self.hasPublicEnums) {
        write('      <section class="summary offset-anchor" id="enums">');
        write('        <h2>Enums</h2>');
        write('');
        write('        <dl>');
        for (var item in self.publicEnums) {
          _includeClass(item);
        }
        write('        </dl>');
        write('      </section>');
      }
      write('');
      if (self.hasPublicTypedefs) {
        write('      <section class="summary offset-anchor" id="typedefs">');
        write('        <h2>Typedefs</h2>');
        write('');
        write('        <dl class="callables">');
        for (var item in self.publicTypedefs) {
          _includeCallable(item);
        }
        write('        </dl>');
        write('      </section>');
      }
      write('');
      if (self.hasPublicExceptions) {
        write('      <section class="summary offset-anchor" id="exceptions">');
        write('        <h2>Exceptions / Errors</h2>');
        write('');
        write('        <dl>');
        for (var item in self.publicExceptions) {
          _includeClass(item);
        }
        write('        </dl>');
        write('      </section>');
      }
    }
    write('');
    write('  </div> <!-- /.main-content -->');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    write('    <h5>${escape(ref.self.name)} ${escape(ref.self.kind)}</h5>');
    _includeSidebarForCategory(ref);
    write('  </div><!--/sidebar-offcanvas-right-->');
    _includeFooter(ref);
  }

  void generateClass(ClassTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5>${escape(ref.parent.name)} ${escape(ref.parent.kind)}</h5>');
    _includeSidebarForLibrary(ref);
    write('  </div>');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <div>${_inlineSourceLink(self)}<h1><span class="kind-class">${self.nameWithGenerics}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)} ${_inlineCategorization(self)}</h1></div>');
    }
    write('');
    {
      var clazz = ref.clazz;
      _includeDocumentation(clazz);
      write('');
      if (clazz.hasModifiers) {
        write('    <section>');
        write('      <dl class="dl-horizontal">');
        if (clazz.hasPublicSuperChainReversed) {
          write('        <dt>Inheritance</dt>');
          write('        <dd><ul class="gt-separated dark clazz-relationships">');
          write('          <li>${clazz.linkedObjectType}</li>');
          for (var item in clazz.publicSuperChainReversed) {
            write('          <li>${item.linkedName}</li>');
          }
          write('          <li>${clazz.name}</li>');
          write('        </ul></dd>');
        }
        write('');
        if (clazz.hasPublicInterfaces) {
          write('        <dt>Implemented types</dt>');
          write('        <dd>');
          write('          <ul class="comma-separated clazz-relationships">');
          for (var item in clazz.publicInterfaces) {
            write('            <li>${item.linkedName}</li>');
          }
          write('          </ul>');
          write('        </dd>');
        }
        write('');
        if (clazz.hasPublicMixins) {
          write('        <dt>Mixed in types</dt>');
          write('        <dd><ul class="comma-separated clazz-relationships">');
          for (var item in clazz.publicMixins) {
            write('          <li>${item.linkedName}</li>');
          }
          write('        </ul></dd>');
        }
        write('');
        if (clazz.hasPublicImplementors) {
          write('        <dt>Implementers</dt>');
          write('        <dd><ul class="comma-separated clazz-relationships">');
          for (var item in clazz.publicImplementors) {
            write('          <li>${item.linkedName}</li>');
          }
          write('        </ul></dd>');
        }
        write('');
        if (clazz.hasPotentiallyApplicableExtensions) {
          write('        <dt>Available Extensions</dt>');
          write('        <dd><ul class="comma-separated clazz-relationships">');
          for (var item in clazz.potentiallyApplicableExtensionsSorted) {
            write('          <li>${item.linkedName}</li>');
          }
          write('        </ul></dd>');
        }
        write('');
        if (clazz.hasAnnotations) {
          write('        <dt>Annotations</dt>');
          write('        <dd><ul class="annotation-list clazz-relationships">');
          for (var item in clazz.annotations) {
            write('          <li>$item</li>');
          }
          write('        </ul></dd>');
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (clazz.hasPublicConstructors) {
        write('    <section class="summary offset-anchor" id="constructors">');
        write('      <h2>Constructors</h2>');
        write('');
        write('      <dl class="constructor-summary-list">');
        for (var item in clazz.publicConstructorsSorted) {
          write('        <dt id="${escape(item.htmlId)}" class="callable">');
          write('          <span class="name">${item.linkedName}</span><span class="signature">(${item.linkedParams})</span>');
          write('        </dt>');
          write('        <dd>');
          write('          ${item.oneLineDoc} ${item.extendedDocLink}');
          if (item.isConst) {
            write('          <div class="constructor-modifier features">const</div>');
          }
          if (item.isFactory) {
            write('          <div class="constructor-modifier features">factory</div>');
          }
          write('        </dd>');
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (clazz.hasPublicInstanceFields) {
        write('    <section class="summary offset-anchor{{ #publicInheritedInstanceFields }} inherited{{ /publicInheritedInstanceFields }}" id="instance-properties">');
        write('      <h2>Properties</h2>');
        write('');
        write('      <dl class="properties">');
        for (var item in clazz.publicInstanceFieldsSorted) {
          _includeProperty(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (clazz.hasPublicInstanceMethods) {
        write('    <section class="summary offset-anchor{{ #publicInheritedInstanceMethods }} inherited{{ /publicInheritedInstanceMethods }}" id="instance-methods">');
        write('      <h2>Methods</h2>');
        write('      <dl class="callables">');
        for (var item in clazz.publicInstanceMethodsSorted) {
          _includeCallable(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (clazz.hasPublicInstanceOperators) {
        write('    <section class="summary offset-anchor{{ #publicInheritedInstanceOperators }} inherited{{ /publicInheritedInstanceOperators}}" id="operators">');
        write('      <h2>Operators</h2>');
        write('      <dl class="callables">');
        for (var item in clazz.publicInstanceOperatorsSorted) {
          _includeCallable(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (clazz.hasPublicVariableStaticFields) {
        write('    <section class="summary offset-anchor" id="static-properties">');
        write('      <h2>Static Properties</h2>');
        write('');
        write('      <dl class="properties">');
        for (var item in clazz.publicVariableStaticFieldsSorted) {
          _includeProperty(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (clazz.hasPublicStaticMethods) {
        write('    <section class="summary offset-anchor" id="static-methods">');
        write('      <h2>Static Methods</h2>');
        write('      <dl class="callables">');
        for (var item in clazz.publicStaticMethodsSorted) {
          _includeCallable(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (clazz.hasPublicConstantFields) {
        write('    <section class="summary offset-anchor" id="constants">');
        write('      <h2>Constants</h2>');
        write('');
        write('      <dl class="properties">');
        for (var item in clazz.publicConstantFieldsSorted) {
          _includeConstant(item);
        }
        write('      </dl>');
        write('    </section>');
      }
    }
    write('');
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    _includeSidebarForClass(ref);
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    _includeFooter(ref);
  }

  void generateConstant(PropertyTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5>${escape(ref.parent.name)} ${escape(ref.parent.kind)}</h5>');
    _includeSidebarForContainer(ref);
    write('  </div><!--/.sidebar-offcanvas-left-->');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <div>${_inlineSourceLink(self)}<h1><span class="kind-constant">${self.name}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)}</h1></div>');
    }
    write('');
    write('    <section class="multi-line-signature">');
    {
      var property = ref.property;
      write('        <span class="returntype">${property.linkedReturnType}</span>');
      _includeNameSummary(property);
      write('        =');
      write('        <span class="constant-value">${property.constantValue}</span>');
    }
    write('    </section>');
    write('');
    {
      var property = ref.property;
      _includeDocumentation(property);
      _includeSourceCode(property);
    }
    write('');
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    _includeFooter(ref);
  }

  void generateConstructor(ConstructorTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5>${escape(ref.parent.name)} ${escape(ref.parent.kind)}</h5>');
    _includeSidebarForClass(ref);
    write('  </div><!--/.sidebar-offcanvas-left-->');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <div>${_inlineSourceLink(self)}<h1><span class="kind-constructor">${self.nameWithGenerics}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)}</h1></div>');
    }
    write('');
    {
      var constructor = ref.constructor;
      write('    <section class="multi-line-signature">');
      if (constructor.hasAnnotations) {
        write('      <div>');
        write('        <ol class="annotation-list">');
        for (var item in constructor.annotations) {
          write('          <li>$item</li>');
        }
        write('        </ol>');
        write('      </div>');
      }
      write('      {{#isConst}}const{{/isConst}}');
      write('      <span class="name {{#isDeprecated}}deprecated{{/isDeprecated}}">${constructor.nameWithGenerics}</span>(<wbr>{{#hasParameters}}${constructor.linkedParamsLines}{{/hasParameters}})');
      write('    </section>');
      write('');
      _includeDocumentation(constructor);
      write('');
      _includeSourceCode(constructor);
      write('');
    }
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    _includeFooter(ref);
  }

  void generateEnum(EnumTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5>${escape(ref.parent.name)} ${escape(ref.parent.kind)}</h5>');
    _includeSidebarForLibrary(ref);
    write('  </div>');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <div>${_inlineSourceLink(self)}<h1><span class="kind-enum">${self.name}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)} ${_inlineCategorization(self)}</h1></div>');
    }
    write('');
    {
      var eNum = ref.eNum;
      _includeDocumentation(eNum);
      write('');
      if (eNum.hasModifiers) {
        write('    <section>');
        write('      <dl class="dl-horizontal">');
        if (eNum.hasPublicSuperChainReversed) {
          write('        <dt>Inheritance</dt>');
          write('        <dd><ul class="gt-separated dark eNum-relationships">');
          write('          <li>${eNum.linkedObjectType}</li>');
          for (var item in eNum.publicSuperChainReversed) {
            write('          <li>${item.linkedName}</li>');
          }
          write('          <li>${eNum.name}</li>');
          write('        </ul></dd>');
        }
        write('');
        if (eNum.hasPublicInterfaces) {
          write('        <dt>Implemented types</dt>');
          write('        <dd>');
          write('          <ul class="comma-separated eNum-relationships">');
          for (var item in eNum.publicInterfaces) {
            write('            <li>${item.linkedName}</li>');
          }
          write('          </ul>');
          write('        </dd>');
        }
        write('');
        if (eNum.hasPublicMixins) {
          write('        <dt>Mixed in types</dt>');
          write('        <dd><ul class="comma-separated eNum-relationships">');
          for (var item in eNum.publicMixins) {
            write('          <li>${item.linkedName}</li>');
          }
          write('        </ul></dd>');
        }
        write('');
        if (eNum.hasPublicImplementors) {
          write('        <dt>Implementers</dt>');
          write('        <dd><ul class="comma-separated eNum-relationships">');
          for (var item in eNum.publicImplementors) {
            write('          <li>${item.linkedName}</li>');
          }
          write('        </ul></dd>');
        }
        write('');
        if (eNum.hasAnnotations) {
          write('        <dt>Annotations</dt>');
          write('        <dd><ul class="annotation-list eNum-relationships">');
          for (var item in eNum.annotations) {
            write('          <li>$item</li>');
          }
          write('        </ul></dd>');
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (eNum.hasPublicConstantFields) {
        write('    <section class="summary offset-anchor" id="constants">');
        write('      <h2>Constants</h2>');
        write('');
        write('      <dl class="properties">');
        for (var item in eNum.publicConstantFieldsSorted) {
          _includeConstant(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (eNum.hasPublicConstructors) {
        write('    <section class="summary offset-anchor" id="constructors">');
        write('      <h2>Constructors</h2>');
        write('');
        write('      <dl class="constructor-summary-list">');
        for (var item in eNum.publicConstructorsSorted) {
          write('        <dt id="${escape(item.htmlId)}" class="callable">');
          write('          <span class="name">${item.linkedName}</span><span class="signature">(${item.linkedParams})</span>');
          write('        </dt>');
          write('        <dd>');
          write('          ${item.oneLineDoc} ${item.extendedDocLink}');
          if (item.isConst) {
            write('          <div class="constructor-modifier features">const</div>');
          }
          if (item.isFactory) {
            write('          <div class="constructor-modifier features">factory</div>');
          }
          write('        </dd>');
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (eNum.hasPublicInstanceFields) {
        write('    <section class="summary offset-anchor{{ #publicInheritedInstanceFields }} inherited{{ /publicInheritedInstanceFields }}" id="instance-properties">');
        write('      <h2>Properties</h2>');
        write('');
        write('      <dl class="properties">');
        for (var item in eNum.publicInstanceFieldsSorted) {
          _includeProperty(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (eNum.hasPublicInstanceMethods) {
        write('    <section class="summary offset-anchor{{ #publicInheritedInstanceMethods }} inherited{{ /publicInheritedInstanceMethods }}" id="instance-methods">');
        write('      <h2>Methods</h2>');
        write('      <dl class="callables">');
        for (var item in eNum.publicInstanceMethodsSorted) {
          _includeCallable(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (eNum.hasPublicInstanceOperators) {
        write('    <section class="summary offset-anchor{{ #publicInheritedInstanceOperators }} inherited{{ /publicInheritedInstanceOperators}}" id="operators">');
        write('      <h2>Operators</h2>');
        write('      <dl class="callables">');
        for (var item in eNum.publicInstanceOperatorsSorted) {
          _includeCallable(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (eNum.hasPublicVariableStaticFields) {
        write('    <section class="summary offset-anchor" id="static-properties">');
        write('      <h2>Static Properties</h2>');
        write('');
        write('      <dl class="properties">');
        for (var item in eNum.publicVariableStaticFieldsSorted) {
          _includeProperty(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (eNum.hasPublicStaticMethods) {
        write('    <section class="summary offset-anchor" id="static-methods">');
        write('      <h2>Static Methods</h2>');
        write('      <dl class="callables">');
        for (var item in eNum.publicStaticMethodsSorted) {
          _includeCallable(item);
        }
        write('      </dl>');
        write('    </section>');
      }
    }
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    _includeSidebarForEnum(ref);
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    _includeFooter(ref);
  }

  void generateExtension(ExtensionTemplateData ref) {
    _includeHead(ref);
    write('');
    write('<div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5>${escape(ref.parent.name)} ${escape(ref.parent.kind)}</h5>');
    _includeSidebarForLibrary(ref);
    write('</div>');
    write('');
    write('<div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('    <div>${_inlineSourceLink(self)}<h1><span class="kind-class">${self.nameWithGenerics}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)} ${_inlineCategorization(self)}</h1></div>');
    }
    write('');
    {
      var extension = ref.extension;
      _includeDocumentation(extension);
      write('    <section>');
      write('        <dl class="dl-horizontal">');
      write('        <dt>on</dt>');
      write('        <dd>');
      write('            <ul class="comma-separated clazz-relationships">');
      {
        var extendedType = extension.extendedType;
        write('            <li>${extendedType.linkedName}</li>');
      }
      write('            </ul>');
      write('        </dd>');
      write('        </dl>');
      write('    </section>');
      write('');
      if (extension.hasPublicInstanceFields) {
        write('    <section class="summary offset-anchor" id="instance-properties">');
        write('        <h2>Properties</h2>');
        write('');
        write('        <dl class="properties">');
        for (var item in extension.publicInstanceFieldsSorted) {
          _includeProperty(item);
        }
        write('        </dl>');
        write('    </section>');
      }
      write('');
      if (extension.hasPublicInstanceMethods) {
        write('    <section class="summary offset-anchor" id="instance-methods">');
        write('        <h2>Methods</h2>');
        write('        <dl class="callables">');
        for (var item in extension.publicInstanceMethodsSorted) {
          _includeCallable(item);
        }
        write('        </dl>');
        write('    </section>');
      }
      write('');
      if (extension.hasPublicInstanceOperators) {
        write('    <section class="summary offset-anchor" id="operators">');
        write('        <h2>Operators</h2>');
        write('        <dl class="callables">');
        for (var item in extension.publicInstanceOperatorsSorted) {
          _includeCallable(item);
        }
        write('        </dl>');
        write('    </section>');
      }
      write('');
      if (extension.hasPublicVariableStaticFields) {
        write('    <section class="summary offset-anchor" id="static-properties">');
        write('        <h2>Static Properties</h2>');
        write('');
        write('        <dl class="properties">');
        for (var item in extension.publicVariableStaticFieldsSorted) {
          _includeProperty(item);
        }
        write('        </dl>');
        write('    </section>');
      }
      write('');
      if (extension.hasPublicStaticMethods) {
        write('    <section class="summary offset-anchor" id="static-methods">');
        write('        <h2>Static Methods</h2>');
        write('        <dl class="callables">');
        for (var item in extension.publicStaticMethodsSorted) {
          _includeCallable(item);
        }
        write('        </dl>');
        write('    </section>');
      }
      write('');
      if (extension.hasPublicConstantFields) {
        write('    <section class="summary offset-anchor" id="constants">');
        write('        <h2>Constants</h2>');
        write('');
        write('        <dl class="properties">');
        for (var item in extension.publicConstantFieldsSorted) {
          _includeConstant(item);
        }
        write('        </dl>');
        write('    </section>');
      }
    }
    write('');
    write('</div> <!-- /.main-content -->');
    write('');
    write('<div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    _includeSidebarForExtension(ref);
    write('</div><!--/.sidebar-offcanvas-->');
    write('');
    _includeFooter(ref);
  }

  void generateFunction(FunctionTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5>${escape(ref.parent.name)} ${escape(ref.parent.kind)}</h5>');
    _includeSidebarForLibrary(ref);
    write('  </div><!--/.sidebar-offcanvas-left-->');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <div>${_inlineSourceLink(self)}<h1><span class="kind-function">${self.nameWithGenerics}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)} ${_inlineCategorization(self)}</h1></div>');
    }
    write('');
    {
      var function = ref.function;
      write('    <section class="multi-line-signature">');
      _includeCallableMultiline(function);
      write('    </section>');
      _includeDocumentation(function);
      write('');
      _includeSourceCode(function);
      write('');
    }
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    _includeFooter(ref);
  }

  void generateIndex(TemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5 class="hidden-xs"><span class="package-name">${escape(ref.self.name)}</span> <span class="package-kind">${escape(ref.self.kind)}</span></h5>');
    _includePackages(ref);
    write('  </div>');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      // ref.packageGraph.defaultPackage
      _includeDocumentation(ref.packageGraph.defaultPackage);
    }
    write('');
    {
      var packageGraph = ref.packageGraph;
      for (var item in packageGraph.localPackages) {
        write('        <section class="summary">');
        if (item.isFirstPackage) {
          write('            <h2>Libraries</h2>');
        }
        if (!item.isFirstPackage) {
          write('            <h2>${escape(item.name)}</h2>');
        }
        write('          <dl>');
        for (var item in item.defaultCategory.publicLibraries) {
          _includeLibrary(item);
        }
        for (var item in item.categoriesWithPublicLibraries) {
          write('            <h3>${escape(item.name)}</h3>');
          for (var item in item.publicLibraries) {
            _includeLibrary(item);
          }
        }
        write('          </dl>');
        write('        </section>');
      }
    }
    write('');
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    write('  </div>');
    write('');
    _includeFooter(ref);
  }

  void generateLibrary(LibraryTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5><span class="package-name">${escape(ref.parent.name)}</span> <span class="package-kind">${escape(ref.parent.kind)}</span></h5>');
    _includePackages(ref);
    write('  </div>');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <div>${_inlineSourceLink(self)}<h1><span class="kind-library">${self.name}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)} ${_inlineCategorization(self)}</h1></div>');
    }
    write('');
    {
      var library = ref.library;
      _includeDocumentation(library);
    }
    write('');
    if (ref.library.hasPublicClasses) {
      write('    <section class="summary offset-anchor" id="classes">');
      write('      <h2>Classes</h2>');
      write('');
      write('      <dl>');
      for (var item in ref.library.publicClasses) {
        _includeClass(item);
      }
      write('      </dl>');
      write('    </section>');
    }
    write('');
    if (ref.library.hasPublicMixins) {
      write('    <section class="summary offset-anchor" id="mixins">');
      write('      <h2>Mixins</h2>');
      write('');
      write('      <dl>');
      for (var item in ref.library.publicMixins) {
        _includeMixin(item);
      }
      write('      </dl>');
      write('    </section>');
    }
    write('');
    if (ref.library.hasPublicExtensions) {
      write('    <section class="summary offset-anchor" id="extensions">');
      write('      <h2>Extensions</h2>');
      write('');
      write('      <dl>');
      for (var item in ref.library.publicExtensions) {
        _includeExtension(item);
      }
      write('      </dl>');
      write('    </section>');
    }
    write('');
    if (ref.library.hasPublicConstants) {
      write('    <section class="summary offset-anchor" id="constants">');
      write('      <h2>Constants</h2>');
      write('');
      write('      <dl class="properties">');
      for (var item in ref.library.publicConstants) {
        _includeConstant(item);
      }
      write('      </dl>');
      write('    </section>');
    }
    write('');
    if (ref.library.hasPublicProperties) {
      write('    <section class="summary offset-anchor" id="properties">');
      write('      <h2>Properties</h2>');
      write('');
      write('      <dl class="properties">');
      for (var item in ref.library.publicProperties) {
        _includeProperty(item);
      }
      write('      </dl>');
      write('    </section>');
    }
    write('');
    if (ref.library.hasPublicFunctions) {
      write('    <section class="summary offset-anchor" id="functions">');
      write('      <h2>Functions</h2>');
      write('');
      write('      <dl class="callables">');
      for (var item in ref.library.publicFunctions) {
        _includeCallable(item);
      }
      write('      </dl>');
      write('    </section>');
    }
    write('');
    if (ref.library.hasPublicEnums) {
      write('    <section class="summary offset-anchor" id="enums">');
      write('      <h2>Enums</h2>');
      write('');
      write('      <dl>');
      for (var item in ref.library.publicEnums) {
        _includeClass(item);
      }
      write('      </dl>');
      write('    </section>');
    }
    write('');
    if (ref.library.hasPublicTypedefs) {
      write('    <section class="summary offset-anchor" id="typedefs">');
      write('      <h2>Typedefs</h2>');
      write('');
      write('      <dl class="callables">');
      for (var item in ref.library.publicTypedefs) {
        _includeCallable(item);
      }
      write('      </dl>');
      write('    </section>');
    }
    write('');
    if (ref.library.hasPublicExceptions) {
      write('    <section class="summary offset-anchor" id="exceptions">');
      write('      <h2>Exceptions / Errors</h2>');
      write('');
      write('      <dl>');
      for (var item in ref.library.publicExceptions) {
        _includeClass(item);
      }
      write('      </dl>');
      write('    </section>');
    }
    write('');
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    write('    <h5>${escape(ref.self.name)} ${escape(ref.self.kind)}</h5>');
    _includeSidebarForLibrary(ref);
    write('  </div><!--/sidebar-offcanvas-right-->');
    write('');
    _includeFooter(ref);
  }

  void generateMethod(MethodTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5>${escape(ref.parent.name)} ${escape(ref.parent.kind)}</h5>');
    _includeSidebarForContainer(ref);
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <div>${_inlineSourceLink(self)}<h1><span class="kind-method">${self.nameWithGenerics}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)}</h1></div>');
    }
    write('');
    {
      var method = ref.method;
      write('    <section class="multi-line-signature">');
      _includeCallableMultiline(method);
      _includeFeatures(method);
      write('    </section>');
      _includeDocumentation(method);
      write('');
      _includeSourceCode(method);
      write('');
    }
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    _includeFooter(ref);
  }

  void generateMixin(MixinTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5>${escape(ref.parent.name)} ${escape(ref.parent.kind)}</h5>');
    _includeSidebarForLibrary(ref);
    write('  </div>');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <div>${_inlineSourceLink(self)}<h1><span class="kind-mixin">${self.nameWithGenerics}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)} ${_inlineCategorization(self)}</h1></div>');
    }
    write('');
    {
      var mixin = ref.mixin;
      _includeDocumentation(mixin);
      write('');
      if (mixin.hasModifiers) {
        write('    <section>');
        write('      <dl class="dl-horizontal">');
        if (mixin.hasPublicSuperclassConstraints) {
          write('        <dt>Superclass Constraints</dt>');
          write('        <dd><ul class="comma-separated dark mixin-relationships">');
          for (var item in mixin.publicSuperclassConstraints) {
            write('          <li>${item.linkedName}</li>');
          }
          write('        </ul></dd>');
        }
        write('');
        if (mixin.hasPublicSuperChainReversed) {
          write('        <dt>Inheritance</dt>');
          write('        <dd><ul class="gt-separated dark mixin-relationships">');
          write('          <li>${mixin.linkedObjectType}</li>');
          for (var item in mixin.publicSuperChainReversed) {
            write('          <li>${item.linkedName}</li>');
          }
          write('          <li>${mixin.name}</li>');
          write('        </ul></dd>');
        }
        write('');
        if (mixin.hasPublicInterfaces) {
          write('        <dt>Implements</dt>');
          write('        <dd>');
          write('          <ul class="comma-separated mixin-relationships">');
          for (var item in mixin.publicInterfaces) {
            write('            <li>${item.linkedName}</li>');
          }
          write('          </ul>');
          write('        </dd>');
        }
        write('');
        if (mixin.hasPublicMixins) {
          write('        <dt>Mixes-in</dt>');
          write('        <dd><ul class="comma-separated mixin-relationships">');
          for (var item in mixin.publicMixins) {
            write('          <li>${item.linkedName}</li>');
          }
          write('        </ul></dd>');
        }
        write('');
        if (mixin.hasPublicImplementors) {
          write('        <dt>Implemented by</dt>');
          write('        <dd><ul class="comma-separated mixin-relationships">');
          for (var item in mixin.publicImplementors) {
            write('          <li>${item.linkedName}</li>');
          }
          write('        </ul></dd>');
        }
        write('');
        if (mixin.hasAnnotations) {
          write('        <dt>Annotations</dt>');
          write('        <dd><ul class="annotation-list mixin-relationships">');
          for (var item in mixin.annotations) {
            write('          <li>$item</li>');
          }
          write('        </ul></dd>');
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (mixin.hasPublicConstructors) {
        write('    <section class="summary offset-anchor" id="constructors">');
        write('      <h2>Constructors</h2>');
        write('');
        write('      <dl class="constructor-summary-list">');
        for (var item in mixin.publicConstructors) {
          write('        <dt id="${escape(item.htmlId)}" class="callable">');
          write('          <span class="name">${item.linkedName}</span><span class="signature">(${item.linkedParams})</span>');
          write('        </dt>');
          write('        <dd>');
          write('          ${item.oneLineDoc} ${item.extendedDocLink}');
          if (item.isConst) {
            write('          <div class="constructor-modifier features">const</div>');
          }
          if (item.isFactory) {
            write('          <div class="constructor-modifier features">factory</div>');
          }
          write('        </dd>');
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (mixin.hasPublicInstanceFields) {
        write('    <section class="summary offset-anchor{{ #publicInheritedInstanceFields }} inherited{{ /publicInheritedInstanceFields }}" id="instance-properties">');
        write('      <h2>Properties</h2>');
        write('');
        write('      <dl class="properties">');
        for (var item in mixin.publicInstanceFields) {
          _includeProperty(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (mixin.hasPublicInstanceMethods) {
        write('    <section class="summary offset-anchor{{ #publicInheritedInstanceMethods }} inherited{{ /publicInheritedInstanceMethods }}" id="instance-methods">');
        write('      <h2>Methods</h2>');
        write('      <dl class="callables">');
        for (var item in mixin.publicInstanceMethods) {
          _includeCallable(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (mixin.hasPublicInstanceOperators) {
        write('    <section class="summary offset-anchor{{ #publicInheritedInstanceOperators }} inherited{{ /publicInheritedInstanceOperators}}" id="operators">');
        write('      <h2>Operators</h2>');
        write('      <dl class="callables">');
        for (var item in mixin.publicInstanceOperatorsSorted) {
          _includeCallable(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (mixin.hasPublicVariableStaticFields) {
        write('    <section class="summary offset-anchor" id="static-properties">');
        write('      <h2>Static Properties</h2>');
        write('');
        write('      <dl class="properties">');
        for (var item in mixin.publicVariableStaticFieldsSorted) {
          _includeProperty(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (mixin.hasPublicStaticMethods) {
        write('    <section class="summary offset-anchor" id="static-methods">');
        write('      <h2>Static Methods</h2>');
        write('      <dl class="callables">');
        for (var item in mixin.publicStaticMethods) {
          _includeCallable(item);
        }
        write('      </dl>');
        write('    </section>');
      }
      write('');
      if (mixin.hasPublicConstantFields) {
        write('    <section class="summary offset-anchor" id="constants">');
        write('      <h2>Constants</h2>');
        write('');
        write('      <dl class="properties">');
        for (var item in mixin.publicConstantFieldsSorted) {
          _includeConstant(item);
        }
        write('      </dl>');
        write('    </section>');
      }
    }
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    _includeSidebarForClass(ref);
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    _includeFooter(ref);
  }

  void generateProperty(PropertyTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5>${escape(ref.parent.name)} ${escape(ref.parent.kind)}</h5>');
    _includeSidebarForContainer(ref);
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <div>${_inlineSourceLink(self)}<h1><span class="kind-property">${escape(self.name)}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)}</h1></div>');
    }
    write('');
    {
      var self = ref.self;
      if (self.hasNoGetterSetter) {
        write('        <section class="multi-line-signature">');
        write('          <span class="returntype">${self.linkedReturnType}</span>');
        _includeNameSummary(self);
        _includeFeatures(self);
        write('        </section>');
        _includeDocumentation(self);
        _includeSourceCode(self);
      }
      write('');
      if (self.hasGetterOrSetter) {
        if (self.hasGetter) {
          _includeAccessorGetter(self);
        }
        write('');
        if (self.hasSetter) {
          _includeAccessorSetter(self);
        }
      }
    }
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    _includeFooter(ref);
  }

  void generateTopLevelConstant(TopLevelPropertyTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5>${escape(ref.parent.name)} ${escape(ref.parent.kind)}</h5>');
    _includeSidebarForLibrary(ref);
    write('  </div><!--/.sidebar-offcanvas-left-->');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <div>${_inlineSourceLink(self)}<h1><span class="kind-top-level-constant">${self.name}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)} ${_inlineCategorization(self)}</h1></div>');
      write('');
      write('      <section class="multi-line-signature">');
      _includeNameSummary(self);
      write('        =');
      write('        <span class="constant-value">${self.constantValue}</span>');
      _includeFeatures(self);
      write('      </section>');
      _includeDocumentation(self);
      _includeSourceCode(self);
    }
    write('');
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    _includeFooter(ref);
  }

  void generateTopLevelProperty(TopLevelPropertyTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5>${escape(ref.parent.name)} ${escape(ref.parent.kind)}</h5>');
    _includeSidebarForLibrary(ref);
    write('  </div><!--/.sidebar-offcanvas-left-->');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <div>${_inlineSourceLink(self)}<h1><span class="kind-top-level-property">${self.name}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)} ${_inlineCategorization(self)}</h1></div>');
      write('');
      if (self.hasNoGetterSetter) {
        write('        <section class="multi-line-signature">');
        write('          <span class="returntype">${self.linkedReturnType}</span>');
        _includeNameSummary(self);
        _includeFeatures(self);
        write('        </section>');
        _includeDocumentation(self);
        _includeSourceCode(self);
      }
      write('');
      if (self.hasExplicitGetter) {
        _includeAccessorGetter(self);
      }
      write('');
      if (self.hasExplicitSetter) {
        _includeAccessorSetter(self);
      }
    }
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    _includeFooter(ref);
  }

  void generateTypedef(TypedefTemplateData ref) {
    _includeHead(ref);
    write('');
    write('  <div id="dartdoc-sidebar-left" class="col-xs-6 col-sm-3 col-md-2 sidebar sidebar-offcanvas-left">');
    _includeSearchSidebar(ref);
    write('    <h5>${escape(ref.parent.name)} ${escape(ref.parent.kind)}</h5>');
    _includeSidebarForLibrary(ref);
    write('  </div><!--/.sidebar-offcanvas-left-->');
    write('');
    write('  <div id="dartdoc-main-content" class="col-xs-12 col-sm-9 col-md-8 main-content">');
    {
      var self = ref.self;
      write('      <div>${_inlineSourceLink(self)}<h1><span class="kind-typedef">${self.nameWithGenerics}</span> ${escape(self.kind)} ${_inlineFeatureSet(self)} ${_inlineCategorization(self)}</h1></div>');
    }
    write('');
    write('    <section class="multi-line-signature">');
    {
      var typeDef = ref.typeDef;
      _includeCallableMultiline(typeDef);
    }
    write('    </section>');
    write('');
    {
      var typeDef = ref.typeDef;
      _includeDocumentation(typeDef);
      _includeSourceCode(typeDef);
    }
    write('');
    write('  </div> <!-- /.main-content -->');
    write('');
    write('  <div id="dartdoc-sidebar-right" class="col-xs-6 col-sm-6 col-md-2 sidebar sidebar-offcanvas-right">');
    write('  </div><!--/.sidebar-offcanvas-->');
    write('');
    _includeFooter(ref);
  }

  String _inlineAccessorGetter(GetterSetterCombo ref) {
    pushBuffer();
    _includeAccessorGetter(ref);
    return popBuffer();
  }

  void _includeAccessorGetter(GetterSetterCombo ref) {
    {
      var getter = ref.getter;
      write('<section id="getter">');
      write('');
      write('<section class="multi-line-signature">');
      write('  <span class="returntype">${getter.linkedReturnType}</span>');
      _includeNameSummary(getter);
      _includeFeatures(getter);
      write('</section>');
      write('');
      _includeDocumentation(getter);
      _includeSourceCode(getter);
      write('</section>');
    }
  }

  String _inlineAccessorSetter(GetterSetterCombo ref) {
    pushBuffer();
    _includeAccessorSetter(ref);
    return popBuffer();
  }

  void _includeAccessorSetter(GetterSetterCombo ref) {
    {
      var setter = ref.setter;
      write('<section id="setter">');
      write('');
      write('<section class="multi-line-signature">');
      write('  <span class="returntype">void</span>');
      write('  ${_inlineNameSummary(setter)}<span class="signature">(<wbr>${setter.linkedParamsNoMetadata})</span>');
      _includeFeatures(setter);
      write('</section>');
      write('');
      _includeDocumentation(setter);
      _includeSourceCode(setter);
      write('</section>');
    }
  }

  String _inlineCallable(ModelElement ref) {
    pushBuffer();
    _includeCallable(ref);
    return popBuffer();
  }

  void _includeCallable(ModelElement ref) {
    write('<dt id="${escape(ref.htmlId)}" class="callable{{ #isInherited }} inherited{{ /isInherited}}">');
    write('  <span class="name{{#isDeprecated}} deprecated{{/isDeprecated}}">${ref.linkedName}</span>${ref.linkedGenericParameters}<span class="signature">(<wbr>${ref.linkedParamsNoMetadata})');
    write('    <span class="returntype parameter">&#8594; ${ref.linkedReturnType}</span>');
    write('  </span>');
    _includeCategorization(ref);
    write('</dt>');
    write('<dd{{ #isInherited }} class="inherited"{{ /isInherited}}>');
    write('  ${ref.oneLineDoc} ${ref.extendedDocLink}');
    _includeFeatures(ref);
    write('</dd>');
  }

  String _inlineCallableMultiline(ModelElement ref) {
    pushBuffer();
    _includeCallableMultiline(ref);
    return popBuffer();
  }

  void _includeCallableMultiline(ModelElement ref) {
    if (ref.hasAnnotations) {
      write('<div>');
      write('  <ol class="annotation-list">');
      for (var item in ref.annotations) {
        write('    <li>$item</li>');
      }
      write('  </ol>');
      write('</div>');
    }
    write('<span class="returntype">${ref.linkedReturnType}</span>');
    write('${_inlineNameSummary(ref)}${ref.genericParameters}(<wbr>{{#hasParameters}}${ref.linkedParamsLines}{{/hasParameters}})');
  }

  String _inlineCategorization(Categorization ref) {
    pushBuffer();
    _includeCategorization(ref);
    return popBuffer();
  }

  void _includeCategorization(Categorization ref) {
    if (ref.hasCategoryNames) {
      for (var item in ref.displayedCategories) {
        write('    ${item.categoryLabel}');
      }
    }
  }

  String _inlineClass(ModelElement ref) {
    pushBuffer();
    _includeClass(ref);
    return popBuffer();
  }

  void _includeClass(ModelElement ref) {
    write('<dt id="${escape(ref.htmlId)}">');
    write('  <span class="name {{#isDeprecated}}deprecated{{/isDeprecated}}">${ref.linkedName}${ref.linkedGenericParameters}</span> ${_inlineCategorization(ref)}');
    write('</dt>');
    write('<dd>');
    write('  ${ref.oneLineDoc} ${ref.extendedDocLink}');
    write('</dd>');
  }

  String _inlineConstant(GetterSetterCombo ref) {
    pushBuffer();
    _includeConstant(ref);
    return popBuffer();
  }

  void _includeConstant(GetterSetterCombo ref) {
    write('<dt id="${escape(ref.htmlId)}" class="constant">');
    write('  <span class="name {{#isDeprecated}}deprecated{{/isDeprecated}}">${ref.linkedName}</span>');
    write('  <span class="signature">&#8594; const ${ref.linkedReturnType}</span>');
    _includeCategorization(ref);
    write('</dt>');
    write('<dd>');
    write('  ${ref.oneLineDoc} ${ref.extendedDocLink}');
    _includeFeatures(ref);
    write('  <div>');
    write('    <span class="signature"><code>${ref.constantValueTruncated}</code></span>');
    write('  </div>');
    write('</dd>');
  }

  String _inlineDocumentation(Documentable ref) {
    pushBuffer();
    _includeDocumentation(ref);
    return popBuffer();
  }

  void _includeDocumentation(Documentable ref) {
    if (ref.hasDocumentation) {
      write('<section class="desc markdown">');
      write('  ${ref.documentationAsHtml}');
      write('</section>');
    }
  }

  String _inlineExtension(ModelElement ref) {
    pushBuffer();
    _includeExtension(ref);
    return popBuffer();
  }

  void _includeExtension(ModelElement ref) {
    write('<dt id="${escape(ref.htmlId)}">');
    write('    <span class="name {{#isDeprecated}}deprecated{{/isDeprecated}}">${ref.linkedName}</span> ${_inlineCategorization(ref)}');
    write('</dt>');
    write('<dd>');
    write('    ${ref.oneLineDoc} ${ref.extendedDocLink}');
    write('</dd>');
    write('');
  }

  String _inlineFeatureSet(ModelElement ref) {
    pushBuffer();
    _includeFeatureSet(ref);
    return popBuffer();
  }

  void _includeFeatureSet(ModelElement ref) {
    if (ref.hasFeatureSet) {
      for (var item in ref.displayedLanguageFeatures) {
        write('    ${item.featureLabel}');
      }
    }
  }

  String _inlineFeatures(ModelElement ref) {
    pushBuffer();
    _includeFeatures(ref);
    return popBuffer();
  }

  void _includeFeatures(ModelElement ref) {
    write('{{ #featuresAsString.isNotEmpty }}<div class="features">${ref.featuresAsString}</div>{{ /featuresAsString.isNotEmpty }}');
  }

  String _inlineFooter(TemplateData ref) {
    pushBuffer();
    _includeFooter(ref);
    return popBuffer();
  }

  void _includeFooter(TemplateData ref) {
    write('</main>');
    write('');
    write('<footer>');
    write('  <span class="no-break">');
    write('    ${escape(ref.packageGraph.defaultPackage.name)}');
    if (ref.packageGraph.hasFooterVersion) {
      write('      ${escape(ref.packageGraph.defaultPackage.version)}');
    }
    write('  </span>');
    write('');
    write('  {{! footer-text placeholder }}');
    write('</footer>');
    write('');
    write('{{! TODO(jdkoren): unwrap ^useBaseHref sections when the option is removed.}}');
    write('<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>');
    write('<script src="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/typeahead.bundle.min.js"></script>');
    write('<script src="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/highlight.pack.js"></script>');
    write('<script src="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/URI.js"></script>');
    write('<script src="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/script.js"></script>');
    write('');
    write('{{! footer placeholder }}');
    write('');
    write('</body>');
    write('');
    write('</html>');
  }

  String _inlineHead(TemplateData ref) {
    pushBuffer();
    _includeHead(ref);
    return popBuffer();
  }

  void _includeHead(TemplateData ref) {
    write('<!DOCTYPE html>');
    write('<html lang="en">');
    write('<head>');
    write('  <meta charset="utf-8">');
    write('  <meta http-equiv="X-UA-Compatible" content="IE=edge">');
    write('  <meta name="viewport" content="width=device-width, height=device-height, initial-scale=1, user-scalable=no">');
    if (ref.includeVersion) {
      write('  <meta name="generator" content="made with love by dartdoc ${escape(ref.version)}">');
    }
    write('  <meta name="description" content="${escape(ref.metaDescription)}">');
    write('  <title>${escape(ref.title)}</title>');
    write('  {{ #relCanonicalPrefix }}');
    write('  <link rel="canonical" href="${ref.relCanonicalPrefix}/${ref.bareHref}">');
    write('  {{ /relCanonicalPrefix}}');
    write('');
    if (ref.useBaseHref) {
      write('  {{! TODO(jdkoren): remove when the useBaseHref option is removed.}}');
      write('  <!-- required because all the links are pseudo-absolute -->');
      write('  <base href="${ref.htmlBase}">');
    }
    write('');
    write('  {{! TODO(jdkoren): unwrap ^useBaseHref sections when the option is removed.}}');
    write('  <link href="https://fonts.googleapis.com/css?family=Source+Code+Pro:500,400i,400,300|Source+Sans+Pro:400,300,700" rel="stylesheet">');
    write('  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">');
    write('  <link rel="stylesheet" href="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/github.css">');
    write('  <link rel="stylesheet" href="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/styles.css">');
    write('  <link rel="icon" href="{{^useBaseHref}}%%__HTMLBASE_dartdoc_internal__%%{{/useBaseHref}}static-assets/favicon.png">');
    write('');
    write('  {{! header placeholder }}');
    write('</head>');
    write('');
    write('{{! We don\'t use <base href>, but we do lookup the htmlBase from javascript. }}');
    write('<body data-base-href="${ref.htmlBase}"');
    write('      data-using-base-href="${ref.useBaseHref}">');
    write('');
    write('<div id="overlay-under-drawer"></div>');
    write('');
    write('<header id="title">');
    write('  <button id="sidenav-left-toggle" type="button">&nbsp;</button>');
    write('  <ol class="breadcrumbs gt-separated dark hidden-xs">');
    for (var item in ref.navLinks) {
      write('    <li><a href="${item.href}">${escape(item.name)}</a></li>');
    }
    for (var item in ref.navLinksWithGenerics) {
      write('    <li><a href="${item.href}">${escape(item.name)}{{#hasGenericParameters}}<span class="signature">${item.genericParameters}</span>{{/hasGenericParameters}}</a></li>');
    }
    if (!ref.hasHomepage) {
      write('    <li class="self-crumb">${ref.layoutTitle}</li>');
    }
    if (ref.hasHomepage) {
      write('    <li><a href="${ref.homepage}">${ref.layoutTitle}</a></li>');
    }
    write('  </ol>');
    write('  <div class="self-name">${escape(ref.self.name)}</div>');
    write('  <form class="search navbar-right" role="search">');
    write('    <input type="text" id="search-box" autocomplete="off" disabled class="form-control typeahead" placeholder="Loading search...">');
    write('  </form>');
    write('</header>');
    write('');
    write('<main>');
  }

  String _inlineLibrary(ModelElement ref) {
    pushBuffer();
    _includeLibrary(ref);
    return popBuffer();
  }

  void _includeLibrary(ModelElement ref) {
    write('<dt id="${escape(ref.htmlId)}">');
    write('  <span class="name">${ref.linkedName}</span> ${_inlineCategorization(ref)}');
    write('</dt>');
    write('<dd>');
    write('  {{#isDocumented}}${ref.oneLineDoc} ${ref.extendedDocLink}{{/isDocumented}}');
    write('</dd>');
  }

  String _inlineMixin(ModelElement ref) {
    pushBuffer();
    _includeMixin(ref);
    return popBuffer();
  }

  void _includeMixin(ModelElement ref) {
    write('<dt id="${escape(ref.htmlId)}">');
    write('  <span class="name {{#isDeprecated}}deprecated{{/isDeprecated}}">${ref.linkedName}${ref.linkedGenericParameters}</span> ${_inlineCategorization(ref)}');
    write('</dt>');
    write('<dd>');
    write('  ${ref.oneLineDoc} ${ref.extendedDocLink}');
    write('</dd>');
  }

  String _inlineNameSummary(ModelElement ref) {
    pushBuffer();
    _includeNameSummary(ref);
    return popBuffer();
  }

  void _includeNameSummary(ModelElement ref) {
    write('{{#isConst}}const {{/isConst}}<span class="name {{#isDeprecated}}deprecated{{/isDeprecated}}">${escape(ref.name)}</span>');
  }

  String _inlinePackages(TemplateData ref) {
    pushBuffer();
    _includePackages(ref);
    return popBuffer();
  }

  void _includePackages(TemplateData ref) {
    write('<ol>');
    for (var item in ref.packageGraph.localPackages) {
      if (item.isFirstPackage) {
        if (item.hasDocumentedCategories) {
          write('      <li class="section-title">Topics</li>');
          for (var item in item.documentedCategories) {
            write('        <li>${item.linkedName}</li>');
          }
        }
        write('      <li class="section-title">Libraries</li>');
      }
      if (!item.isFirstPackage) {
        write('      <li class="section-title">${escape(item.name)}</li>');
      }
      for (var item in item.defaultCategory.publicLibraries) {
        write('      <li>${item.linkedName}</li>');
      }
      for (var item in item.categoriesWithPublicLibraries) {
        write('      <li class="section-subtitle">${escape(item.name)}</li>');
        for (var item in item.publicLibraries) {
          write('        <li class="section-subitem">${item.linkedName}</li>');
        }
      }
    }
    write('</ol>');
  }

  String _inlineProperty(GetterSetterCombo ref) {
    pushBuffer();
    _includeProperty(ref);
    return popBuffer();
  }

  void _includeProperty(GetterSetterCombo ref) {
    write('<dt id="${escape(ref.htmlId)}" class="property{{ #isInherited }} inherited{{ /isInherited}}">');
    write('  <span class="name">${ref.linkedName}</span>');
    write('  <span class="signature">${ref.arrow} ${ref.linkedReturnType}</span> ${_inlineCategorization(ref)}');
    write('</dt>');
    write('<dd{{ #isInherited }} class="inherited"{{ /isInherited}}>');
    write('  ${ref.oneLineDoc} ${ref.extendedDocLink}');
    _includeFeatures(ref);
    write('</dd>');
  }

  String _inlineSearchSidebar(TemplateData ref) {
    pushBuffer();
    _includeSearchSidebar(ref);
    return popBuffer();
  }

  void _includeSearchSidebar(TemplateData ref) {
    write('<header id="header-search-sidebar" class="hidden-l">');
    write('  <form class="search-sidebar" role="search">');
    write('    <input type="text" id="search-sidebar" autocomplete="off" disabled class="form-control typeahead" placeholder="Loading search...">');
    write('  </form>');
    write('</header>');
    write('');
    write('<ol class="breadcrumbs gt-separated dark hidden-l" id="sidebar-nav">');
    for (var item in ref.navLinks) {
      write('  <li><a href="${item.href}">${escape(item.name)}</a></li>');
    }
    for (var item in ref.navLinksWithGenerics) {
      write('  <li><a href="${item.href}">${escape(item.name)}{{#hasGenericParameters}}<span class="signature">${item.genericParameters}</span>{{/hasGenericParameters}}</a></li>');
    }
    if (!ref.hasHomepage) {
      write('  <li class="self-crumb">${ref.layoutTitle}</li>');
    }
    if (ref.hasHomepage) {
      write('  <li><a href="${ref.homepage}">${ref.layoutTitle}</a></li>');
    }
    write('</ol>');
    write('');
  }

  String _inlineSidebarForCategory(CategoryTemplateData ref) {
    pushBuffer();
    _includeSidebarForCategory(ref);
    return popBuffer();
  }

  void _includeSidebarForCategory(CategoryTemplateData ref) {
    write('<ol>');
    if (ref.self.hasPublicLibraries) {
      write('  <li class="section-title"><a href="${ref.self.href}#libraries">Libraries</a></li>');
      for (var item in ref.self.publicLibraries) {
        write('  <li>${item.linkedName}</li>');
      }
    }
    write('');
    if (ref.self.hasPublicMixins) {
      write('  <li class="section-title"><a href="${ref.library.href}#mixins">Mixins</a></li>');
      for (var item in ref.self.publicMixins) {
        write('  <li>${item.linkedName}</li>');
      }
    }
    write('');
    if (ref.self.hasPublicClasses) {
      write('  <li class="section-title"><a href="${ref.self.href}#classes">Classes</a></li>');
      for (var item in ref.self.publicClasses) {
        write('  <li>${item.linkedName}</li>');
      }
    }
    write('');
    if (ref.self.hasPublicConstants) {
      write('  <li class="section-title"><a href="${ref.self.href}#constants">Constants</a></li>');
      for (var item in ref.self.publicConstants) {
        write('  <li>${item.linkedName}</li>');
      }
    }
    write('');
    if (ref.self.hasPublicProperties) {
      write('  <li class="section-title"><a href="${ref.self.href}#properties">Properties</a></li>');
      for (var item in ref.self.publicProperties) {
        write('  <li>${item.linkedName}</li>');
      }
    }
    write('');
    if (ref.self.hasPublicFunctions) {
      write('  <li class="section-title"><a href="${ref.self.href}#functions">Functions</a></li>');
      for (var item in ref.self.publicFunctions) {
        write('  <li>${item.linkedName}</li>');
      }
    }
    write('');
    if (ref.self.hasPublicEnums) {
      write('  <li class="section-title"><a href="${ref.self.href}#enums">Enums</a></li>');
      for (var item in ref.self.publicEnums) {
        write('  <li>${item.linkedName}</li>');
      }
    }
    write('');
    if (ref.self.hasPublicTypedefs) {
      write('  <li class="section-title"><a href="${ref.self.href}#typedefs">Typedefs</a></li>');
      for (var item in ref.self.publicTypedefs) {
        write('  <li>${item.linkedName}</li>');
      }
    }
    write('');
    if (ref.self.hasPublicExceptions) {
      write('  <li class="section-title"><a href="${ref.self.href}#exceptions">Exceptions</a></li>');
      for (var item in ref.self.publicExceptions) {
        write('  <li>${item.linkedName}</li>');
      }
    }
    write('</ol>');
  }

  String _inlineSidebarForClass(ClassTemplateData ref) {
    pushBuffer();
    _includeSidebarForClass(ref);
    return popBuffer();
  }

  void _includeSidebarForClass(ClassTemplateData ref) {
    write('<ol>');
    {
      var clazz = ref.clazz;
      write('');
      if (clazz.hasPublicConstructors) {
        write('  <li class="section-title"><a href="${clazz.href}#constructors">Constructors</a></li>');
        for (var item in clazz.publicConstructorsSorted) {
          write('  <li><a{{#isDeprecated}} class="deprecated"{{/isDeprecated}} href="${item.href}">${escape(item.shortName)}</a></li>');
        }
      }
      write('');
      if (clazz.hasPublicInstanceFields) {
        write('  <li class="section-title{{ #publicInheritedInstanceFields }} inherited{{ /publicInheritedInstanceFields }}">');
        write('    <a href="${clazz.href}#instance-properties">Properties</a>');
        write('  </li>');
        for (var item in clazz.publicInstanceFieldsSorted) {
          write('  <li{{ #isInherited }} class="inherited"{{ /isInherited}}>${item.linkedName}</li>');
        }
      }
      write('');
      if (clazz.hasPublicInstanceMethods) {
        write('  <li class="section-title{{ #publicInheritedInstanceMethods }} inherited{{ /publicInheritedInstanceMethods }}"><a href="${clazz.href}#instance-methods">Methods</a></li>');
        for (var item in clazz.publicInstanceMethodsSorted) {
          write('  <li{{ #isInherited }} class="inherited"{{ /isInherited}}>${item.linkedName}</li>');
        }
      }
      write('');
      if (clazz.hasPublicInstanceOperators) {
        write('  <li class="section-title{{ #publicInheritedInstanceOperators }} inherited{{ /publicInheritedInstanceOperators}}"><a href="${clazz.href}#operators">Operators</a></li>');
        for (var item in clazz.publicInstanceOperatorsSorted) {
          write('  <li{{ #isInherited }} class="inherited"{{ /isInherited}}>${item.linkedName}</li>');
        }
      }
      write('');
      if (clazz.hasPublicVariableStaticFields) {
        write('  <li class="section-title"><a href="${clazz.href}#static-properties">Static properties</a></li>');
        for (var item in clazz.publicVariableStaticFieldsSorted) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (clazz.hasPublicStaticMethods) {
        write('  <li class="section-title"><a href="${clazz.href}#static-methods">Static methods</a></li>');
        for (var item in clazz.publicStaticMethodsSorted) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (clazz.hasPublicConstantFields) {
        write('  <li class="section-title"><a href="${clazz.href}#constants">Constants</a></li>');
        for (var item in clazz.publicConstantFieldsSorted) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
    }
    write('</ol>');
  }

  String _inlineSidebarForContainer(MemberTemplateData ref) {
    pushBuffer();
    _includeSidebarForContainer(ref);
    return popBuffer();
  }

  void _includeSidebarForContainer(MemberTemplateData ref) {
    write('<ol>');
    if (ref.container.isClass) {
      {
        // ref.container.asClass
        write('');
        if (ref.container.asClass.hasPublicConstructors) {
          write('    <li class="section-title"><a href="${ref.container.asClass.href}#constructors">Constructors</a></li>');
          for (var item in ref.container.asClass.publicConstructorsSorted) {
            write('    <li><a{{#isDeprecated}} class="deprecated"{{/isDeprecated}} href="${item.href}">${escape(item.shortName)}</a></li>');
          }
        }
        write('');
        if (ref.container.asClass.hasPublicInstanceFields) {
          write('    <li class="section-title{{ #publicInheritedInstanceFields }} inherited{{ /publicInheritedInstanceFields }}">');
          write('        <a href="${ref.container.asClass.href}#instance-properties">Properties</a>');
          write('    </li>');
          for (var item in ref.container.asClass.publicInstanceFieldsSorted) {
            write('    <li{{ #isInherited }} class="inherited"{{ /isInherited}}>${item.linkedName}</li>');
          }
        }
        write('');
        if (ref.container.asClass.hasPublicInstanceMethods) {
          write('    <li class="section-title{{ #publicInheritedInstanceMethods }} inherited{{ /publicInheritedInstanceMethods }}"><a href="${ref.container.asClass.href}#instance-methods">Methods</a></li>');
          for (var item in ref.container.asClass.publicInstanceMethodsSorted) {
            write('    <li{{ #isInherited }} class="inherited"{{ /isInherited}}>${item.linkedName}</li>');
          }
        }
        write('');
        if (ref.container.asClass.hasPublicInstanceOperators) {
          write('    <li class="section-title{{ #publicInheritedInstanceOperators }} inherited{{ /publicInheritedInstanceOperators}}"><a href="${ref.container.asClass.href}#operators">Operators</a></li>');
          for (var item in ref.container.asClass.publicInstanceOperatorsSorted) {
            write('    <li{{ #isInherited }} class="inherited"{{ /isInherited}}>${item.linkedName}</li>');
          }
        }
        write('');
        if (ref.container.asClass.hasPublicVariableStaticFields) {
          write('    <li class="section-title"><a href="${ref.container.asClass.href}#static-properties">Static properties</a></li>');
          for (var item in ref.container.asClass.publicVariableStaticFieldsSorted) {
            write('    <li>${item.linkedName}</li>');
          }
        }
        write('');
        if (ref.container.asClass.hasPublicStaticMethods) {
          write('    <li class="section-title"><a href="${ref.container.asClass.href}#static-methods">Static methods</a></li>');
          for (var item in ref.container.asClass.publicStaticMethodsSorted) {
            write('    <li>${item.linkedName}</li>');
          }
        }
        write('');
        if (ref.container.asClass.hasPublicConstantFields) {
          write('    <li class="section-title"><a href="${ref.container.asClass.href}#constants">Constants</a></li>');
          for (var item in ref.container.asClass.publicConstantFieldsSorted) {
            write('    <li>${item.linkedName}</li>');
          }
        }
        write('');
      }
    }
    write('');
    if (ref.container.isExtension) {
      {
        // ref.container.asExtension
        write('');
        if (ref.container.asExtension.hasPublicInstanceFields) {
          write('    <li class="section-title"> <a href="${ref.container.asExtension.href}#instance-properties">Properties</a>');
          write('    </li>');
          for (var item in ref.container.asExtension.publicInstanceFieldsSorted) {
            write('    <li>${item.linkedName}</li>');
          }
        }
        write('');
        if (ref.container.asExtension.hasPublicInstanceMethods) {
          write('    <li class="section-title"><a href="${ref.container.asExtension.href}#instance-methods">Methods</a></li>');
          for (var item in ref.container.asExtension.publicInstanceMethodsSorted) {
            write('    <li>${item.linkedName}</li>');
          }
        }
        write('');
        if (ref.container.asExtension.hasPublicInstanceOperators) {
          write('    <li class="section-title"><a href="${ref.container.asExtension.href}#operators">Operators</a></li>');
          for (var item in ref.container.asExtension.publicInstanceOperatorsSorted) {
            write('    <li>${item.linkedName}</li>');
          }
        }
        write('');
        if (ref.container.asExtension.hasPublicVariableStaticFields) {
          write('    <li class="section-title"><a href="${ref.container.asExtension.href}#static-properties">Static properties</a></li>');
          for (var item in ref.container.asExtension.publicVariableStaticFieldsSorted) {
            write('    <li>${item.linkedName}</li>');
          }
        }
        write('');
        if (ref.container.asExtension.hasPublicStaticMethods) {
          write('    <li class="section-title"><a href="${ref.container.asExtension.href}#static-methods">Static methods</a></li>');
          for (var item in ref.container.asExtension.publicStaticMethodsSorted) {
            write('    <li>${item.linkedName}</li>');
          }
        }
        write('');
        if (ref.container.asExtension.hasPublicConstantFields) {
          write('    <li class="section-title"><a href="${ref.container.asExtension.href}#constants">Constants</a></li>');
          for (var item in ref.container.asExtension.publicConstantFieldsSorted) {
            write('    <li>${item.linkedName}</li>');
          }
        }
        write('');
      }
    }
    write('</ol>');
  }

  String _inlineSidebarForEnum(EnumTemplateData ref) {
    pushBuffer();
    _includeSidebarForEnum(ref);
    return popBuffer();
  }

  void _includeSidebarForEnum(EnumTemplateData ref) {
    write('<ol>');
    {
      var eNum = ref.eNum;
      if (eNum.hasPublicConstantFields) {
        write('  <li class="section-title"><a href="${eNum.href}#constants">Constants</a></li>');
        for (var item in eNum.publicConstantFieldsSorted) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (eNum.hasPublicConstructors) {
        write('  <li class="section-title"><a href="${eNum.href}#constructors">Constructors</a></li>');
        for (var item in eNum.publicConstructorsSorted) {
          write('  <li><a{{#isDeprecated}} class="deprecated"{{/isDeprecated}} href="${item.href}">${escape(item.shortName)}</a></li>');
        }
      }
      write('');
      if (eNum.hasPublicInstanceFields) {
        write('  <li class="section-title{{ #publicInheritedInstanceFields }} inherited{{ /publicInheritedInstanceFields }}">');
        write('    <a href="${eNum.href}#instance-properties">Properties</a>');
        write('  </li>');
        for (var item in eNum.publicInstanceFieldsSorted) {
          write('  <li{{ #isInherited }} class="inherited"{{ /isInherited}}>${item.linkedName}</li>');
        }
      }
      write('');
      if (eNum.hasPublicInstanceMethods) {
        write('  <li class="section-title{{ #publicInheritedInstanceMethods }} inherited{{ /publicInheritedInstanceMethods }}"><a href="${eNum.href}#instance-methods">Methods</a></li>');
        for (var item in eNum.publicInstanceMethodsSorted) {
          write('  <li{{ #isInherited }} class="inherited"{{ /isInherited}}>${item.linkedName}</li>');
        }
      }
      write('');
      if (eNum.hasPublicInstanceOperators) {
        write('  <li class="section-title{{ #publicInheritedInstanceOperators }} inherited{{ /publicInheritedInstanceOperators}}"><a href="${eNum.href}#operators">Operators</a></li>');
        for (var item in eNum.publicInstanceOperatorsSorted) {
          write('  <li{{ #isInherited }} class="inherited"{{ /isInherited}}>${item.linkedName}</li>');
        }
      }
      write('');
      if (eNum.hasPublicVariableStaticFields) {
        write('  <li class="section-title"><a href="${eNum.href}#static-properties">Static properties</a></li>');
        for (var item in eNum.publicVariableStaticFieldsSorted) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (eNum.hasPublicStaticMethods) {
        write('  <li class="section-title"><a href="${eNum.href}#static-methods">Static methods</a></li>');
        for (var item in eNum.publicStaticMethodsSorted) {
          write('  <li>${item.linkedName}</li>');
        }
      }
    }
    write('</ol>');
  }

  String _inlineSidebarForExtension(ExtensionTemplateData ref) {
    pushBuffer();
    _includeSidebarForExtension(ref);
    return popBuffer();
  }

  void _includeSidebarForExtension(ExtensionTemplateData ref) {
    write('<ol>');
    {
      var extension = ref.extension;
      write('');
      if (extension.hasPublicInstanceFields) {
        write('    <li class="section-title"> <a href="${extension.href}#instance-properties">Properties</a>');
        write('    </li>');
        for (var item in extension.publicInstanceFieldsSorted) {
          write('    <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (extension.hasPublicInstanceMethods) {
        write('    <li class="section-title"><a href="${extension.href}#instance-methods">Methods</a></li>');
        for (var item in extension.publicInstanceMethodsSorted) {
          write('    <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (extension.hasPublicInstanceOperators) {
        write('    <li class="section-title"><a href="${extension.href}#operators">Operators</a></li>');
        for (var item in extension.publicInstanceOperatorsSorted) {
          write('    <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (extension.hasPublicVariableStaticFields) {
        write('    <li class="section-title"><a href="${extension.href}#static-properties">Static properties</a></li>');
        for (var item in extension.publicVariableStaticFieldsSorted) {
          write('    <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (extension.hasPublicStaticMethods) {
        write('    <li class="section-title"><a href="${extension.href}#static-methods">Static methods</a></li>');
        for (var item in extension.publicStaticMethodsSorted) {
          write('    <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (extension.hasPublicConstantFields) {
        write('    <li class="section-title"><a href="${extension.href}#constants">Constants</a></li>');
        for (var item in extension.publicConstantFieldsSorted) {
          write('    <li>${item.linkedName}</li>');
        }
      }
      write('');
    }
    write('</ol>');
  }

  String _inlineSidebarForLibrary(TemplateData ref) {
    pushBuffer();
    _includeSidebarForLibrary(ref);
    return popBuffer();
  }

  void _includeSidebarForLibrary(TemplateData ref) {
    write('<ol>');
    {
      var library = ref.library;
      if (library.hasPublicClasses) {
        write('  <li class="section-title"><a href="${library.href}#classes">Classes</a></li>');
        for (var item in library.publicClasses) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (library.hasPublicExtensions) {
        write('  <li class="section-title"><a href="${library.href}#extension">Extensions</a></li>');
        for (var item in library.publicExtensions) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (library.hasPublicMixins) {
        write('  <li class="section-title"><a href="${library.href}#mixins">Mixins</a></li>');
        for (var item in library.publicMixins) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (library.hasPublicConstants) {
        write('  <li class="section-title"><a href="${library.href}#constants">Constants</a></li>');
        for (var item in library.publicConstants) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (library.hasPublicProperties) {
        write('  <li class="section-title"><a href="${library.href}#properties">Properties</a></li>');
        for (var item in library.publicProperties) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (library.hasPublicFunctions) {
        write('  <li class="section-title"><a href="${library.href}#functions">Functions</a></li>');
        for (var item in library.publicFunctions) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (library.hasPublicEnums) {
        write('  <li class="section-title"><a href="${library.href}#enums">Enums</a></li>');
        for (var item in library.publicEnums) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (library.hasPublicTypedefs) {
        write('  <li class="section-title"><a href="${library.href}#typedefs">Typedefs</a></li>');
        for (var item in library.publicTypedefs) {
          write('  <li>${item.linkedName}</li>');
        }
      }
      write('');
      if (library.hasPublicExceptions) {
        write('  <li class="section-title"><a href="${library.href}#exceptions">Exceptions</a></li>');
        for (var item in library.publicExceptions) {
          write('  <li>${item.linkedName}</li>');
        }
      }
    }
    write('</ol>');
  }

  String _inlineSourceCode(ModelElement ref) {
    pushBuffer();
    _includeSourceCode(ref);
    return popBuffer();
  }

  void _includeSourceCode(ModelElement ref) {
    if (ref.hasSourceCode) {
      write('<section class="summary source-code" id="source">');
      write('  <h2><span>Implementation</span></h2>');
      write('  <pre class="language-dart"><code class="language-dart">${ref.sourceCode}</code></pre>');
      write('</section>');
    }
  }

  String _inlineSourceLink(ModelElement ref) {
    pushBuffer();
    _includeSourceLink(ref);
    return popBuffer();
  }

  void _includeSourceLink(ModelElement ref) {
    if (ref.hasSourceHref) {
      write('  <div id="external-links" class="btn-group"><a title="View source code" class="source-link" href="${ref.sourceHref}"><i class="material-icons">description</i></a></div>');
    }
  }
}
