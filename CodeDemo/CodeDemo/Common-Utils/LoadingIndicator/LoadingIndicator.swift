//
//  LoadingIndicator.swift
//

import Foundation
import UIKit

let LOADINGINDICATORVIEWTAG: Int = 1199

// MARK: - Show
func showLoadingIndicator(view: UIView) {
    view.isUserInteractionEnabled = false
    let loadingIndicator = LoadingIndicator(text: "Please wait..")
    loadingIndicator.tag = LOADINGINDICATORVIEWTAG
    view.addSubview(loadingIndicator)
}

// MARK: - Hide
func hideLoadingIndicator(view: UIView) {
    view.isUserInteractionEnabled = true
    if let viewWithTag = view.viewWithTag(LOADINGINDICATORVIEWTAG) {
        viewWithTag.removeFromSuperview()
    }
}

// MARK: -
// !!!: - LoadingIndicator
class LoadingIndicator: UIVisualEffectView {
    var text: String? {
        didSet {
            label.text = text
        }
    }
    let activityIndictor = UIActivityIndicatorView.init(style: .large)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .dark)
    let vibrancyView: UIVisualEffectView
    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
    }
    required init?(coder aDecoder: NSCoder) {
        self.text = ""
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        self.setup()
    }
    func setup() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(activityIndictor)
        activityIndictor.color = UIColor.white
        contentView.addSubview(label)
        label.textColor = UIColor.white
        activityIndictor.startAnimating()
    }
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = self.superview {
            let width = superview.frame.size.width / 1.8
            let height: CGFloat = 70.0
            self.frame = CGRect(x: superview.frame.size.width / 2 - width / 2,
                                y: superview.frame.height / 2 - height / 2,
                                width: width,
                                height: height)
            vibrancyView.frame = self.bounds
            let activityIndicatorSize: CGFloat = 40
            activityIndictor.frame = CGRect(x: 15,
                                            y: height / 2 - activityIndicatorSize / 2,
                                            width: activityIndicatorSize,
                                            height: activityIndicatorSize)
            layer.cornerRadius = 8.0
            layer.masksToBounds = true
            label.text = text
            label.textAlignment = NSTextAlignment.center
            label.frame = CGRect(x: activityIndicatorSize + 5,
                                 y: 0,
                                 width: width - activityIndicatorSize - 15,
                                 height: height)
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 17)
        }
    }
    func show() {
        self.isHidden = false
    }
    func hide() {
        self.isHidden = true
    }
}
