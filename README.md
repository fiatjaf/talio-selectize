[Selectize](http://brianreavis.github.io/selectize.js/) [Widget](https://github.com/Matt-Esch/virtual-dom/blob/master/docs/widget.md) for being used in the context of a [virtual-dom](https://github.com/Matt-Esch/virtual-dom) and [dom-delegator](https://github.com/Raynos/dom-delegator) based framework, such as [mercury](https://www.npmjs.com/package/mercury) or [talio](https://www.npmjs.com/package/talio).

This requires [Selectize](http://brianreavis.github.io/selectize.js/) to be already loaded in the page in the old way (as a global), so you can probably include [this CSS file](http://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.1/css/selectize.default.min.css) and [this JS file](http://cdnjs.cloudflare.com/ajax/libs/selectize.js/0.12.1/js/standalone/selectize.min.js) and everything will be ok.

It also needs **jQuery**, which is a dependency of Selectize, and also expects it to be a global.

If you don't like adding `<script>` tags everywhere, then you can initialize this with

```javascript
window.$ = require('jquery')
window.selectize = require('selectize')

SelectizeWidget = require('talio-selectize')
SelectizeWidget.init(talio.delegator)

vtree = h('div', {},
  SelectizeWidget({
    name: '',
    value: '',
    options: [{bli: '', 'plo': ''}],
    valueField: 'plo',
    nameField: 'bli',
    'ev-change': 'normal event handler'
  })
)
```
