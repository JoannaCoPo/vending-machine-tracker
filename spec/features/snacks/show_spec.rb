require 'rails_helper'

RSpec.describe "the Snack show page" do
  it "it displays the snack attributes" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = Snack.create!(name: "Soft Cheezy Pretzel", price: 4)
    snack2 = Snack.create!(name: "Bag o Lil Cookies", price: 2)
    dons.snacks.push(snack1, snack2)

    visit "/snacks/#{snack1.id}"

    expect(page).to have_content(snack1.name)
    expect(page).to have_content(snack1.price)
  end

  it "it displays list of locations for machines that carry snack" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = Snack.create!(name: "Soft Cheezy Pretzel", price: 4)
    snack2 = Snack.create!(name: "Bag o Lil Cookies", price: 2)
    dons.snacks.push(snack1, snack2)

    visit "/snacks/#{snack1.id}"

    within "#locations" do
      expect(page).to have_content(dons.location)
    end
  end

  it "it displays a count of the different kinds of items in that  machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = Snack.create!(name: "Soft Cheezy Pretzel", price: 4)
    snack2 = Snack.create!(name: "Bag o Lil Cookies", price: 2)
    snack3 = Snack.create!(name: "Roasty Toasty Almonds", price: 3.50)
    dons.snacks.push(snack1, snack2, snack3)

    visit "/snacks/#{snack1.id}"
    # save_and_open_page
    within "#locations" do
      expect(page).to have_content("kind of snacks, with an average price of")
      expect(dons.snack_quantity).to eq(3)
    end
  end

  it "it displays average price for snacks in machine" do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack1 = Snack.create!(name: "Soft Cheezy Pretzel", price: 4)
    snack2 = Snack.create!(name: "Bag o Lil Cookies", price: 2)
    snack3 = Snack.create!(name: "Roasty Toasty Almonds", price: 3.50)
    dons.snacks.push(snack1, snack2, snack3)

    visit "/snacks/#{snack1.id}"

    within "#locations" do
      expect(page).to have_content("average price of $3.17")
    end
  end
end
