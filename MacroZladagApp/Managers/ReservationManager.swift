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

    var reservationModel = ReservationViewModel()
        
    var defaultPrices : [Int] = []
    var addOnServicePrices : [Int] = []
    
    var totalPets = 0
    var totalDefaultPrice = 0
    var totalAddOnServicePrice = 0
    var totalOrder = 0
    
    func updateDefaultPrices(indexPath: IndexPath, price: Int){
        updateTotalDefaultPrice(priceBefore: defaultPrices[indexPath.row], priceAfter: price)
        updateTotalOrder(priceBefore: defaultPrices[indexPath.row], priceAfter: price)
        defaultPrices[indexPath.row] = price
    }
    func updateAddOnServicePrices(indexPath: IndexPath, price: Int){
        updateTotalAddOnServicePrice(priceBefore: addOnServicePrices[indexPath.row], priceAfter: price)
        updateTotalOrder(priceBefore: addOnServicePrices[indexPath.row], priceAfter: price)
        addOnServicePrices[indexPath.row] = price
    }
    
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
