//
//  EventCell.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/15/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit

class EventCell: BaseRoundedCardCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet weak var whiteBackgroundView: UIView!
    @IBOutlet weak var assistButtonView: UIView!
    
    
    internal static func dequeue(fromCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> EventCell {
        guard let cell: EventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as? EventCell else {
            fatalError("*** Failed to dequeue EventCell ***")
        }
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        whiteBackgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 14.0)
        assistButtonView.roundCorners(corners: [.topRight, .topLeft, .bottomLeft, .bottomRight], radius: 14.0)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 14.0
    }

}
