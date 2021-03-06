//
//  EventsViewController+CollectionView.swift
//  FURApp_iOS
//
//  Created by Eduardo Aguilera Olascoaga on 11/15/17.
//  Copyright © 2017 Fundación Rescate Arboreo. All rights reserved.
//

import UIKit
import Kingfisher

extension EventsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Configuration
    internal func configure(collectionView: UICollectionView, data: [EventsViewData]?){
        collectionView.register(UINib(nibName: "EventCell", bundle: nil), forCellWithReuseIdentifier: "EventCell")
        collectionView.registerSupplementaryView(EventsSectionHeader.self, kind: UICollectionElementKindSectionHeader)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventsData!.count
    }
    
    // Fill data of each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = EventCell.dequeue(fromCollectionView: collectionView, atIndexPath:indexPath)
        
        let event = eventsData?[indexPath.row]
        cell.nameLabel.text = event?.name
        cell.timeLabel.text = event?.name
        cell.dateLabel.text = event?.date
        cell.cityLabel.text = event?.city
        
        if let imgString = event?.cover_url {
            let imageUrl = URL(string: imgString)
            cell.imageView.kf.setImage(with: imageUrl)
        }
        
        return cell
    }
    
    // How big each cell will be
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: EventsSectionHeader.viewHeight)
    }
    
    // Set header of collection view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = EventsSectionHeader.dequeue(fromCollectionView: collectionView, ofKind: kind, atIndexPath: indexPath)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(logOutAction(sender:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        sectionHeader.logOutButton.addGestureRecognizer(tapGesture)
        
        if eventsPresenter.userExists() {
            sectionHeader.logOutButton.isHidden = false
        }else{
            sectionHeader.logOutButton.isHidden = true
        }
        
        return sectionHeader
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: BaseRoundedCardCell.cellHeight)
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) != nil {
            statusBarShouldBeHidden = true
            UIView.animate(withDuration: 0.6) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
            eventsPresenter.setSelected(eventIndex: indexPath.row)
            performSegue(withIdentifier: "presentEvent", sender: self)
        }
    }
}
