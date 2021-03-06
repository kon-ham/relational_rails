require 'rails_helper'

RSpec.describe 'motorcycle index page via parent garage', type: :feature do
  it "can see the motorcyles associated with that garage_id including all of the motorcyles attributes" do
    garage_1 = Garage.create!(name: "Kon's Garage", at_capacity: false, max_capacity: 4)
    garage_2 = Garage.create!(name: "Aidan's Garage", at_capacity: true, max_capacity: 2)

    motorcycle_1 = garage_1.motorcycles.create!(name: "ZoomZoom X1", ride_ready: true, model_year: 2050)
    motorcycle_2 = garage_1.motorcycles.create!(name: "BoomBoom X1-zdf23", ride_ready: false, model_year: 2010)
    motorcycle_3 = garage_2.motorcycles.create!(name: "VroomVroom X-Wowza-so-fast", ride_ready: true, model_year: 1969)
    motorcycle_4 = garage_2.motorcycles.create!(name: "AYYY LAMO X1", ride_ready: false, model_year: 2190)

    visit "/garages/#{garage_1.id}/motorcycles"

    expect(page).to have_content(motorcycle_1.id)
    expect(page).to have_content(motorcycle_1.garage_id)
    expect(page).to have_content(motorcycle_1.created_at)
    expect(page).to have_content(motorcycle_1.updated_at)
    expect(page).to have_content(motorcycle_1.ride_ready)
    expect(page).to have_content(motorcycle_1.model_year)

    visit "/garages/#{garage_1.id}/motorcycles"

    expect(page).to have_content(motorcycle_2.id)
    expect(page).to have_content(motorcycle_2.garage_id)
    expect(page).to have_content(motorcycle_2.created_at)
    expect(page).to have_content(motorcycle_2.updated_at)
    expect(page).to have_content(motorcycle_2.ride_ready)
    expect(page).to have_content(motorcycle_2.model_year)

    visit "/garages/#{garage_2.id}/motorcycles"

    expect(page).to have_content(motorcycle_3.id)
    expect(page).to have_content(motorcycle_3.garage_id)
    expect(page).to have_content(motorcycle_3.created_at)
    expect(page).to have_content(motorcycle_3.updated_at)
    expect(page).to have_content(motorcycle_3.ride_ready)
    expect(page).to have_content(motorcycle_3.model_year)

    visit "/garages/#{garage_2.id}/motorcycles"

    expect(page).to have_content(motorcycle_4.id)
    expect(page).to have_content(motorcycle_4.garage_id)
    expect(page).to have_content(motorcycle_4.created_at)
    expect(page).to have_content(motorcycle_4.updated_at)
    expect(page).to have_content(motorcycle_4.ride_ready)
    expect(page).to have_content(motorcycle_4.model_year)
  end

  it "has a link to take me to the garages index" do
    garage_1 = Garage.create!(name: "Kon's Garage", at_capacity: false, max_capacity: 4)
    garage_2 = Garage.create!(name: "Aidan's Garage", at_capacity: true, max_capacity: 2)

    visit "/garages/#{garage_1.id}/motorcycles"

    expect(page).to have_link("Full Garage Index")
    click_link "Full Garage Index"
    expect(current_path).to eq("/garages")

    visit "/garages/#{garage_2.id}/motorcycles"

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

  it 'has form that filters motorcycles based on argument' do
    garage_1 = Garage.create!(name: "Kon's Garage", at_capacity: false, max_capacity: 4)

    visit "/garages/#{garage_1.id}/motorcycles"

    expect(page).to have_button('Only return records with newer than `your input year` of model year')

    fill_in 'model_year', with: 2000
    click_on 'Only return records with newer than `your input year` of model year'
    
    expect(current_path).to eq("/garages/#{garage_1.id}/motorcycles")
  end
end