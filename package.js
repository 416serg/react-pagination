Package.describe({
  name: 'miguelalarcos:react-pagination',
  version: '0.1.0',
  // Brief, one-line summary of the package.
  summary: 'A simple pagination widget for React and FlowRouter.',
  // URL to the Git repository containing the source code for this package.
  git: 'https://github.com/miguelalarcos/react-pagination.git',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.1.0.2');

  api.use('react@0.1.4');
  api.use('jhartma:cjsx@2.4.1');

  api.addFiles('react-pagination.cjsx', 'client');

  api.export('ReactPagination', 'client');
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('miguelalarcos:react-pagination');
  api.addFiles('react-pagination-tests.js');
});
