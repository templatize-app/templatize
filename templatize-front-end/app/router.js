import EmberRouter from '@ember/routing/router';
import config from 'templatize-front-end/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('login');
  this.route('callback');
  this.route('new-template');
  this.route('dashboard');
  this.route('home');
});