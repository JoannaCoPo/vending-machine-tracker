require 'rails_helper'

RSpec.describe "the Snack show page" do
  it "it displays the snack attributes" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = Snack.create!(name: "Pina Coladinator", price: 4)
    snack2 = Snack.create!(name: "Cola Bevvie", price: 2)
    dons.snacks.push(snack1, snack2)

    visit "/snacks/#{snack1.id}"

    expect(page).to have_content(snack1.name)
    expect(page).to have_content(snack1.price)
  end

  it "it displays list of machines that carry snack" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = Snack.create!(name: "Pina Coladinator", price: 4)
    snack2 = Snack.create!(name: "Cola Bevvie", price: 2)
    dons.snacks.push(snack1, snack2)

    visit "/snacks/#{snack1.id}"
save_and_open_page
    within "#locations" do
      expect(page).to have_content(dons.location)
    end
  end
end
