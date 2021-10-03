//
//  UniversityListViewController.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 19.09.2021.
//

import UIKit
import Kingfisher

class UniversityListViewController: UIViewController {
    private var source : [UniversityListItem] = []
    
    @IBOutlet weak var universityListTableView: UITableView!
    
    private let viewModel = UniversityListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.fetchData()
        viewModel.universityList.observe(on: self) { universityList in
            print(universityList)
            self.source = universityList
        }
        
        
        let unib = UINib(nibName: "TableViewCell", bundle: nil)
        universityListTableView.register(unib, forCellReuseIdentifier: "TableViewCell")
        universityListTableView.delegate = self
        universityListTableView.dataSource = self
        universityListTableView.rowHeight = UITableView.automaticDimension
        universityListTableView.separatorStyle = .none
        
   
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
        

        cell?.setItemClickListener(onclickListener: self )
        cell?.universityName.text = source[indexPath.row].name
        cell?.universityCityName.text = source[indexPath.row].city
        let url = URL(string: source[indexPath.row].imageUrl)
        cell?.universityImage?.kf.setImage(with: url)
        print("  " + "\(source[indexPath.row])" + "asdasdsd")
        
        
        
        return cell!
    }
    
}


extension UniversityListViewController : onDidTapItemListener {
    func didtapItem() {
        print("cliclicliciclicliliciclilcicli")
    }
}
