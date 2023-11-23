//
//  ReservationManager.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 19/11/23.
//

import Foundation
final class ReservationManager {
    static let shared = ReservationManager()
   
    private init() {}

    var reservationModel : ReservationViewModel!
    var compliedCats: [ReservationPetViewModel] = []
    var compliedDogs: [ReservationPetViewModel] = []
    var uncompliedCats: [ReservationPetViewModel] = []
    var uncompliedDogs: [ReservationPetViewModel] = []
    
    var selectedCatProfiles : [ReservationPetViewModel?] = []
    var selectedDogProfiles : [ReservationPetViewModel?] = []
//    var selectedCatIndexPath : [] = []
    
    var catDefaultPrices : [Int] = []
    var catAddOnServicePrices : [Int] = []
    
    var dogDefaultPrices : [Int] = []
    var dogAddOnServicePrices : [Int] = []
    
    var totalPets = 0
    var totalDefaultPrice = 0
    var totalAddOnServicePrice = 0
    var totalOrder = 0
    
    /// CAT
    func updateSelectedCat(indexPath: IndexPath, profile: ReservationPetViewModel?) {
        selectedCatProfiles[indexPath.row] = profile
    }
    func updateCatDefaultPrices(indexPath: IndexPath, price: Int){
        updateTotalDefaultPrice(priceBefore: catDefaultPrices[indexPath.row], priceAfter: price)
        updateTotalOrder(priceBefore: catDefaultPrices[indexPath.row], priceAfter: price)
        catDefaultPrices[indexPath.row] = price
    }
    func updateCatAddOnServicePrices(indexPath: IndexPath, price: Int){
        updateTotalAddOnServicePrice(priceBefore: catAddOnServicePrices[indexPath.row], priceAfter: price)
        updateTotalOrder(priceBefore: catAddOnServicePrices[indexPath.row], priceAfter: price)
        catAddOnServicePrices[indexPath.row] = price
    }
    
    /// DOG
    func updateDogDefaultPrices(indexPath: IndexPath, price: Int){
        updateTotalDefaultPrice(priceBefore: dogDefaultPrices[indexPath.row], priceAfter: price)
        updateTotalOrder(priceBefore: dogDefaultPrices[indexPath.row], priceAfter: price)
        dogDefaultPrices[indexPath.row] = price
    }
    func updateDogAddOnServicePrices(indexPath: IndexPath, price: Int){
        updateTotalAddOnServicePrice(priceBefore: dogAddOnServicePrices[indexPath.row], priceAfter: price)
        updateTotalOrder(priceBefore: dogAddOnServicePrices[indexPath.row], priceAfter: price)
        dogAddOnServicePrices[indexPath.row] = price
    }
    
    /// TOTAL ALL
    func updateTotalDefaultPrice(priceBefore: Int, priceAfter: Int) {
        totalDefaultPrice = totalDefaultPrice - priceBefore + priceAfter
        print("ini total defaultnyaa: \(totalDefaultPrice)")
    }
    func updateTotalAddOnServicePrice(priceBefore: Int, priceAfter: Int) {
        totalAddOnServicePrice = totalAddOnServicePrice - priceBefore + priceAfter
        print("ini total addOnService: \(totalAddOnServicePrice)")
    }
    
    func updateTotalOrder(priceBefore: Int, priceAfter: Int) {
        totalOrder = totalOrder - priceBefore + priceAfter
        print("ini total order: \(totalOrder)")
    }
    
}
