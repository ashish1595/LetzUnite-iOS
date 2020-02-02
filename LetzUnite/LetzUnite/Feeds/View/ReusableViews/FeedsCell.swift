//
//  FeedsCell.swift
//  LetzUnite
//
//  Created by Himanshu on 6/18/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

class FeedsCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet var label_quotes: UILabel!
    @IBOutlet var button_like: UIButton!
    @IBOutlet var button_comment: UIButton!
    @IBOutlet var button_share: UIButton!
    @IBOutlet var viewShadowStyle: ShadowView!
    @IBOutlet var viewBloodRequestCollectionContainer: UIView!
    @IBOutlet var collectionVw_bloodRequests: UICollectionView!
    @IBOutlet var button_viewAllRequests: UIButton!
    @IBOutlet var view_shareLikeContainer: UIView!
    
    var arrayHorizontalItems:Array<Any> = []
    
    // MARK: - View Life Cycle
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let attributes = layoutAttributes as? CustomLayoutAttributes else {
            return
        }
        
        picture.transform = attributes.parallax
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        picture.transform = .identity
    }
}

extension FeedsCell: UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayHorizontalItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIDs.bloodRequestCellID.rawValue, for: indexPath) as! BloodRequestCollectionViewCell
        let feedItem = self.arrayHorizontalItems[indexPath.row]
        self.showHorizontalScrollIn(cell: cell, data:feedItem, indexPath: indexPath)
        return cell
    }
    
    func showHorizontalScrollIn(cell:BloodRequestCollectionViewCell, data:Any, indexPath: IndexPath) {
        if let item = data as? BloodRequestsModel {
            cell.title.text = "Blood Group \(item.bloodType ?? "-") | \(item.bloodUnit ?? "-") Units"
            cell.label_name.text = item.hospitalContactPerson //TODO it should be contact person name
            cell.label_address.text = "\(item.hospitalName ?? "-"), \(item.city ?? "-"), \(item.state ?? "-")"
            cell.button_call.addTarget(self, action: #selector(callUser(sender:)), for: .touchUpInside)
            cell.button_call.tag = indexPath.row
        }
    }
    
    @objc func callUser(sender:Any?) {
        let button = sender as! UIButton
        let item = self.arrayHorizontalItems[button.tag] as! BloodRequestsModel
        UIApplication.shared.openURL(URL(string: "tel://\(item.contactPersonNumber ?? "")")!)
    }
}
