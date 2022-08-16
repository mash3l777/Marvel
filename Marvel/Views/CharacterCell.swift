//
//  CharacterCell.swift
//  Marvel
//
//  Created by مشعل المعمري on 15/08/2022.
//

import UIKit

protocol CharacterCellDelegate: AnyObject {
    func rowCell(_ characterCell: CharacterCell, didTapURLButton indexPath: IndexPath)
}

class CharacterCell: UICollectionViewCell {

    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var btnURL: UIButton!
    @IBOutlet weak var heightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthLayoutConstraint: NSLayoutConstraint!
    
    var indexPath: IndexPath!

    weak var delegate: CharacterCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let spacer = 30.0
        let oneItemSize = (UIScreen.main.bounds.size.width / 2.0) - spacer
        heightLayoutConstraint.constant = oneItemSize
        widthLayoutConstraint.constant = oneItemSize
        self.layer.cornerRadius = 20
        btnURL.tintColor = UIColor(named: "AccentColor")
        btnURL.backgroundColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.15)
        btnURL.layer.cornerRadius = btnURL.layer.frame.height / 2
        
    }
    
    
    @IBAction func btnURLClicked(_ sender: Any) {
        delegate?.rowCell(self, didTapURLButton: indexPath)
    }

}
