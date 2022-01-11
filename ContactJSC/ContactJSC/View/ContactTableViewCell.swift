//
//  ContactTableViewCell.swift
//  ContactJSC
//
//  Created by Dimas Syuhada on 11/01/22.
//

import Foundation
import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    
    static let identifier = "ContactTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ContactTableViewCell", bundle: nil)
    }
    
    func configure(with model: Contact){
        self.lblName.text = "\(model.name_first) \(model.name_last)"
        self.lblNumber.text = model.number
//        self.imgMovie.image = UIImage(named: "poster_")
    }
    
    
    
}
