//
//  ProfilePetListDetailsViewController.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 03/11/23.
//

import UIKit




class ProfilePetListDetailsViewController: UIViewController,  UIScrollViewDelegate {
    enum InfoContentType {
        case facilities
        case habits
        case diseasesHist
    }
    
    var petProfile : PetProfileDetails!
    
    private var facilityCollection = PetFacilityPrefCollectionViewController()
    private var habitsCollection = PetHabitsCollectionViewController()
    private var facilityContent: UIView!
    private var habitsContent: UIView!
    private var scrollView: UIScrollView!
    private var contentStack: UIStackView!

    private var editProfile: ProfileArrowMenu!
    
    var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .customLightGray3
        setUpComponents()
    }
    
    private func setUpComponents() {
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false // Enable auto layout
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.scrollsToTop = false
        
        /// Photo
        let photoName = "dummy-image"
        photo = createImage(photoName)
        
        let petBiodata = PetBiodataView(petProfile: petProfile)
        let petInfo = createPetInfo()
        editProfile = addEditProfile()
        
        contentStack = UIStackView(arrangedSubviews: [petBiodata, petInfo, editProfile])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.distribution = .fill
        contentStack.spacing = 8
        
        setUpConstraint()
    }
    
    private func setUpConstraint() {
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        scrollView.addSubview(photo)
        NSLayoutConstraint.activate([
            photo.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            photo.heightAnchor.constraint(equalToConstant: 272),
            
            photo.topAnchor.constraint(equalTo: scrollView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            photo.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
        ])
        
        scrollView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 0),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
        ])
        
    }
    
    private func addEditProfile() -> ProfileArrowMenu {
        /// Profile menu
        let profileMenu = ProfileIconLabel(iconName: "settings-icon", titleName: "Edit Profile", type: .menu)
        
        /// tap gesture
        let profileSettingTapGesture = UITapGestureRecognizer()
        profileSettingTapGesture.addTarget(self, action: #selector(arrowMenuBtnTapped(gesture:)))
        
        let profileArrowMenu = ProfileArrowMenu(contentMenu: profileMenu, yPadding: 16.0)
        profileArrowMenu.backgroundColor = .white
        profileArrowMenu.addGestureRecognizer(profileSettingTapGesture)
        
        return profileArrowMenu
    }
    
    private func createImage(_ imgName:String) -> UIImageView {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = UIImage(named: imgName)
        imageView.contentMode = .scaleAspectFill
        
        imageView.clipsToBounds = true
        return imageView
    }
    
    @objc func arrowMenuBtnTapped(gesture:UITapGestureRecognizer){
        // Define the clicked effect
        UIView.animate(withDuration: 0.1, animations: {
            self.editProfile.backgroundColor = UIColor.customLightGray3
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.editProfile.backgroundColor = UIColor.white
            }
        }
        
        print("arrowMenuBtnTapped")
    }
    
    
}


extension ProfilePetListDetailsViewController {
   
    private func createPetInfo() -> UIView {
        /// Facility preference
        let facilityTitle = ProfileIconLabel(iconName: "facility-grooming-icon", titleName: "Preferensi Fasilitas", type: .menu)
        
        if petProfile.boardingFacilities.isEmpty {
            facilityContent = createLabel("Tidak ada")
        } else {
            addPetFacilityCollection()
        }
        let facilityStack = createInfoContentStack(
            content: [facilityTitle, facilityContent],
            spacing: 16
        )
        
        /// Habits
        let habitsTitle =  ProfileIconLabel(iconName: "facility-grooming-icon", titleName: "Kebiasaan", type: .menu)

        if petProfile.petHabits.isEmpty {
            habitsContent = createLabel("Tidak ada")
        } else {
            addPetHabitsCollection()
        }
        
        let habitsStack = createInfoContentStack(
            content: [habitsTitle, habitsContent],
            spacing: 16
        )
        
        /// Disease history
        let historyOfIllness = petProfile.historyOfIllness
//        historyOfIllness = ""
        let historyOfIllnessTitle = ProfileIconLabel(iconName: "habits-icon", titleName: "Riwayat Penyakit", type: .menu)
        var historyOfIllnessContent: UIView!

        if historyOfIllness == "" || historyOfIllness == nil {
            historyOfIllnessContent = createLabel("Tidak ada")
        } else {
            historyOfIllnessContent = createItalicFreeText(historyOfIllness!)
        }
        
      
        
        let historyOfIllnessStack = createInfoContentStack(
            content: [historyOfIllnessTitle, historyOfIllnessContent],
            spacing: 16
        )
        
        let stack = createInfoContentStack(content: [facilityStack, habitsStack, historyOfIllnessStack], spacing: 32)
        
        let wrapView = UIView()
        wrapView.translatesAutoresizingMaskIntoConstraints = false
        wrapView.addSubview(stack)
        wrapView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: wrapView.topAnchor, constant: 24),
            stack.bottomAnchor.constraint(equalTo: wrapView.bottomAnchor, constant: -24),
            stack.leadingAnchor.constraint(equalTo: wrapView.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: wrapView.trailingAnchor, constant: -24),
            
        ])
        return wrapView
    }
    
    private func addPetFacilityCollection() {
        addChild(facilityCollection)
        facilityCollection.facilitiesPref = petProfile.boardingFacilities
        
        facilityContent = UIView()
        facilityContent.addSubview(facilityCollection.view)
        facilityContent.bounds = facilityCollection.view.frame

        facilityCollection.view.translatesAutoresizingMaskIntoConstraints = false
        facilityCollection.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            facilityCollection.view.topAnchor.constraint(equalTo: facilityContent.topAnchor),
            facilityCollection.view.bottomAnchor.constraint(equalTo: facilityContent.bottomAnchor),
            facilityCollection.view.leadingAnchor.constraint(equalTo: facilityContent.leadingAnchor),
            facilityCollection.view.trailingAnchor.constraint(equalTo: facilityContent.trailingAnchor),
        ])
    }
    
    private func addPetHabitsCollection() {
        addChild(habitsCollection)
        habitsCollection.habits = petProfile.petHabits

        habitsContent = UIView()
        habitsContent.addSubview(habitsCollection.view)
        habitsContent.bounds = habitsCollection.view.frame
        
        habitsCollection.view.translatesAutoresizingMaskIntoConstraints = false
        habitsCollection.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            habitsCollection.view.topAnchor.constraint(equalTo: habitsContent.topAnchor),
            habitsCollection.view.bottomAnchor.constraint(equalTo: habitsContent.bottomAnchor),
            habitsCollection.view.leadingAnchor.constraint(equalTo: habitsContent.leadingAnchor),
            habitsCollection.view.trailingAnchor.constraint(equalTo: habitsContent.trailingAnchor),
        ])
    }
    
    private func createInfoContentStack(content: [UIView], spacing: Double) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: content)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = spacing
        
        return stack
    }
    private func createItalicFreeText(_ text: String) -> UIView {
        let label = createLabel(text)
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = .black
        
        let labelWrapper = UIView()
        labelWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        labelWrapper.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: labelWrapper.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: labelWrapper.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: labelWrapper.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: labelWrapper.trailingAnchor, constant: -8),
        ])
        labelWrapper.layer.cornerRadius = 4
        labelWrapper.backgroundColor = .customLightGray3
        return labelWrapper
    }
    private func createLabel (_ text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        /// wrap label fit text length
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        
        label.font = .systemFont(ofSize: 14, weight: .medium)

        label.text = text
        label.textColor = .gray
        label.numberOfLines = 0
        
        return label
    }
}
