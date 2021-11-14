//
//  SearchViewController.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 19.09.2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    
    let searchViewModel : SearchViewModel = {
        return Injector.shared.injectSearchViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSearchView()
        
    }
    
    private func setUpSearchView() {
        searchTextField?.layer.masksToBounds = true
        searchTextField.layer.borderWidth = 0.2
        searchTextField?.clipsToBounds = true
        searchTextField?.layer.cornerRadius = 24
        
        searchTextField.keyboardType = .default
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 30))
        searchTextField.leftView = paddingView
        searchTextField.rightView = paddingView
        searchTextField.leftViewMode = .always
        searchTextField.rightViewMode = .always
    }
    
    
    @IBAction func onSearchChanged(_ sender: UITextField) {
        
        if let text = sender.text {
            searchUniversityWith(name : text)
        }
        
    }
    
    private func searchUniversityWith(name: String){
        searchViewModel.onSearchTextChanged(to: name)
    }
}
