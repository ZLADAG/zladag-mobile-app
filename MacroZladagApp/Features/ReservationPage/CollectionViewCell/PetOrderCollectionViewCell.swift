//
//  PetOrderCollectionViewCell.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 18/11/23.
//

import UIKit

protocol PetOrderCollectionViewCellDelegate {
    func petOptTapped(cell: UICollectionViewCell, atIndexPath: IndexPath)
    func cageOptTapped(cell: UICollectionViewCell, atIndexPath: IndexPath)
    func serviceOptTapped(cell: UICollectionViewCell, atIndexPath: IndexPath)
}

class PetOrderCollectionViewCell: UICollectionViewCell {
    
    var delegate:PetOrderCollectionViewCellDelegate?
    
    static let identifier = "CatOrderCollectionViewCell"
    let placeholderText = "Pesan tambahan untuk pet hotel"

    var type: PetType!
    
    var selectedPetProfile: ProfilePhotoWithTitle?
    var selectedPetProfileIndexPath: IndexPath?
    
    var titleLabel : UILabel!
    
    var petOptTitleLabel : NecessarryFieldLabel!
    var petOpt : UIView!
    var petOptDefaultContent : UIStackView!
    var petOptProfileContent : UIStackView!
    
    var cageOptTitleLabel : NecessarryFieldLabel!
    var allCageOpt : [CageOption]!
    var addOnOptTitleLabel : UILabel!
    
    var messageTitleLabel : UILabel!
    var messageTextField: UITextView!
    var messageTextFieldFrame : CGRect!
    
    var cellContent : UIStackView!
    var cellSeparator : UIImageView!
    
    //Price calculation Variable
    var cagePrice = 0
    var addOnServicePrice = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        messageTextField.removeObserver(self, forKeyPath: "contentSize")
    }
    
    private func setUpCell() {
        
        cellContent = createStack(views: [], spacing: 16)
        
        titleLabel = createLabel("Pet 1")
        titleLabel.font = .boldSystemFont(ofSize: 16)
        cellContent.addArrangedSubview(titleLabel)
        
        setPetOption()
        setCageOption()
        setAddOnOption()
        setMessage()
        
        cellSeparator = addSeparator()
        self.addSubview(cellContent)
        NSLayoutConstraint.activate([
            cellContent.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cellContent.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            cellContent.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
        ])
        
        self.addSubview(messageTextField)
        NSLayoutConstraint.activate([
            messageTextField.topAnchor.constraint(equalTo: cellContent.bottomAnchor, constant: 7),
            messageTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            messageTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
        ])
        
        self.addSubview(cellSeparator)
        NSLayoutConstraint.activate([
            cellSeparator.heightAnchor.constraint(equalToConstant: 12),
            cellSeparator.topAnchor.constraint(equalTo: messageTextField.bottomAnchor, constant: 16),
            cellSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            cellSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            cellSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
        ])
    }
}

extension PetOrderCollectionViewCell {
    
    private func changePetOption() {
        print("changed!")
    }
    
    func updatePetProfile(profile: ReservationPetViewModel) {
        guard selectedPetProfile != nil else { return }
        
        selectedPetProfile!.updateNameTitleLabel(text: profile.petDetails.name)
        selectedPetProfile!.updateNameDetailLabel(text: profile.petDetails.petBreed)
        selectedPetProfile!.updateAgeLabel(age: Double(profile.petDetails.age))
    }
    
    private func setPetOption() {
        petOptTitleLabel = NecessarryFieldLabel(textValue: "Pilih Profil ")
        petOptTitleLabel.font = .boldSystemFont(ofSize: 14)
        
        /// add pet option button - profile type
        selectedPetProfile = ProfilePhotoWithTitle(profileType: .pet, img: "dummy-image", title: "Nil", detailName: "-", age: 0)
        
        petOptProfileContent = UIStackView(arrangedSubviews: [selectedPetProfile!])
        petOptProfileContent.translatesAutoresizingMaskIntoConstraints = false
        petOptProfileContent.alignment = .fill
        petOptProfileContent.distribution = .fill
       
        /// add pet option button - default type
        let buttonLabel = UILabel()
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel.text = "Pilih Profil Anabul"
        buttonLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        buttonLabel.tintColor = .black

        let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.image = UIImage(systemName: "plus")
        icon.tintColor = .black
        icon.contentMode = .scaleAspectFit
        
        petOptDefaultContent = UIStackView(arrangedSubviews: [buttonLabel, icon])
        petOptDefaultContent.translatesAutoresizingMaskIntoConstraints = false
        petOptDefaultContent.alignment = .fill
        petOptDefaultContent.distribution = .fill
        
        
        petOptProfileContent.isHidden = true
//        petOptDefaultContent.isHidden = true

        let petOptWrap = UIStackView(arrangedSubviews: [petOptProfileContent, petOptDefaultContent])
        petOptWrap.translatesAutoresizingMaskIntoConstraints = false
        petOptWrap.axis = .vertical
        petOptWrap.alignment = .fill
        petOptWrap.distribution = .fill
        
        petOpt = UIView()
        petOpt.translatesAutoresizingMaskIntoConstraints = false
        petOpt.layer.borderWidth = 1
        petOpt.layer.borderColor = UIColor.customLightGray3.cgColor
        petOpt.layer.cornerRadius = 4
        
        petOpt.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(petOptTapped)))

        petOpt.addSubview(petOptWrap)
        NSLayoutConstraint.activate([
            petOptWrap.topAnchor.constraint(equalTo: petOpt.topAnchor, constant: 10),
            petOptWrap.bottomAnchor.constraint(equalTo: petOpt.bottomAnchor, constant: -10),
            petOptWrap.leadingAnchor.constraint(equalTo: petOpt.leadingAnchor, constant: 16),
            petOptWrap.trailingAnchor.constraint(equalTo: petOpt.trailingAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            icon.heightAnchor.constraint(equalToConstant: 24),
            icon.widthAnchor.constraint(equalToConstant: 24),
        ])
        
        let content = createStack(views: [petOptTitleLabel, petOpt], spacing: 7)
        cellContent.addArrangedSubview(content)
        cellContent.addArrangedSubview(addSeparator())
        
    }
    
    private func setCageOption() {
        cageOptTitleLabel = NecessarryFieldLabel(textValue: "Kandang")
        cageOptTitleLabel.font = .boldSystemFont(ofSize: 14)
        
        let cages = ReservationManager.shared.reservationModel!.cages
        
//        let smallCage = CageOption(name: "Kandang Kecil", price: 30000)
//        smallCage.idx = 0
//
//        let largeCage = CageOption(name: "Kandang Besar", price: 20000)
//        largeCage.idx = 1
//
//        smallCage.delegate = self
//        largeCage.delegate = self
        allCageOpt = []
        
        var idx = 0
        for cage in cages {
            let option =  CageOption(name: cage.name, price: cage.price)
            option.idx = idx
            idx += 1;
            option.delegate = self
            allCageOpt.append(option)
        }
        
        let allCageOptStack = createStack(views: allCageOpt, spacing: 16)
        let content = createStack(views: [cageOptTitleLabel, allCageOptStack], spacing: 7)
        
        cellContent.addArrangedSubview(content)
        cellContent.addArrangedSubview(addSeparator())
        
    }
    
    private func setAddOnOption() {
        addOnOptTitleLabel = createLabel("Add-on Service")
        addOnOptTitleLabel.font = .boldSystemFont(ofSize: 14)
//        let services = ["Grooming","Pick Up", "Pet Food"]
        let services = ReservationManager.shared.reservationModel!.services
        let allServiceOpt = createStack(views: [], spacing: 16)
        var idx = 0
        for service in services {
            let option = AddOnServiceOption(name: service.name, price: service.price)
            option.idx = idx
            idx += 1;
            option.delegate = self
            
            allServiceOpt.addArrangedSubview(option)
        }
        let content = createStack(views: [addOnOptTitleLabel, allServiceOpt], spacing: 7)
        
        cellContent.addArrangedSubview(content)
        cellContent.addArrangedSubview(addSeparator())
        
    }
    
    private func setMessage() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
        
        messageTitleLabel = createLabel("Tulis Pesan")
        messageTitleLabel.font = .boldSystemFont(ofSize: 14)
        
        messageTextField = UITextView()
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        messageTextField.isScrollEnabled = false
        messageTextField.isEditable = true
        
        messageTextField.layer.cornerRadius = 8
        messageTextField.backgroundColor = UIColor.customLightGray3
        messageTextField.textContainerInset = UIEdgeInsets(top: 13, left: 16, bottom: 13, right: 16)
        
        messageTextField.text = placeholderText
        messageTextField.textColor = UIColor.customLightGray
        messageTextField.textAlignment = .left
        messageTextField.font = .systemFont(ofSize: 14, weight: .regular)
        messageTextField.textContainer.maximumNumberOfLines = 5
        messageTextField.textContainer.lineBreakMode = .byTruncatingTail
        
        messageTextField.delegate = self
        
        // Observe the contentSize property
        messageTextField.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        cellContent.addArrangedSubview(messageTitleLabel)
    }
    
    private func findCellIndexPath() -> IndexPath? {
        guard let collectionView = superview as? UICollectionView else {
            return nil
        }
        return collectionView.indexPath(for: self)
    }
    
    // MARK: Selectors
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        /// Check if the tap occurred outside the UITextView
        if !messageTextField.bounds.contains(sender.location(in: messageTextField)) {
            /// End editing for the UITextView, which will dismiss the keyboard
            messageTextField.endEditing(true)
        }
    }
    
    @objc func petOptTapped(gesture:UITapGestureRecognizer){
        UIView.animate(withDuration: 0.1, animations: {
            self.petOpt.backgroundColor = UIColor.customLightGray3
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.petOpt.backgroundColor = UIColor.clear
            }
        }
        
        if let indexPath = findCellIndexPath() {
            selectedPetProfileIndexPath = indexPath
            delegate?.petOptTapped(cell: self, atIndexPath: indexPath)
        } else {
            print("Unable to determine indexPath for the cell.")
        }
    }
}

// MARK: RADIO BUTTON
extension PetOrderCollectionViewCell: CageOptionDelegate {
    func radioButtonTapped(idx: Int, priceWithAmount: PriceWithAmount) {
        /// Appearance
        let endIndex = ReservationManager.shared.reservationModel.cages.count
        for i in 0..<endIndex {
            if i != idx {
                allCageOpt[i].isClicked = false
                allCageOpt[i].deactivateButton()
            }
        }
        
        /// Price Calculation
        if let indexPath = findCellIndexPath() {
            
            if priceWithAmount.amount == 1 {
                cagePrice = priceWithAmount.price
            } else {
                cagePrice = 0
            }
            ReservationManager.shared.updateCatDefaultPrices(indexPath: indexPath, price: cagePrice)
            delegate?.cageOptTapped(cell: self, atIndexPath: indexPath)

        } else {
            print("Unable to determine indexPath for the cell.")
        }
    }
}

// MARK: CHECK BOX
extension PetOrderCollectionViewCell: AddOnServiceOptionDelegate {
    func checkboxTapped(idx: Int, priceWithAmount: PriceWithAmount) {
        if let indexPath = findCellIndexPath() {
            
            if priceWithAmount.amount == 1 {
                addOnServicePrice = addOnServicePrice + priceWithAmount.price
            } else if priceWithAmount.amount == 0 && addOnServicePrice > 0 {
                addOnServicePrice = addOnServicePrice - priceWithAmount.price
            }
            ReservationManager.shared.updateCatAddOnServicePrices(indexPath: indexPath, price: addOnServicePrice)
            delegate?.serviceOptTapped(cell: self, atIndexPath: indexPath)

        } else {
            print("Unable to determine indexPath for the cell.")
        }
    }
}

// MARK: PET OPTION SHEET
extension PetOrderCollectionViewCell: PetOptionSheetViewControllerDelegate {
    func petProfileItemTapped(cell: UITableViewCell, atIdxPath: IndexPath) {
        
//        print(cell)
        if let petOptionCell = cell as? PetOptionTableViewCell {
            
            // Your code when the cell is of type PetOptionTableViewCell
            updatePetProfile(profile: petOptionCell.profile)

            self.petOptDefaultContent.isHidden = true
            self.petOptProfileContent.isHidden = false
            
//            print(petOptionCell.profileTag)
//            if !self.petOptDefaultContent.isHidden {
//                self.petOptDefaultContent.isHidden = true
//                self.petOptProfileContent.isHidden = false
//            }
//            else {
//                self.petOptDefaultContent.isHidden = false
//                self.petOptProfileContent.isHidden = true
//            }
            print("profile at: \(atIdxPath)")
        } else {
            // Handle the case when the cell is not of type PetOptionTableViewCell
            print("Error: cell is not of type PetOptionTableViewCell")
        }
        

    }
    
}

// MARK: TEXTVIEW
extension PetOrderCollectionViewCell: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.customLightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = UIColor.customLightGray
            print("empty")
        }
    }
    
    // MARK: Delegate
    /// Implement the observer's method to handle changes in contentSize
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            /// Update the text view's height to match the content size
            if let newContentSize = change?[.newKey] as? CGSize {
                messageTextField.frame.size = newContentSize
            }
        }
    }
}

// MARK: UI Creation
extension PetOrderCollectionViewCell {
    private func createLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = text
        label.textColor = .black
        return label
    }
    private func createStack(views: [UIView], spacing: Double) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: views)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = spacing
        return stack
    }
    
    private func addSeparator() -> UIImageView{
        let image = UIImageView(image: UIImage(named: "separator")?.withTintColor(.customLightGray3))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode =  .scaleAspectFill
        return image
    }
}
