//
//  ProfilePageManager.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 07/11/23.
//

import Foundation
final class ProfilePageManager {
    static let shared = ProfilePageManager()
    
    private var userProfile : UserProfile = UserProfile()
    private var petProfileDetails : PetProfileDetails = PetProfileDetails()
    
    private var dummyPets: [PetProfile] = []
    private var dummyPetDetails: [PetProfileDetails] = []
    
    /// Managers
    var apiCaller = APICaller.shared
    
    init(){
        dummyPets = [
            PetProfile(id: "1", name: "Michellez", petBreed: "Dog Beaglee", age: 1.2, image: "dummy-image"),
            PetProfile(id: "2", name: "Mengg", petBreed: "Garong", age: 1, image: "dummy-image"),
            PetProfile(id: "3", name: "Gukk", petBreed: "Husky", age: 0.5, image: "dummy-image"),
        ]

        /*
         
         dummyPetDetails = [
         PetProfileDetails(
         id: "1",
         name: "Michellez",
         petBreed: "Dog Beaglee",
         petGender: "Male",
         hasBeenSterilized: true,
         hasBeenVaccinatedRoutinely: true,
         hasBeenFleaFreeRegularly: true,
         age: 1.2,
         bodyMass: 5,
         boardingFacilities: [
         "AC",
         "CCTV",
         "Cage",
         "Delivery",
         "Food",
         "Grooming",
         "Playground"
         ],
         petHabits: [
         "Aggressive towards others",
         "Likes to sleep and lie down",
         "Trained with basic commands"
         ],
         historyOfIllness: "Punya asthma dan harus dikasih inhaler setiap hari selama 10 detik",
         image: "dummy-image"
         ),
         
         PetProfileDetails(
         id: "2",
         name: "Mengg",
         petBreed: "Gukk",
         petGender: "Female",
         hasBeenSterilized: false,
         hasBeenVaccinatedRoutinely: false,
         hasBeenFleaFreeRegularly: false,
         age: 1,
         bodyMass: 6,
         boardingFacilities: [
         "AC",
         "CCTV",
         "Cage",
         "Delivery",
         "Food"
         ],
         petHabits: [
         "Aggressive towards others",
         "Likes to sleep and lie down"
         ],
         historyOfIllness: "Punya asthma dan harus dikasih inhaler setiap hari selama 10 detik",
         image: "dummy-image"
         ),
         
         PetProfileDetails(
         id: "3",
         name: "Gukk",
         petBreed: "Husky",
         petGender: "Male",
         hasBeenSterilized: true,
         hasBeenVaccinatedRoutinely: true,
         hasBeenFleaFreeRegularly: true,
         age: 0.5,
         bodyMass: 9,
         boardingFacilities: [
         "Delivery",
         "Food",
         "Grooming",
         "Playground"
         ],
         petHabits: [],
         historyOfIllness: nil,
         image: "dummy-image"
         ),
 
         ]
         userProfile = UserProfile(
         name: "Louiz",
         image: "dummy-image",
         pets: self.dummyPets
         )
         */
        
        
    }
    
    func getUserProfile() -> UserProfile {
        return userProfile
    }
    
    func getUserPets() -> [PetProfile]{
        return userProfile.pets
    }
    
    func getPetProfile(id: String) -> PetProfileDetails{
        for profile in dummyPetDetails {
            if id == profile.id {
                petProfileDetails = profile
            }
        }
        return petProfileDetails
   }
    
}
