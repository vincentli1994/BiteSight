import UIKit
import FirebaseAuth
import FirebaseFirestore

class HomeTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var restaurantImageView: UIImageView!
    var labelName: UILabel!
    var labelAddress: UILabel!
    var labelCategory: UILabel!
    var labelPrice: UILabel!
    var likeButton: UIButton!
    var business: Business!
    let db = Firestore.firestore()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupRestaurantImageView()
        setupLabelName()
        setupLabelAddress()
        setupLabelCategory()
        setupLabelPrice()
        setupLikeButton()
        
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupWrapperCellView() {
        wrapperCellView = UIView()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(wrapperCellView)
    }
    
    private func setupRestaurantImageView() {
        restaurantImageView = UIImageView()
        restaurantImageView.contentMode = .scaleAspectFill
        restaurantImageView.clipsToBounds = true
        restaurantImageView.layer.cornerRadius = 6.0
        restaurantImageView.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(restaurantImageView)
    }
    
    private func setupLabelName() {
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 16)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    private func setupLabelAddress() {
        labelAddress = UILabel()
        labelAddress.font = UIFont.systemFont(ofSize: 14)
        labelAddress.textColor = .gray
        labelAddress.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelAddress)
    }
    
    private func setupLabelCategory() {
        labelCategory = UILabel()
        labelCategory.font = UIFont.systemFont(ofSize: 14)
        labelCategory.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelCategory)
    }
    
    private func setupLabelPrice() {
        labelPrice = UILabel()
        labelPrice.font = UIFont.systemFont(ofSize: 14)
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelPrice)
    }
    
    private func setupLikeButton() {
        likeButton = UIButton(type: .system)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .lightGray
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(likeButton)
    }
    
    private func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            restaurantImageView.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor),
            restaurantImageView.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor),
            restaurantImageView.topAnchor.constraint(equalTo: wrapperCellView.topAnchor),
            restaurantImageView.heightAnchor.constraint(equalToConstant: 200), // This height will be adjusted as per your design
            
            labelName.topAnchor.constraint(equalTo: restaurantImageView.bottomAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelName.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -50), // Space for like button
            
            labelCategory.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 4),
            labelCategory.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelCategory.trailingAnchor.constraint(equalTo: labelName.trailingAnchor),
            
            labelAddress.topAnchor.constraint(equalTo: labelCategory.bottomAnchor, constant: 4),
            labelAddress.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelAddress.trailingAnchor.constraint(equalTo: labelName.trailingAnchor),
            
            labelPrice.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 4),
            labelPrice.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelPrice.trailingAnchor.constraint(equalTo: labelName.trailingAnchor),
            labelPrice.bottomAnchor.constraint(lessThanOrEqualTo: wrapperCellView.bottomAnchor, constant: -8),
            
            likeButton.topAnchor.constraint(equalTo: restaurantImageView.bottomAnchor, constant: 8),
            likeButton.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
