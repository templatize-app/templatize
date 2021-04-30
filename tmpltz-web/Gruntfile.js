module.exports = function(grunt) {
    // Project configuration.
    grunt.initConfig({
      pkg: grunt.file.readJSON('package.json'),
      replace: {
        dist: {
          options: {
            patterns: [
              {
                match: 'grunt-AUTH0_DOMAIN',
                replacement: process.env.AUTH0_DOMAIN
              },
              {
                match: 'grunt-AUTH0_WEB_CLIENT_ID',
                replacement: process.env.AUTH0_WEB_CLIENT_ID
              },
              {
                match: 'grunt-API_DOMAIN',
                replacement: process.env.TMPLTZ_API_DOMAIN
              }
            ]
          },
          files: [
            {
              expand: true, flatten: true, src: ['dist/tmpltz-web/main*.js','dist/tmpltz-web/*.html'], dest: 'dist/tmpltz-web/'
            }
          ]
        }
      }
    });
  
    grunt.loadNpmTasks('grunt-replace');
  
    // Default task(s).
    grunt.registerTask('default', ['replace']);
  };