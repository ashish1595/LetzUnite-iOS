//
//  MenuView.swift
//  LetzUnite
//
//  Created by Himanshu on 18/6/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

protocol MenuViewDelegate {
  func reloadCollectionViewDataWithTeamIndex(_ index: Int)
}

final class MenuView: UICollectionReusableView {

  // MARK: - Properties
  var delegate: MenuViewDelegate?
  
  // MARK: - View Life Cycle
  override func prepareForReuse() {
    super.prepareForReuse()

    delegate = nil
  }
}

// MARK: - IBActions
extension MenuView {

  @IBAction func tappedButton(_ sender: UIButton) {
    delegate?.reloadCollectionViewDataWithTeamIndex(sender.tag)
  }
}
