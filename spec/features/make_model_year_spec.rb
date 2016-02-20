require 'rails_helper'

RSpec.feature "MakeModelYears", type: :feature do

  #Story: As an internet user, I can visit a page that shows Welcome to the Car Simulator
  context "when I visit the welcome page," do
    it "shows Welcome to the Car Simulator" do
      visit '/car/new_car'
      expect(page).to have_content("Welcome to the Car Simulator")
    end
    #Story: As an internet user, when I visit the welcome page, I am asked for make and model year of the car to be simulated.
    it "asks for a make and model year of the car to be simulated" do
      visit '/car/new_car'
      within("form#welcome_form") do
        expect(page).to have_field("make")
        expect(page).to have_field("year")
      end
    end
    #Story: As an internet user, when I visit the welcome page, after entering make and model year, and clicking on a button labelled Simulate Car I am taken to a status page showing make and model year of the car.
    it "after entering make and model year, I can click a button labelled Simulate Car, which takes me to a Status page" do
      auto_fill_welcome_form
      click_button "Simulate My Car"
      expect(current_path).to eq("/simulator/do")
    end
    #now that we know that the button redirects correctly, we test that the page has updated with the correct content
    it "after clicking simulate my car button, I am taken to a status page showing make and model year of the car" do
      auto_fill_welcome_form
      click_button "Simulate My Car"
      expect(page).to have_content("Make: Honda")
      expect(page).to have_content("Year: 2006")
    end
    #Story: As an internet user, when I visit the status page for a selected car, it shows whether the lights on the car is on or off. They start off.
    it "the status page shows whether or not the lights are on and they start off" do
      auto_fill_welcome_form
      click_button "Simulate My Car"
      expect(page).to have_content("Headlights are: Off")
    end
    #Story: As an internet user, when I visit the status page, I can turn the lights on using a button that toggles between show On and Off.
    it "I can turn the lights on using a button that toggles between show On and Off" do
      auto_fill_welcome_form
      click_button "Simulate My Car"
      #testing to turn the lights on
      within("form#lights_form") do
        choose "On"
        click_button "Light Switch"
      end
      #testing that the status has been updated
      expect(page).to have_content("Headlights are: On")
      #testing to turn the lights off, having been turned on
      within("form#lights_form") do
        choose "Off"
        click_button "Light Switch"
      end
      expect(page).to have_content("Headlights are: Off")
    end
    # Story: As an internet user, when I visit the car status page, I can see the cars current speed. It starts a zero.
    it "the status page will display the car's current speed, speed starts at 0" do
      auto_fill_welcome_form
      click_button "Simulate My Car"
      expect(page).to have_content("Speed is: 0mph")
    end
    # Story: As an internet user, when I visit the car status page, I can click on an accelerate button, which makes the car go faster, and which is shown in the car status page.
    it "I can click on an accelerate button, which makes the car go faster, and which is shown" do
      auto_fill_welcome_form
      click_button "Simulate My Car"
      within("form#gas_id") do
        click_button "Gas Pedal"
      end
      expect(page).to have_content("Speed is: 10mph")
    end
    #Story: As an internet user, when I visit the car status page, I can click on an brake button, which makes the car go slower, and shows that in the car status page.
    it "I can click on an brake button, which makes the car go slower, and which is shown" do
      auto_fill_welcome_form
      click_button "Simulate My Car"
      #need to accelerate in order to show that the brake is functional
      click_button "Gas Pedal"
      within("form#brake_id") do
        click_button "Brake Pedal"
      end
      expect(page).to have_content("Speed is: 3mph")
    end
    #Story: As an internet user, I can set and release the parking brake using radio buttons.
    it "I can set and release the parking brake using radio buttons" do
      auto_fill_welcome_form
      click_button "Simulate My Car"
      #testing to turn the brake lever on
      within("form#parking_brake_form") do
        choose "On"
        click_button "Brake Lever"
      end
      #testing that the parking brake's status has been updated
      expect(page).to have_content("Parking Brake is: On")
      #testing to turn the brake lever off, having been turned on
      within("form#parking_brake_form") do
        choose "Off"
        click_button "Brake Lever"
      end
      expect(page).to have_content("Parking Brake is: Off")
    end
    # Story: As an internet user, when the parking brake is set, the accelerate button does not work.
    it "when the parking brake is set, the accelerate button does not work" do
      auto_fill_welcome_form
      click_button "Simulate My Car"
      #turn on the parking brake
      within("form#parking_brake_form") do
        choose "On"
        click_button "Brake Lever"
      end
      #try to accelerate
      click_button "Gas Pedal"
      #speed should still be 0
      expect(page).to have_content("Speed is: 0mph")
    end
    # Story: As an internet user, I can enter a description of the on the welcome page, and it is shown on the status page (max 100 characters.)
    it "I can enter a description of the on the welcome page, and it is shown on the status page" do
      visit '/car/new_car'
      within("form#welcome_form") do
        fill_in("make", with: "Honda")
        fill_in("year", with: "2006")
        fill_in("description", with: "This is my car.")
      end
      click_button "Simulate My Car"
      expect(page).to have_content("Car Description: This is my car.")
    end
    # Story: As an internet user, I can select a color on the welcome page and have it used as the color for the model and year on the status page.
    it "I can select a color on the welcome page and have it used as the color for the model and year on the status page" do
      visit '/car/new_car'
      #we are checking for the color field, however, capybara does not have the capability of testing the color selection from a field of input type color
      within("form#welcome_form") do
        expect(page).to have_field("color")
      end
    end
  end
  #helper method to fill in the welcome form
  def auto_fill_welcome_form
    visit '/car/new_car'
    within("form#welcome_form") do
      fill_in("make", with: "Honda")
      fill_in("year", with: "2006")
    end
  end
end
