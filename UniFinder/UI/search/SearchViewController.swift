//
//  SearchViewController.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 19.09.2021.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var source : [UniversityListItem] = []
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchTableView: UITableView!
    
    let searchViewModel : SearchViewModel = {
        return Injector.shared.injectSearchViewModel()
    }()
    
    
    private lazy var progressIndicator :UIActivityIndicatorView = {
        createProgressIndicator()
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
        
        self.view.addSubview(progressIndicator)
        self.progressIndicator.center = self.view.center
        
        let unib = UINib(nibName: TableViewCell.indentifier, bundle: nil)
        searchTableView.register(unib, forCellReuseIdentifier: TableViewCell.indentifier)
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.rowHeight = UITableView.automaticDimension
        searchTableView.separatorStyle = .none
        
        setObservers()
    }
    
    private func setObservers() {
        searchViewModel.universityList.observe(on: self) { universityListState in
            switch universityListState {
                case .Error(let error):
                    break
                case .Loading:
                    
                    if self.searchViewModel.getCurrentPageNumber() == 1 {
                        self.searchTableView.hide()
                    }
                    
                    self.progressIndicator.show()
                    self.progressIndicator.startAnimating()
                
                    break
                case .Success(let unilist ):
                    self.searchTableView.show()
                    self.progressIndicator.stopAnimating()
                    self.progressIndicator.hide()
                    self.source = unilist.data
                    self.searchTableView.reloadData()
                    break
                case .Empty:
                    self.searchViewModel.onSearchTextChanged(to: "")
                    break
            }
        }
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



extension SearchViewController : UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Constants.UniversityListItemCellIdentifier,for: indexPath
         ) as? TableViewCell

        guard cell != nil  else {
            return UITableViewCell()
        }


        let url = URL(string: source[indexPath.row].imageUrl)
            
        if let url = url  {
            initTableViewCell(
                cell: cell!,
                universityName:source[indexPath.row].name,
                universityCityName: source[indexPath.row].city,
                imageUrl: url,
                position: indexPath.row
            )
        }
        
        


        return cell!
    }
    
    private func initTableViewCell(cell:TableViewCell,universityName:String,universityCityName:String,imageUrl : URL,position:Int) {
        cell.setItemClickListener(onclickListener: self )
        cell.initWith(universityName:universityName,universityCityName:universityCityName,imageUrl : imageUrl,position:position)

    }
    
}


extension SearchViewController : onDidTapItemListener {
    func didtapItem(position:Int?) {
        guard let viewController = storyboard?.instantiateViewController(identifier: "UniversityDetailViewController") as? UniversityDetailViewController else {
            return
        }

        guard position != nil else {
            return
        }

        viewController.universityId = source[position!].id
//        viewController.modalPresentationStyle = .fullScreen

        present(viewController, animated: true , completion: nil)
        
    }
    
}

extension SearchViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (searchTableView.contentSize.height - 100 - scrollView.frame.size.height) {
            if case .Loading =  searchViewModel.universityList.value {

            } else {
                searchViewModel.fetchNextPage()
            }

        }
    }
}
