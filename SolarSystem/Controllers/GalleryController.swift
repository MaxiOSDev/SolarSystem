//
//  GalleryController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 4/30/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

class GalleryController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var dataSource: GalleryDatasource = {
       return GalleryDatasource(collectionView: collectionView)
    }()
    
    let client = NASAClient()
    
     var customView: UIView = {
        let accessoryView = UIView(frame: .zero)
        accessoryView.backgroundColor = .red
        return accessoryView
    }()
    
    var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .custom)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(sender:)), for: .touchUpInside)
        cancelButton.showsTouchWhenHighlighted = true
        return cancelButton
    }()
    
     var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.backgroundColor = .white
        textField.borderStyle = .bezel
        
        return textField
    }()
    
    var tempTextField = UITextField(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/2, height: screenWidth/2)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
        
        customView.backgroundColor = .red
        customView.addSubview(textField)
        textField.inputAccessoryView = customView
        textField.delegate = self
        textField.isEnabled = false
        tempTextField.delegate = self
        self.view.addSubview(tempTextField)
        addAccessory()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        tempTextField.becomeFirstResponder()
    }
    
    
    
    func addAccessory() {
        customView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        customView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        tempTextField.inputAccessoryView = customView
        customView.addSubview(textField)
        customView.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -100),
            textField.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20),
            cancelButton.centerYAnchor.constraint(equalTo: customView.centerYAnchor)
            ])
    }
    
    @objc func cancelButtonTapped(sender: UIButton) {
        tempTextField.resignFirstResponder()
    }
}

extension GalleryController: UITextFieldDelegate, UICollectionViewDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tempTextField {
            self.textField.text = (textField.text ?? "") + string
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldText = textField.text, !textFieldText.isEmpty else { return }
        client.search(withTerm: textFieldText.lowercased()) { [weak self] result in
            switch result {
            case .success(let results):
            self?.dataSource.pageUpdate(with: [results])
            self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        self.textField.text = ""
        tempTextField.resignFirstResponder()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
    
    
}












