require 'rails_helper'

RSpec.describe "the Machine show page" do
  it "should display all the machines snacks with their prices" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = Snack.create!(name: "Soft Cheezy Pretzel", price: 4)
    snack2 = Snack.create!(name: "Bag o Lil Cookies", price: 2)
    dons.snacks.push(snack1, snack2)

    visit "/machines/#{dons.id}"

    within("#snack-#{snack1.id}") do
      expect(page).to have_content(snack1.name)
      expect(page).to have_content(snack1.price)
    end
    within("#snack-#{snack2.id}") do
      expect(page).to have_content(snack2.name)
      expect(page).to have_content(snack2.price)
    end
  end

  it "displays the average price for all snacks in the machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = Snack.create!(name: "Soft Cheezy Pretzel", price: 4)
    snack2 = Snack.create!(name: "Bag o Lil Cookies", price: 2)
    snack3 = Snack.create!(name: "Roasty Toasty Almonds", price: 3.50)
    dons.snacks.push(snack1, snack2, snack3)

    visit "/machines/#{dons.id}"

    expect(page).to have_content("Average Price: $3.17")
  end
end
