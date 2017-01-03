{
  class DocumentWrapper {
    constructor (doc) {
      this.doc = doc;
    }

    addEventListener (event, callback) {
      $$(this.eventBus()).addEventListener(event, callback);
      return this;
    }

    dispatchEvent (event) {
      this.eventBus().dispatchEvent(event);
    }

    eventBus () {
      return this.doc.querySelector('body');
    }

    ready (fn) {
      if (document.readyState === 'complete' || document.readyState !== 'loading') {
        fn();
      } else {
        document.addEventListener('DOMContentLoaded', fn);
      }
    }
  }

  class ElementWrapper {
    constructor (el) {
      this.el = el;
    }

    addEventListener (event, callback) {
      event.split(' ').forEach(e => this.el.addEventListener(e, callback, false));
      return this;
    }

    findChild (selector) {
      if (this.el.matches(selector)) return this.el;

      for (var i = 0; i < this.el.children.length; i++) {
        var child = this.el.children[i];
        if (child.matches(selector)) return child;

        var matchingChild = new ElementWrapper(child).findChild(selector);
        if (matchingChild != undefined) return matchingChild;
      };
    }

    findParent (selector) {
      if (this.el.matches(selector)) return this.el;
      var parent = this.el.parentElement;
      while (parent) {
        if (parent.matches(selector)) return parent;
        parent = parent.parentElement;
      }
    }
  }

  class FileListWrapper {
    constructor (list) {
      this.list = list;
    }

    forEach (fn) {
      var length = this.list.length;
      for (var i = 0; i < length; i++) {
        var file = this.list[i];
        fn(file);
      }
    }
  }

  class NodeListWrapper {
    constructor (list) {
      this.list = list;
    }

    addEventListener (event, callback) {
      this.list.forEach(function(el) {
        event.split(' ').forEach(e => el.addEventListener(e, callback, false));
      });
      return this;
    }
  }

  class HTMLCollectionWrapper {
    constructor (list) {
      this.list = list;
    }

    forEach (fn) {
      var length = this.list.length;
      for (var i = 0; i < length; i++) {
        var el = this.list[i];
        fn(el);
      }
    }
  }

  window.$$ = function(el) {
    if (el.constructor == HTMLDocument) return new DocumentWrapper(el);
    if (el.ELEMENT_NODE) return new ElementWrapper(el);
    if (el.constructor == FileList) return new FileListWrapper(el);
    if (el.constructor == NodeList) return new NodeListWrapper(el);
    if (el.constructor == HTMLCollection) return new HTMLCollectionWrapper(el);
    return el;
  }
}
