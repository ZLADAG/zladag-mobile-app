//
//  SimpanButtonView.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 12/10/23.
//

import UIKit

class SimpanButtonView: UIView {
    
    var sheetDelegate: FilterSheetViewController?
    
    let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customOrange
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Simpan"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        
        addSubview(button)
        button.addSubview(label)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        
        button.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        
        setupConstraints()
    }
    
    @objc func saveData() {
        guard let sheetDelegate else { return }
        
        // strings to concatenate altogether, as the query params
        var sortBy: String = ""
        var boardingCategories: String = ""
        var facilities: String = ""
        var petCategories: String = ""
        
        // URUTKAN buttons
        let urutkanButtons = [
            sheetDelegate.palingSesuaiButton,
            sheetDelegate.hargaTertinggiButton,
            sheetDelegate.hargaTerendahButton,
            sheetDelegate.ratingTertinggiButton,
            sheetDelegate.lokasiTerdekatButton
        ]
        
        let kategoriButtons = [
            sheetDelegate.kategoriPetHotelButton,
            sheetDelegate.kategoriPetShopButton,
            sheetDelegate.kategoriRumahSakitHewanButton
        ]
        
        let facilityButtons = [
            sheetDelegate.tempatBermainContainer,
            sheetDelegate.ruanganBerACContainer,
            sheetDelegate.cctvContainer,
            sheetDelegate.termasukMakananContainer,
            sheetDelegate.tersediaAntarJemputContainer,
            sheetDelegate.tersediaGroomingContainer,
            sheetDelegate.tersediaDokterHewanContainer
        ]
        
        let kekhususanButtons = [
            sheetDelegate.khususKucingSwitch,
            sheetDelegate.khususAnjingSwitch
        ]
        
        // MARK: URUTKAN
        for urutkanButton in urutkanButtons {
            if urutkanButton.isClicked {
                if let queryParam = "sortBy=\(urutkanButton.textParam)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    sortBy = queryParam
                }
                sheetDelegate.cellDelegate?.urutkanValue = urutkanButton.text
            }
        }
        
        // MARK: KATEGORI
        var tempKategori = [String]()
        for kategoriButton in kategoriButtons {
            if kategoriButton.isClicked {
                let queryParam: String? = "&boardingCategories[]=\(kategoriButton.textParam)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                if let queryParam {
                    boardingCategories += queryParam
                }
                tempKategori.append(kategoriButton.kategoriText)
                
            }
        }
        sheetDelegate.cellDelegate?.kategoriValues = tempKategori

        
        // MARK: FACILITIES
        var tempFacilities = [String]()
        for facilityButton in facilityButtons {
            if facilityButton.isClicked {
                let queryParam: String? = "&boardingFacilities[]=\(facilityButton.textParam)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                if let queryParam {
                    facilities += queryParam
                }
                tempFacilities.append(facilityButton.facilityName)
            }
        }
        
        
        sheetDelegate.cellDelegate?.fasilitasValues = tempFacilities

        
        // MARK: KEKHUSUSAN
        var tempKekhususan = [String]()
        for kekhususanButton in kekhususanButtons {
            if kekhususanButton.isClicked {
                let queryParam: String? = "&boardingPetCategories[]=\(kekhususanButton.textParam)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                if let queryParam {
                    petCategories += queryParam
                }
                tempKekhususan.append(kekhususanButton.khususText)
            }
        }
        sheetDelegate.cellDelegate?.kekhususanValues = tempKekhususan
        
        // MARK: RENTANG HARGA
        var priceRange = ""
        let tempPriceRange =
            "&lowestPriceRange=\(sheetDelegate.cellDelegate?.minimumPriceValue ?? 1234)" +
            "&highestPriceRange=\(sheetDelegate.cellDelegate?.maximumPriceValue ?? 1234)"
        
        if let encodedPriceRange = tempPriceRange.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            priceRange = encodedPriceRange
        }
        
        let group = DispatchGroup()
        group.enter()
        
        APICaller.shared.getBoardingsSearch(params: "\(sortBy)\(facilities)\(petCategories)\(priceRange)\(boardingCategories)") { result in
            defer {
                group.leave()
            }
            
            switch result {
            case .success(let response):
                self.sheetDelegate?.cellDelegate?.viewControllerDelegate?.viewModels = response.data.compactMap({ boarding in
                    return SearchBoardingViewModel(
                        slug: boarding.slug,
                        name: boarding.name,
                        distance: boarding.distance,
                        subdistrictName: boarding.subdistrict,
                        provinceName: boarding.province,
                        price: boarding.cheapestLodgingPrice,
                        imageURLStrings: boarding.images,
                        facilities: boarding.boardingFacilities
                    )
                })

                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
        
        group.notify(queue: .main) {
            self.sheetDelegate?.cellDelegate?.viewControllerDelegate?.collectionView.reloadData()
        }
        
        self.sheetDelegate?.dismiss(animated: true)
    }
    
    func setupConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            button.widthAnchor.constraint(equalToConstant: 342),
            button.heightAnchor.constraint(equalToConstant: 39),
            
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            label.widthAnchor.constraint(equalToConstant: 100),
            label.heightAnchor.constraint(equalToConstant: 19),
        ])
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }

}
