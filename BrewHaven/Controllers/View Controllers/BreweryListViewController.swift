//
//  BreweryListViewController.swift
//  BrewHaven
//
//  Created by Devin on 4/20/21.
//

import UIKit

class BreweryListViewController: UIViewController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    // MARK: - Properties
    var breweries: [Brewery] = []
    var tableView: UITableView!
    
    //MARK: - Methods
    func configureViewController() {
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        tableView.backgroundColor = .systemRed
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BreweryTableViewCell.self, forCellReuseIdentifier: "breweryCell")
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}//End of Class

//MARK: - Extensions
extension BreweryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breweries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "breweryCell", for: indexPath) as? BreweryTableViewCell else { return UITableViewCell()}
        
        
        return cell
    }
}//End of Extension
