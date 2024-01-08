//
//  FavoriteView.swift
//  BiteSight
//
//  Created by (Vincent) GuoWei Li on 11/22/23.
//

import UIKit

class FavoriteView: UIView {
    var tableViewFavorites: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupTableViewFavorites()
        
        initConstraints()
    }
    
    func setupTableViewFavorites() {
        tableViewFavorites = UITableView()
        tableViewFavorites.backgroundColor = .white
        tableViewFavorites.register(FavoriteTableViewCell.self, forCellReuseIdentifier: Configs.tableViewFavoriteID)
        tableViewFavorites.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewFavorites)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            tableViewFavorites.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableViewFavorites.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewFavorites.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            tableViewFavorites.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
