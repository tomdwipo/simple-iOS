//
//  TableViewCell.swift
//  simple-iOS
//
//  Created by Tommy on 20/12/21.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageDoctorView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hospitalSpecializationLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setDataToCell(data: DataViewModel){
        imageDoctorView.kf.setImage(with:  URL(string: data.photo))
        nameLabel.text = data.name
        hospitalSpecializationLabel.text = "\(String(describing: data.hospital)) - \(String(describing: data.specialization))"
        aboutLabel.text = data.about.cliningText().replacingOccurrences(of: "&nbsp;", with: " ")
        priceLabel.text = data.price
    }
}
