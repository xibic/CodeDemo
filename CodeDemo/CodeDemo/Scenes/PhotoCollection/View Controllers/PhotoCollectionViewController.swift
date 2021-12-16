//
//  PhotoCollectionViewController.swift
//

import UIKit

class PhotoCollectionViewController: UIViewController, Storyboardable {

    // MARK: - Properties
    var photoCollectionViewModel: PhotoCollectionViewModel!
    var tableViewRowHeight = 280.0

    // MARK: - Outlets
    @IBOutlet var tableView: UITableView! {
        didSet {
            // Configure Table View
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
    }

    // MARK: - Setups
    func setupViews() {
        view.backgroundColor = UIColor.backgroundColor
        // Set Title
        title = "Collections"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: false)

        // Feed Table
        tableView?.backgroundColor = UIColor.clear
        tableView?.keyboardDismissMode = .onDrag
//        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.register(PhotoCollectionCell.nib, forCellReuseIdentifier: PhotoCollectionCell.identifier)
    }

    func setupViewModel() {
        showLoadingIndicator(view: self.view)
        // Initiate fetching
        photoCollectionViewModel.fetchPhotoCollection()
        // Reload tableView after data fetch done
        photoCollectionViewModel.reloadTableViewClosure = {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                hideLoadingIndicator(view: (self?.view)!)
            }
        }
    }

}

extension PhotoCollectionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoCollectionViewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCollectionCell.identifier,
                                                    for: indexPath) as? PhotoCollectionCell {
            // Configure Cell
            cell.updateTitleLabelWithText(title: photoCollectionViewModel.getTitleForCellRow(indexPath.row))
            cell.updateThumbnailWithImage(imageURL: photoCollectionViewModel.getThumbnailUrlForRow(indexPath.row),
                                          placeholder: "imageplaceholder")

            return cell
        }
        
        return UITableViewCell()
    }

}

extension PhotoCollectionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        photoCollectionViewModel.selectedRowForDetails(selectedRow: indexPath.row)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableViewRowHeight
    }

}
