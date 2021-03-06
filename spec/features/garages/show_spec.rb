require 'rails_helper'

RSpec.describe "garages show page", type: :feature do
  it "from garage ID, it can see data from each column that is on the garage table" do
    garage_1 = Garage.create!(name: "Kon's Garage", at_capacity: false, max_capacity: 4)
    garage_2 = Garage.create!(name: "Aidan's Garage", at_capacity: true, max_capacity: 2)

    visit "/garages/#{garage_1.id}" #TODO make dynamic?

    expect(page).to have_content(garage_1.created_at)
    expect(page).to have_content(garage_1.updated_at)
    expect(page).to have_content(garage_1.name)
    expect(page).to have_content(garage_1.id)
    expect(page).to have_content(garage_1.at_capacity)
    expect(page).to have_content(garage_1.max_capacity)

    visit "/garages/#{garage_2.id}"

    expect(page).to have_content(garage_2.created_at)
    expect(page).to have_content(garage_2.updated_at)
    expect(page).to have_content(garage_2.name)
    expect(page).to have_content(garage_2.id)
    expect(page).to have_content(garage_2.at_capacity)
    expect(page).to have_content(garage_2.max_capacity)
  end

  it "can show a count of the number of motorcycles associated with this garage" do
    garage_1 = Garage.create!(name: "Kon's Garage", at_capacity: false, max_capacity: 4)
    garage_2 = Garage.create!(name: "Aidan's Garage", at_capacity: true, max_capacity: 2)

    motorcycle_1 = garage_1.motorcycles.create!(name: "ZoomZoom X1", ride_ready: true, model_year: 2050)
    motorcycle_2 = garage_2.motorcycles.create!(name: "VroomVroom X-Wowza-so-fast", ride_ready: true, model_year: 1969)

    visit "/garages/#{garage_1.id}"

    expect(page).to have_content(garage_1.count_motorcycles)

    visit "/garages/#{garage_2.id}"

    expect(page).to have_content(garage_2.count_motorcycles)
  end

  it "has a link to take me to that garage's motorcycles page" do
    garage_1 = Garage.create!(name: "Kon's Garage", at_capacity: false, max_capacity: 4)
    garage_2 = Garage.create!(name: "Aidan's Garage", at_capacity: true, max_capacity: 2)

    visit "/garages/#{garage_1.id}"

    expect(page).to have_link("Motorcycles In This Garage")
    click_link "Motorcycles In This Garage"
    expect(current_path).to eq("/garages/#{garage_1.id}/motorcycles")

    visit "/garages/#{garage_2.id}"

    expect(page).to have_link("Motorcycles In This Garage")
    click_link "Motorcycles In This Garage"
    expect(current_path).to eq("/garages/#{garage_2.id}/motorcycles")
  end

  it "has a link to take me to the garages index" do
    garage_1 = Garage.create!(name: "Kon's Garage", at_capacity: false, max_capacity: 4)
    garage_2 = Garage.create!(name: "Aidan's Garage", at_capacity: true, max_capacity: 2)

    visit "/garages/#{garage_1.id}"

    expect(page).to have_link("Full Garage Index")
    click_link "Full Garage Index"
    expect(current_path).to eq("/garages")

    visit "/garages/#{garage_2.id}"

    expect(page).to have_link("Full Garage Index")
    click_link "Full Garage Index"
    expect(current_path).to eq("/garages")
  end

  it "has a link to take me to the motorcycles index" do
    garage_1 = Garage.create!(name: "Kon's Garage", at_capacity: false, max_capacity: 4)
    garage_2 = Garage.create!(name: "Aidan's Garage", at_capacity: true, max_capacity: 2)

    visit "/garages/#{garage_1.id}"

    expect(page).to have_link("Full Motorcycle Index")
    click_link "Full Motorcycle Index"
    expect(current_path).to eq("/motorcycles")

    visit "/garages/#{garage_2.id}"

    expect(page).to have_link("Full Motorcycle Index")
    click_link "Full Motorcycle Index"
    expect(current_path).to eq("/motorcycles")
  end

  it "can delete a garage from the garages table" do
    garage_1 = Garage.create!(name: "Kon's Garage", at_capacity: false, max_capacity: 4)

    visit "/garages/#{garage_1.id}"

    expect(page).to have_content("Kon's Garage")
    expect(page).to have_link("Delete Garage")

    click_link "Delete Garage"
    expect(current_path).to eq("/garages")

    expect(page).to have_no_content("Kon's Garage")
  end
end
