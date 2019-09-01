//
//  PlantDetailViewController.swift
//  Shade6
//
//  Created by gopinath.a on 02/09/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import UIKit

class PlantDetailViewController: UIViewController {

    // MARK: - Properties
    let viewModel = PlantDetailViewModel()
    
    // MARK: - UIComponents
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    // MARK: - UI Functions
    func setupUI() -> Void {
        detailTableView.addSubview(refreshControl)
        detailTableView.isHidden = true
        
        detailTableView.register(UINib(nibName: plantHeaderTableViewCell , bundle: nil), forCellReuseIdentifier: plantHeaderTableViewCellIdentifier)
        detailTableView.register(UINib(nibName: plantDetailTableViewCell , bundle: nil), forCellReuseIdentifier: plantDetailTableViewCellIdentifier)
        
        activityIndicator.startAnimating()
        refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: UIControl.Event.valueChanged)
        
        fetchData()
    }
    
    // MARK: - Functions
    
    func fetchData() -> Void {
        
        viewModel.fetchPlantDetail { (status, error) in
            self.refreshControl.endRefreshing()
            self.activityIndicator.stopAnimating()
            if status{
                self.detailTableView.isHidden = false
                self.detailTableView.reloadData()
            }else{
                print(error!)
            }
        }
    }
    
    @objc func pulledToRefresh() -> Void {
        fetchData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlantDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: plantHeaderTableViewCellIdentifier, for: indexPath) as! PlantHeaderTableViewCell
            cell.setup(imageURL: viewModel.plantsDetail.images.first?.url ?? "")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: plantDetailTableViewCellIdentifier, for: indexPath) as! PlantDetailTableViewCell
            switch indexPath.row{
            case 0:
                cell.setup(type: .about, data: viewModel.plantsDetail)
            case 1:
                cell.setup(type: .specification, data: viewModel.plantsDetail)
            default:
                 print("default")
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? PlantDetailTableViewCell{
            cell.complitionHandler = {
                cell.showOrHideContent()
                let number = tableView.numberOfRows(inSection: 1)
                for i in 0..<number{
                    if i != indexPath.row{
                        if let cellAtIndex = tableView.cellForRow(at: IndexPath(row: i, section: 1)) as? PlantDetailTableViewCell{
                            cellAtIndex.showOrHideContent(showContent: false)
                        }
                        
                    }
                }
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24
    }
    
    
}
