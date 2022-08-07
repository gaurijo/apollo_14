require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many(:missions).through(:astronaut_missions)}
  end

  describe "class methods" do 
    it ".average_age" do 
      neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      hank = Astronaut.create!(name: "Hank the Tank", age: 36, job: "Chief")
      sol = Astronaut.create!(name: "Sol Arsystem", age: 35, job: "Pilot")

      expect(Astronaut.average_age).to eq(36)
    end
    it ".alphabet_titles" do 
      neil = Astronaut.create!(name: "Neil Armstrong", age: 37, job: "Commander")
      hank = Astronaut.create!(name: "Hank the Tank", age: 36, job: "Chief")
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

      expect(neil.missions.alphabet_titles).to eq([mission1, mission3, mission2])
    end
  end
end