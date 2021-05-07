//
//  BreweryTableViewCell.swift
//  BrewHaven
//
//  Created by Devin Flora on 4/20/21.
//

import UIKit

class BreweryTableViewCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addAllSubviews()
        constrainBreweryNameLabel()
        constrainBreweryTypeLabel()
    }
    
    
    // MARK: - Properties
    var brewery: Brewery? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let brewery = brewery else { return }
        breweryNameLabel.text = brewery.name
        breweryTypeLabel.text = brewery.breweryType
    }
    
    func addAllSubviews() {
        self.addSubview(breweryNameLabel)
        self.addSubview(breweryTypeLabel)
    }
    
    // MARK: - Views
    let breweryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    let breweryTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    func constrainBreweryNameLabel() {
        breweryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breweryNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 18),
            breweryNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
        ])
    }
    
    func constrainBreweryTypeLabel() {
        breweryTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breweryTypeLabel.topAnchor.constraint(equalTo: breweryNameLabel.bottomAnchor, constant: 12),
            breweryTypeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            breweryTypeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 18),
        ])
    }
}//End of Class
