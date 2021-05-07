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
        return label
    }()
    
    let breweryTypeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    func constrainBreweryNameLabel() {
        NSLayoutConstraint.activate([
            breweryNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 18),
            breweryNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            breweryNameLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func constrainBreweryTypeLabel() {
        NSLayoutConstraint.activate([
            breweryTypeLabel.topAnchor.constraint(equalTo: breweryNameLabel.bottomAnchor, constant: 12),
            breweryTypeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            breweryTypeLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}//End of Class
