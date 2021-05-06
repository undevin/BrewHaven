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
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Properties
    var breweries: [Brewery] = []
    var searchText: String = ""
    let reuseID = "breweryCell"
    
    //MARK: - Methods
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = "BrewHaven"
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
    
    @objc func segmentDidChange(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
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
        case 1:
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
        default:
            print("Stuff happens here")
        }
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
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - Views
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()
    
    let segmentedControl: UISegmentedControl = {
        let segments = ["by State", "by City", "by Name"]
        let segmentedControl = UISegmentedControl(items: segments)
        segmentedControl.addTarget(self, action: #selector(segmentDidChange), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentTintColor = .systemGray5
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
        cell.textLabel?.text = brewery.name
        
        return cell
    }
}//End of Extension

extension BreweryListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        self.searchText = searchText
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
