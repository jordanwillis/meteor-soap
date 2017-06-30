Package.describe({
  name: 'zardak:soap',
  version: '0.2.7',
  summary: 'Wrapped npm soap package',
  git: 'https://github.com/jordanwillis/meteor-soap',
  documentation: 'README.md'
});

Npm.depends({
  soap: '0.19.2'
});

Package.onUse(function(api) {
  api.versionsFrom('0.9.3');
  api.use(['coffeescript', 'webapp']);
  api.export('Soap', 'server');
  api.addFiles('client.coffee', 'server');
  api.addFiles('server.coffee', 'server');
});

Package.onTest(function(api) {
  api.use(['coffeescript', 'tinytest', 'zardak:soap']);
  api.addFiles('tests/data.js', 'server');
  api.addFiles('tests/tests.coffee', 'server');
});
