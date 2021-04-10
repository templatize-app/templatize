import Ember from 'ember';
import AjaxService from 'ember-ajax/services/ajax';

export default AjaxService.extend({
  auth: service('auth'),
  host: config.ajax.apiDomain,
  headers: Ember.computed('auth.authToken', {
    get() {
      let headers = {};
      const authToken = this.get('auth.authToken');
      if (authToken) {
        headers['auth-token'] = authToken;
      }
      return headers;
    }
  })
});