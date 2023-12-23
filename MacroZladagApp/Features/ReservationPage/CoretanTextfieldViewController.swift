//
//  CoretanTextfieldViewController.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 21/12/23.
//

import UIKit

class CoretanTextfieldViewController: UIViewController {

    let textView = ReservationTextView()
    let button = UIButton()
    var data: String = ""
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIdx, _ in
            
            let cellHeight: CGFloat = 300
            let verticalPadding: CGFloat = 12
            
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(cellHeight + verticalPadding)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: verticalPadding, trailing: 0)
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(cellHeight + verticalPadding)
                ),
                subitems: [item]
            )
            
            let section = NSCollectionLayoutSection(group: group)
            return section
            
        }
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
//        setupCollectionView()
        setupTextView()
    }
    
    private func setupTextView() {
        view.addSubview(textView)
        view.addSubview(button)
        
        button.backgroundColor = .red
        button.setTitle("haha", for: .normal)
        button.addTarget(self, action: #selector(onClickButton), for: .touchUpInside)
        
        textView.delegate = self
        
        button.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            textView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 50),
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.widthAnchor.constraint(equalToConstant: 340),
            textView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    @objc private func onClickButton() {
        print("DATA:")
        print(self.data)
        
        textView.resignFirstResponder()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .customLightGray3
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // CARD CELL
        collectionView.register(CoretanTextfieldCollectionViewCell.self, forCellWithReuseIdentifier: CoretanTextfieldCollectionViewCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44 + 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension CoretanTextfieldViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoretanTextfieldCollectionViewCell.identifier, for: indexPath) as! CoretanTextfieldCollectionViewCell
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
}

extension CoretanTextfieldViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing")
    }
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("textViewShouldBeginEditing")
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("textViewDidChange")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(text)
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("textViewDidEndEditing: \(textView.text)")
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {

        print("textViewShouldEndEditing: \(textView.text)")
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        print("textViewDidChangeSelection")
    }
    
    
    
}
