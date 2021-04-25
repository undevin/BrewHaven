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
        configureNavBar()
        configuerSearchBar()
        configureTableView()
    }
    
    // MARK: - Properties
    var breweries: [Brewery] = []
    
    //MARK: - Methods
    func configureViewController() {
        view.addSubview(navigationBar)
        view.addSubview(searchBar)
        view.addSubview(breweryTableView)
        view.backgroundColor = .systemBackground
    }
    
    func configureNavBar() {
        navigationBar.prefersLargeTitles = true
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.isHidden = false
        navigationController?.title = "Breweries"
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 95)
        ])
    }
    
    func configuerSearchBar() {
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func configureTableView() {
        breweryTableView.delegate = self
        breweryTableView.dataSource = self
        breweryTableView.translatesAutoresizingMaskIntoConstraints = false
        breweryTableView.register(BreweryTableViewCell.self, forCellReuseIdentifier: "breweryCell")
        
        NSLayoutConstraint.activate([
            breweryTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            breweryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breweryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            breweryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - Views
    let navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        return navigationBar
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    let breweryTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
}//End of Class

//MARK: - Extensions
extension BreweryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breweries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breweryCell", for: indexPath)// as? BreweryTableViewCell else { return UITableViewCell()}
        let brewery = breweries[indexPath.row]
        cell.textLabel?.text = brewery.name
        
        return cell
    }
}//End of Extension

extension BreweryListViewController: UISearchBarDelegate {
    
    
    
}//End of Extension
