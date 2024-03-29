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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Properties
    var breweries: [Brewery] = []
    let reuseID = "breweryCell"
    var selectedIndex = 0
    
    //MARK: - Methods
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "BrewHaven"
        view.addSubview(searchBar)
        view.addSubview(segmentedControl)
        view.addSubview(breweryTableView)
        configuerSearchBar()
        configureSegmentedControl()
        configureTableView()
    }
    
    func configuerSearchBar() {
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search for breweries..."
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureSegmentedControl() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func configureTableView() {
        breweryTableView.delegate = self
        breweryTableView.dataSource = self
        breweryTableView.translatesAutoresizingMaskIntoConstraints = false
        breweryTableView.register(BreweryTableViewCell.self, forCellReuseIdentifier: reuseID)
        
        NSLayoutConstraint.activate([
            breweryTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            breweryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breweryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            breweryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func resetTableView() {
        breweries.removeAll()
        self.breweryTableView.reloadData()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    @objc func segmentDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            selectedIndex = 0
            resetTableView()
        case 1:
            selectedIndex = 1
            resetTableView()
        default:
            selectedIndex = 2
            resetTableView()
        }
    }
    
    //MARK: - Views
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.autocapitalizationType = .none
        return searchBar
    }()
    
    let segmentedControl: UISegmentedControl = {
        let segments = ["by State", "by City", "by Name"]
        let segmentedControl = UISegmentedControl(items: segments)
        segmentedControl.addTarget(self, action: #selector(segmentDidChange), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentTintColor = .systemGray3
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? BreweryTableViewCell else { return UITableViewCell()}
        let brewery = breweries[indexPath.row]
        cell.brewery = brewery
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BreweryDetailViewController()
        vc.brewery = breweries[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}//End of Extension

extension BreweryListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        if selectedIndex == 0 {
            BreweryController.fetchByState(searchTerm: searchText) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let breweries):
                        self?.breweries = breweries
                        self?.breweryTableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        } else if selectedIndex == 1 {
            BreweryController.fetchByCity(searchTerm: searchText) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let breweries):
                        self?.breweries = breweries
                        self?.breweryTableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        } else {
            BreweryController.fetchByName(searchTerm: searchText) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let breweries):
                        self?.breweries = breweries
                        self?.breweryTableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
}//End of Extension
