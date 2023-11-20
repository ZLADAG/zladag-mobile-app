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
    
    var totalPets = 0
    var totalDefaultPrice = 0
    var totalAddOnService = 0
    
//    private var dogs = [0]
//    private var cats = [0]
    
    
}
