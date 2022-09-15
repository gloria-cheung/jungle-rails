describe("jungle rails add to cart", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("increases cart by 1 when click add button on product", () => {
    cy.get(".products article").should("be.visible");
    cy.get("a[href='/cart']").contains("My Cart (0)");
    cy.get("button").contains("Add").click({ force: true });
    cy.get("a[href='/cart']").contains("My Cart (1)");
  });
});
