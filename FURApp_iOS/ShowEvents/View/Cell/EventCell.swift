//
//  EventCell.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/15/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit

class EventCell: BaseRoundedCardCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var upperView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var assistButtonView: UIView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var bottomBackgroundView: UIView!
    
    
    internal static func dequeue(fromCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> EventCell {
        guard let cell: EventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as? EventCell else {
            fatalError("*** Failed to dequeue EventCell ***")
        }
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        assistButtonView.layer.cornerRadius = 14.0
        imageView.layer.cornerRadius = 14.0
        upperView.layer.cornerRadius = 14.0
    }
}
