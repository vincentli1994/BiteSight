//
//  FavoriteTableViewCell.swift
//  BiteSight
//
//  Created by Tiffany Zhang on 11/26/23.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var imagePhoto: UIImageView!
    var labelName: UILabel!
    var labelPrice: UILabel!
    var labelCategory: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupImagePhoto()
        setupLabelName()
        setupLabelPrice()
        setupLabelCategory()
        
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 1.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupImagePhoto() {
        imagePhoto = UIImageView()
        imagePhoto.tintColor = .black
        imagePhoto.contentMode = .scaleToFill
        imagePhoto.clipsToBounds = true
        imagePhoto.layer.cornerRadius = 10
        imagePhoto.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(imagePhoto)
    }
    
    func setupLabelName() {
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 16)
        labelName.sizeToFit()
        
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func setupLabelPrice() {
        labelPrice = UILabel()
        labelPrice.font = UIFont.systemFont(ofSize: 16)
        labelPrice.sizeToFit()
        
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelPrice)
    }
    
    func setupLabelCategory() {
        labelCategory = UILabel()
        labelCategory.font = UIFont.systemFont(ofSize: 16)
        labelCategory.numberOfLines = 2
        labelCategory.lineBreakMode = .byTruncatingTail
        
        labelCategory.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelCategory)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -3),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -3),
            wrapperCellView.heightAnchor.constraint(equalToConstant: 120),
            
            imagePhoto.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            imagePhoto.heightAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            imagePhoto.widthAnchor.constraint(equalTo: wrapperCellView.heightAnchor, constant: -20),
            imagePhoto.centerYAnchor.constraint(equalTo: wrapperCellView.centerYAnchor),
            
            labelName.leadingAnchor.constraint(equalTo: imagePhoto.trailingAnchor, constant: 20),
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 22),
            
            labelPrice.leadingAnchor.constraint(equalTo: imagePhoto.trailingAnchor, constant: 20),
            labelPrice.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 11),
            
            labelCategory.leadingAnchor.constraint(equalTo: imagePhoto.trailingAnchor, constant: 20),
            labelCategory.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 11),
            labelCategory.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor, constant: -150),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
