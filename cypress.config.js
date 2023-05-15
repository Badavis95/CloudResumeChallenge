const { defineConfig } = require("cypress");

module.exports = defineConfig({
  projectId: 'smkjd1',
  e2e: {
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
    specPattern: './cypress/integration/**/*.js',  // adjust the pattern to match your test files
  },
});
