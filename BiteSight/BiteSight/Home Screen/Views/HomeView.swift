//
//  HomeView.swift
//  BiteSight
//
//  Created by (Vincent) GuoWei Li on 11/22/23.
//

import UIKit

class HomeView: UIView {

    var tableViewStores: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableViewStores()
        
        NSLayoutConstraint.activate([
            tableViewStores.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 4),
            tableViewStores.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewStores.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableViewStores.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    func setupTableViewStores(){
        tableViewStores = UITableView()
        tableViewStores.register(HomeTableViewCell.self, forCellReuseIdentifier: Configs.tableViewHomeID)
        tableViewStores.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewStores)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
