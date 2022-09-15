describe("jungle rails product details", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("goes to product details when click product image", () => {
    cy.get("[alt='Giant Tea']").click();
    cy.get(".products-show article").should("be.visible");
  });
});
