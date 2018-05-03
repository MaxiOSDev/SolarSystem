//
//  GalleryController.swift
//  SolarSystem
//
//  Created by Max Ramirez on 4/30/18.
//  Copyright © 2018 Max Ramirez. All rights reserved.
//

import UIKit

// This controller used to have the collection view in it. But I couldn't figure out how to smoothy get the datasource to transition the way I wanted it to, so I added in another VC with a fade in transition. I also pass data through preparForSegue.
class GalleryController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    // The client
    let client = NASAClient()
    // Input text stored property from textfield that comes up with keyboard.
    
    var inputText: String = ""
    
    // Custom view created to only come up with keyboard
     var customView: UIView = {
        let accessoryView = UIView(frame: .zero)
        accessoryView.backgroundColor = UIColor.lightGray
        return accessoryView
    }()

    var searchButton: UIButton = {
        let searchButton = UIButton(type: .custom)
        searchButton.setTitle("Search", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.addTarget(self, action: #selector(cancelButtonTapped(sender:)), for: .touchUpInside)
        searchButton.showsTouchWhenHighlighted = true
        return searchButton
    }()
    
    // Textfield that will be inside of customView
     var textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textField.backgroundColor = .white
        textField.borderStyle = .bezel
        
        return textField
    }()
    
    // Temporary text field so I can have it become the first responder and pull up the keyboard.
    var tempTextField = UITextField(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
    
    // Adds the view to the keyboard as the inputAccessoryView
    func addAccessory() {
        customView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        customView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        tempTextField.inputAccessoryView = customView
        customView.addSubview(textField)
        customView.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -100),
            textField.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            searchButton.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: customView.centerYAnchor)
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
            // The textfields text inside the customView is now the tempTextfields text
            self.textField.text = (textField.text ?? "") + string
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldText = textField.text, !textFieldText.isEmpty else { return }
        inputText = textFieldText // For the query in my api call. For example: https://images-api.nasa.gov/search?q=(inputText)
        performSegue(withIdentifier: "searchSegue", sender: self)
        self.textField.text = "" // Then makes text empty string
        tempTextField.resignFirstResponder()
    }
    
    // Passes data with results from api call using that input text.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue" {
            if let navController = segue.destination as? UINavigationController {
                let resultVC = navController.topViewController as! SearchResultController
                client.search(withTerm: inputText) {  result in
                    switch result {
                    case .success(let results):
                    
                        resultVC.dataSource.pageUpdate(with: [results])
                        resultVC.collectionView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}












