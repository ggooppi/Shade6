//
//  PlantListViewController.swift
//  Shade6
//
//  Created by gopinath.a on 01/09/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import UIKit

class PlantListViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = PlantListViewModel()
    
    // MARK: - UIComponents
    var refreshControl = UIRefreshControl()
    @IBOutlet weak var plantTable: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    // MARK: - UI Functions
    func setupUI() -> Void {
        plantTable.addSubview(refreshControl)
        plantTable.isHidden = true
        activityIndicator.startAnimating()
        refreshControl.addTarget(self, action: #selector(pulledToRefresh), for: UIControl.Event.valueChanged)
        
        fetchData()
    }
    
    // MARK: - Functions
    
    func fetchData() -> Void {
        viewModel.fetchPlantList { (status, error) in
            self.refreshControl.endRefreshing()
            self.activityIndicator.stopAnimating()
            if status{
                self.plantTable.isHidden = false
                self.plantTable.reloadData()
            }else{
                print(error!)
            }
        }
    }
    
    @objc func pulledToRefresh() -> Void {
        fetchData()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let destination = segue.destination as? PlantDetailViewController{
            destination.viewModel.selectedPlantURL = sender as? String ?? ""
        }
    }

}

extension PlantListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.plants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: defaultCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: defaultCellIdentifier)
            
        }
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 17)
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
        
        cell?.textLabel?.text = viewModel.plants[indexPath.row].commonName
        cell?.textLabel?.numberOfLines = 0
        
        cell?.detailTextLabel?.text = viewModel.plants[indexPath.row].scientificName
        cell?.detailTextLabel?.textColor = UIColor.gray
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: goToDetail, sender: viewModel.plants[indexPath.row].link)
    }
    
    
}
