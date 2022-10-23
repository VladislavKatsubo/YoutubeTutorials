//
//  FavoriteVCLayout.swift
//  DownloadImageWithAPI
//
//  Created by Vlad Katsubo on 20.10.22.
//

import Foundation
import UIKit

class FavoriteVCLayout: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
        addSubview(tableView)
        tableView.pin(to: self)
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        tableView.rowHeight = 120
        tableView.backgroundColor = .black
    }
}
