//
//  UniversityListViewController.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 19.09.2021.
//

import UIKit
import Kingfisher
import Swinject

class UniversityListViewController: UIViewController {
    private var source : [UniversityListItem] = []
    
    @IBOutlet weak var universityListTableView: UITableView!
    
    private lazy var progressIndicator :UIActivityIndicatorView = {
        createProgressIndicator()
    }()
    
    
    let viewModel : UniversityListViewModel = {
        return Injector.shared.injectUniversityListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        setUpObservers()
    
        let unib = UINib(nibName: TableViewCell.indentifier, bundle: nil)
        universityListTableView.register(unib, forCellReuseIdentifier: TableViewCell.indentifier)
        universityListTableView.delegate = self
        universityListTableView.dataSource = self
        universityListTableView.rowHeight = UITableView.automaticDimension
        universityListTableView.separatorStyle = .none
        
        self.view.addSubview(self.progressIndicator)
        self.progressIndicator.center = self.view.center
        
        
    }
    
    func setUpObservers() {
        viewModel.universityList.observe(on: self) { universityList in
            
            switch universityList {
                case .Error(let error):
                    break
                case .Loading:
                    print("load ")
                   
                    if self.viewModel.getCurrentPageNumber() == 1 {
                        self.universityListTableView.hide()
                    }
                    
                    self.progressIndicator.show()
                    self.progressIndicator.startAnimating()
                    break
                case .Success(let unilist ):
                    print("loaded success ")
                    self.universityListTableView.show()
                    self.progressIndicator.stopAnimating()
                    self.progressIndicator.hide()
                    self.source.append(contentsOf: unilist.data)
                    self.universityListTableView.reloadData()
                   break
            case .Empty:
                self.viewModel.fetchInitialPage()
            }
            
        
        }
        
        
    }
    
}

extension UniversityListViewController : UITableViewDelegate,UITableViewDataSource{

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
 
        initTableViewCell(
            cell: cell!,
            universityName:source[indexPath.row].name,
            universityCityName: source[indexPath.row].city,
            imageUrl: url!,
            position: indexPath.row
        )
        
        
        return cell!
    }
    
    private func initTableViewCell(cell:TableViewCell,universityName:String,universityCityName:String,imageUrl : URL,position:Int) {
        cell.setItemClickListener(onclickListener: self )
        cell.initWith(universityName:universityName,universityCityName:universityCityName,imageUrl : imageUrl,position:position)

    }
    
}


extension UniversityListViewController : onDidTapItemListener {
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

extension UniversityListViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (universityListTableView.contentSize.height - 100 - scrollView.frame.size.height) {
            if case .Loading =  viewModel.universityList.value {
              
            } else {
                viewModel.fetchNextPage()
            }
            
        }
    }
}
