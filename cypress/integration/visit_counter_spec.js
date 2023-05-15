describe('Visit Counter Test', () => {
    it('Checks if the visit counter is updated', () => {
      // Replace the path with the correct path to your index.html file
      cy.visit(https://bdavisawsresume.link');
  
      cy.window()
        .its('updateCounter')
        .invoke('call', null);
  
      cy.get('#Visit_Count')
        .should(($span) => {
          const visitCount = parseInt($span.text(), 10);
          expect(visitCount).to.be.a('number');
          expect(visitCount).to.be.at.least(1);
        });
    });
  });
  