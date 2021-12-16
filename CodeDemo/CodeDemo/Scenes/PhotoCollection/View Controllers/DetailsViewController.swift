//
//  DetailsViewController.swift
//

import UIKit

class DetailsViewController: UIViewController, Storyboardable {

    // MARK: - Properties
    var detailsViewModel: DetailsViewModel!

    // MARK: - Outlets
    @IBOutlet weak var photographerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mediaImageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPhotoDetailsView()
    }

    // MARK: - Setups
    func setupViews() {
        view.backgroundColor = UIColor.backgroundColor

    }

    func setupPhotoDetailsView() {
        guard let imageurl = detailsViewModel.detailsItem?.src.original else {
            fatalError("Image URL could not be loaded")
        }
        titleLabel.text = detailsViewModel.detailsItem?.alt
        photographerLabel.text = detailsViewModel.detailsItem?.photographer
        mediaImageView.loadRemoteImage(imageurl,
                                       placeHolder: UIImage(named: "imageplaceholder"))
    }

}
