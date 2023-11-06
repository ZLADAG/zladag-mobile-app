//
//  PetAditionalInfoView.swift
//  MacroZladagApp
//
//  Created by Celine Margaretha on 05/11/23.
//

import UIKit

class PetAditionalInfoView: UIView {

    private var contentStack: UIStackView!
    
    // MARK: Initialize Methods
    init() {
        super.init(frame: .zero)
        setUpComponents()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpComponents() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        
        /// Facility preference
        let facilityTitle = ProfileIconLabel(iconName: "facility-grooming-icon", titleName: "Preferensi Fasilitas", type: .menu)
        let facilityContent = setUpFacilityPreference()
        
        let facilityStack = UIStackView(arrangedSubviews: [facilityTitle, facilityContent])
        facilityStack.translatesAutoresizingMaskIntoConstraints = false
        facilityStack.axis = .vertical
        facilityStack.alignment = .fill
        facilityStack.distribution = .fill
        facilityStack.spacing = 16

        
        /// Habits
        let habits = ["Agresif dengan kucing lain", "Bersahabat dengan anjing lain", "Vokal", "Sulit beradaptasi", "Mudah cemas"]
        let habitsTitle = ProfileIconLabel(iconName: "facility-grooming-icon", titleName: "Preferensi Fasilitas", type: .menu)
        let habitsContent =  setUpHabits(habits)
        
        let habitsStack = UIStackView(arrangedSubviews: [habitsTitle, habitsContent])
        habitsStack.translatesAutoresizingMaskIntoConstraints = false
        habitsStack.axis = .vertical
        habitsStack.alignment = .fill
        habitsStack.distribution = .fill
        habitsStack.spacing = 16
        
        /// Disease history
        let diseaseHist = "Punya asthma dan harus dikasih inhaler setiap hari selama 10 detik"
        
        let diseaseHistTitle = ProfileIconLabel(iconName: "habits-icon", titleName: "Preferensi Fasilitas", type: .menu)

        let diseaseHistStack = UIStackView(arrangedSubviews: [diseaseHistTitle])
        diseaseHistStack.translatesAutoresizingMaskIntoConstraints = false
        diseaseHistStack.axis = .vertical
        diseaseHistStack.alignment = .fill
        diseaseHistStack.distribution = .fill
        diseaseHistStack.spacing = 16
        
        if diseaseHist != "" {
            let diseaseHistContent = createFreeText(createFreeTextItalic(diseaseHist))
            diseaseHistStack.addArrangedSubview(diseaseHistContent)
        } else {
            let label = createLabel("Tidak ada")
            diseaseHistStack.addArrangedSubview(label)
        }
        
        contentStack = UIStackView(arrangedSubviews: [facilityStack, habitsStack, diseaseHistStack])
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        contentStack.axis = .vertical
        contentStack.alignment = .fill
        contentStack.distribution = .fill
        contentStack.spacing = 32
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        self.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            contentStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            contentStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),

        ])
    }
    
    
    private func setUpFacilityPreference() -> UIStackView {
        
        let playground = true
        let ac = true
        let cctv = true
        let food = true
        let delivery = true
        let groom = true
        let veterinary = true
        
        var facilityItems: [UIView] = []
        
        if playground{
            let playground = ProfileIconLabel(iconName: "facility-playground-icon", titleName: "Tempat Bermain", type: .facilityTag)
            facilityItems.append(playground)
        }
        if ac {
            let ac = ProfileIconLabel(iconName: "facility-ac-icon", titleName: "Ruangan ber-AC", type: .facilityTag)
            facilityItems.append(ac)
        }
        if cctv {
            let cctv = ProfileIconLabel(iconName: "facility-cctv-icon", titleName: "CCTV", type: .facilityTag)
            facilityItems.append(cctv)
        }
        
        if food {
            let petFood = ProfileIconLabel(iconName: "facility-petFood-icon", titleName: "Termasuk Makanan", type: .facilityTag)
            facilityItems.append(petFood)
        }
        if delivery {
            let delivery = ProfileIconLabel(iconName: "facility-pickUp-icon", titleName: "Jasa Antar Jemput", type: .facilityTag)
            facilityItems.append(delivery)
        }
        if groom {
            let grooming = ProfileIconLabel(iconName: "facility-grooming-icon", titleName: "Termasuk Grooming", type: .facilityTag)
            facilityItems.append(grooming)
        }
        if  veterinary {
            let vet = ProfileIconLabel(iconName: "facility-vet-icon", titleName: "Tersedia Dokter Hewan", type: .facilityTag)
            facilityItems.append(vet)
        }
        
        var stack : UIStackView
        
        if facilityItems.isEmpty {
            let label = createLabel("Tidak ada")
            stack = UIStackView(arrangedSubviews: [label])
        } else {
            stack = UIStackView(arrangedSubviews: facilityItems)
        }
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .firstBaseline
        stack.distribution = .fillProportionally
        stack.spacing = 16

       
        
        return stack
    }
    private func setUpHabits(_ habits: [String]) -> UIStackView {
        let habits = ["Agresif dengan kucing lain", "Bersahabat dengan anjing lain", "Vokal", "Sulit beradaptasi", "Mudah cemas"]
//        let habits: [String] = []
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .firstBaseline
        stack.distribution = .fillProportionally
        stack.spacing = 8
        
        if habits.isEmpty {
            let label = createLabel("Tidak ada")
            stack.addArrangedSubview(label)
        } else {
            for habit in habits {
                let tag = createFreeText(createFreeTextLabel(habit))
                stack.addArrangedSubview(tag)
            }
        }
        
        return stack
    }
    
    private func createFreeText(_ label: UILabel) -> UIView {
        
        let labelWrapper = UIView()
        labelWrapper.translatesAutoresizingMaskIntoConstraints = false
        
        labelWrapper.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: labelWrapper.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: labelWrapper.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: labelWrapper.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: labelWrapper.trailingAnchor, constant: -8),
        ])
        labelWrapper.backgroundColor = .customLightGray3
        return labelWrapper
    }
    private func createFreeTextItalic (_ text: String) -> UILabel {
        let label = createFreeTextLabel(text)
        label.font = UIFont.italicSystemFont(ofSize: 14)
        return label
    }
    private func createFreeTextLabel (_ text: String) -> UILabel {
        let label = createLabel(text)
        label.textColor = .black
        return label
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
