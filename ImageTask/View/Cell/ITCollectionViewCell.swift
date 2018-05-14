//
//  ITCollectionViewCell.swift
//  ImageTask
//
//  Created by Kapil Rathore on 13/05/18.
//  Copyright © 2018 Kapil Rathore. All rights reserved.
//

import UIKit

class ITCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var itImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    var itObject: ITResponseObject! {
        didSet {
            nameLabel.text = itObject.name
            emailLabel.text = itObject.email
            dateLabel.text = itObject.getDateString(for: itObject.createdAt)
            displayImage(with: itObject.imageURL)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backView.dropShadow()
    }
    
    func displayImage(with imageURL: String) {
        ImageDownloadManager.shared.fetchImage(for: imageURL) { [weak self] (image, returnURL) in
            DispatchQueue.main.async {
                if self?.itObject.imageURL == returnURL?.absoluteString {
                    self?.itImageView.image = image
                }
            }
        }
    }
}
