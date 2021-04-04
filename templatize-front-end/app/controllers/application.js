import Controller from '@ember/controller';
import { inject as service } from '@ember/service';

export default Controller.extend({
  auth: service(),
  pellOptions: {
    defaultParagraphSeparator: 'p',
    actions: ['bold', 'italic', 'underline', 'strikethrough', 'heading1', 'heading2', 'paragraph', 'quote', 'olist', 'ulist', 'line', 'link','indent','outdent'],
  },
  init() {
    this._super(...arguments);
  }
});