// Replace the following URL with your actual API endpoint
const API_URL = 'https://3kgi0zz7gj.execute-api.us-east-1.amazonaws.com/Prod';

describe('API tests', () => {
  it('should return a valid response', () => {
    cy.request(API_URL)
      .its('status')
      .should('eq', 200);
  });
});
