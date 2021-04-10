import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
  router: service(),
  auth: service('auth'),
  ajax: Ember.inject.service(),
  actions: {
    putTemplate(){
        return this.get('ajax').request('/template', {
            method: 'POST',
            data: {
              foo: 'bar'
            }
          });
    }
  }
});