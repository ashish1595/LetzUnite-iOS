//
//  HeaderView.swift
//  LetzUnite
//
//  Created by Himanshu on 18/6/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

final class HeaderView: UICollectionReusableView {

  // MARK: - IBOutlets
  @IBOutlet weak var overlayView: UIView!

    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
  // MARK: - Life Cycle
  open override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)

    guard let customFlowLayoutAttributes = layoutAttributes as? CustomLayoutAttributes else {
      return
    }

    overlayView?.alpha = customFlowLayoutAttributes.headerOverlayAlpha
  }
}
