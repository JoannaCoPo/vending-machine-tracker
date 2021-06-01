require 'rails_helper'

RSpec.describe "the Machine show page" do
  it "should display all the machines snacks with their prices" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = Snack.create!(name: "Sugar", price: 1)
    snack2 = Snack.create!(name: "Sugar Drink", price: 2)
    dons.snacks.push(snack1, snack2)

    visit "/machines/#{dons.id}"
save_and_open_page
    expect(page).to have_content(snack1.name)
    expect(page).to have_content(snack1.price)
    expect(page).to have_content(snack2.name)
    expect(page).to have_content(snack2.price)
  end
end
