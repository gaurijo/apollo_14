require 'rails_helper'

RSpec.describe "astronauts index page" do 
   it "has a list of astronauts with their name, age, and job" do 
      neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      hank = Astronaut.create!(name: "Hank the Tank", age: 36, job: "Chief")
      sol = Astronaut.create!(name: "Sol Arsystem", age: 35, job: "Pilot")

      visit "/astronauts"

      within "#astronaut-#{neil.id}" do 
         expect(page).to have_content("Neil Armstrong")
         expect(page).to have_content("37")
         expect(page).to have_content("Commander")
      end

      within "#astronaut-#{hank.id}" do 
         expect(page).to have_content("Hank the Tank")
         expect(page).to have_content("36")
         expect(page).to have_content("Chief")
      end

      within "#astronaut-#{sol.id}" do 
         expect(page).to have_content("Sol Arsystem")
         expect(page).to have_content("35")
         expect(page).to have_content("Pilot")
         expect(page).to_not have_content("Commander")
      end
   end

   it "shows the average age of all astronauts" do 
      neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      hank = Astronaut.create!(name: "Hank the Tank", age: 36, job: "Chief")
      sol = Astronaut.create!(name: "Sol Arsystem", age: 35, job: "Pilot")

      visit "/astronauts"

      expect(page).to have_content("Average Age: 36")
   end

   it "has a list of space missions for each astronaut, and those missions are in alphabetical order" do 
      neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      sol = Astronaut.create!(name: "Sol Arsystem", age: 35, job: "Pilot")

      mission1 = Mission.create!(title: "Apollo 14", time_in_space: 2)
      mission2 = Mission.create!(title: "Mars Exploration", time_in_space: 3)
      mission3 = Mission.create!(title: "Biannual Discovery", time_in_space: 4)
      mission4 = Mission.create!(title: "Venus Voyage", time_in_space: 5)
      mission5 = Mission.create!(title: "Jupiter Journey", time_in_space: 4)

      astro_mis1 = AstronautMission.create!(astronaut_id: neil.id, mission_id: mission1.id)
      astro_mis2 = AstronautMission.create!(astronaut_id: neil.id, mission_id: mission2.id)
      astro_mis3 = AstronautMission.create!(astronaut_id: neil.id, mission_id: mission3.id)
      astro_mis3 = AstronautMission.create!(astronaut_id: sol.id, mission_id: mission4.id)
      astro_mis3 = AstronautMission.create!(astronaut_id: sol.id, mission_id: mission5.id)

      visit "/astronauts"

      within "#astronaut-#{neil.id}" do
         expect(page).to have_content("Apollo 14")
         expect("Apollo 14").to appear_before("Biannual Discovery")
         expect("Biannual Discovery").to appear_before("Mars Exploration")
      end

      within "#astronaut-#{sol.id}" do
         expect("Jupiter Journey").to appear_before("Venus Voyage")
         expect(page).to_not have_content("Apollo 14")
      end
   end
end
# User Story 3 of 4

# As a visitor,
# When I visit '/astronauts'
# I see a list of the space missions' in alphabetical order for each astronaut.

# (e.g "Apollo 13"
#      "Capricorn 4"
   #   "Gemini 7")