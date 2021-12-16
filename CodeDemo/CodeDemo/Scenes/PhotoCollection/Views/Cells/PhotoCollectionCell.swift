//
//  PhotoCollectionCell.swift
//

import UIKit

class PhotoCollectionCell: UITableViewCell {

    // MARK: - Properties
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    static var identifier: String {
        return String(describing: self)
    }

    // MARK: - Outlets
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mediaThumbnailImageView: UIImageView!
    @IBOutlet weak var verticalStackView: UIStackView!

    // MARK: -
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = SelectionStyle.none
        setupViews()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mediaThumbnailImageView?.image = nil
    }

    // MARK: - View Setup
    func setupViews() {
        verticalStackView?.layer.cornerRadius = 5.0
        verticalStackView?.clipsToBounds = true
        verticalStackView?.backgroundColor = UIColor.tileBGColor
        verticalStackView?.layer.borderWidth = 0.4
        verticalStackView?.layer.borderColor = UIColor.borderColor.cgColor

        mediaThumbnailImageView?.layer.borderWidth = 0.2
        mediaThumbnailImageView?.layer.borderColor = UIColor.borderColor.cgColor

        titleLabel.textColor = UIColor.fontColor
    }

    // MARK: - Title
    func updateTitleLabelWithText(title: String?) {
        titleLabel.text = title ?? " Hello"
    }

    // MARK: - Thumbnail
    func updateThumbnailWithImage(imageURL: String?, placeholder: String) {
        if let imageUrlString = imageURL, !imageUrlString.isEmpty {
            mediaThumbnailImageView?.loadRemoteImage(imageUrlString,
                                                     placeHolder: UIImage(named: placeholder))
        } else {
            mediaThumbnailImageView?.image = UIImage(named: placeholder)
        }
    }

}
