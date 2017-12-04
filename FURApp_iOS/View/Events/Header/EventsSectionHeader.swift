//
//  EventsSectionHeader.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/17/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit

class EventsSectionHeader: UICollectionReusableView {

    @IBOutlet weak var logOutButton: UIButton!
    internal static let viewHeight: CGFloat = 81
    
    internal static func dequeue(fromCollectionView collectionView: UICollectionView, ofKind kind: String, atIndexPath indexPath: IndexPath) -> EventsSectionHeader {
        guard let view: EventsSectionHeader = collectionView.dequeueSupplementaryView(kind: kind, indexPath: indexPath) else {
            fatalError("*** Failed to dequeue TodaySectionHeader ***")
        }
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func logOutHide(_ sender: Any) {
        logOutButton.isHidden = true
    }
    
}
