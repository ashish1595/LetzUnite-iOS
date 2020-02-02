//
//  FeedsView.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

class FeedsView: UIViewController {

    var presenter: FeedsPresenterProtocol?
    
    @IBOutlet var collectionVw_feeds: UICollectionView!
    var navView:NavigationBarView?

    // MARK: - Properties
    var customLayout: CustomLayout? {
        return collectionVw_feeds?.collectionViewLayout as? CustomLayout
    }
    var isOriginalFrame:Bool = true
    var sections: Array<FeedsModel?> = []
    
    private var displayedTeam = 0
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionViewLayout()
        self.collectionVw_feeds.collectionViewLayout.invalidateLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        //presenter?.fetchFeeds()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupNavigationBar() {
        navView = NavigationBarView.init(navType: .kFeedsNav, frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.bounds.size.width, height: 56))
        navView?.delegate = self
        navView?.layoutIfNeeded()
        self.view.addSubview(navView!)
    }
}


extension FeedsView: FeedsViewProtocol {
    func prepareForAnimation() {
        
    }
    
    func styleFeedsView() {
        self.setupNavigationBar()
    }
    
    func animateFeedsView() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func showError(_ message: String?) {
        Utility.showToast(with: message)
    }
    
    func updateView(With parameters: FeedsResponse?) {
        for item in (parameters?.arrayFeeds)! {
            self.sections.append(item)
        }
        
        if isOriginalFrame == true {
            self.collectionVw_feeds.frame = CGRect(x: self.collectionVw_feeds.frame.origin.x, y: self.collectionVw_feeds.frame.origin.y, width: self.collectionVw_feeds.frame.size.width, height: self.collectionVw_feeds.frame.size.height - 2)
            isOriginalFrame = false
        }else {
            self.collectionVw_feeds.frame = CGRect(x: self.collectionVw_feeds.frame.origin.x, y: self.collectionVw_feeds.frame.origin.y, width: self.collectionVw_feeds.frame.size.width, height: self.collectionVw_feeds.frame.size.height + 2)
            isOriginalFrame = true
        }
        
        self.collectionVw_feeds?.reloadData()
        self.collectionVw_feeds?.collectionViewLayout.invalidateLayout()
        self.collectionVw_feeds?.setCollectionViewLayout(customLayout!, animated: true)  
    }
}

private extension FeedsView {
    
    func setupCollectionViewLayout() {
        guard let collectionView = self.collectionVw_feeds, let customLayout = customLayout else { return }
        
        self.collectionVw_feeds.layoutIfNeeded()
        collectionView.register(
            UINib(nibName: "HeaderView", bundle: nil),
            forSupplementaryViewOfKind: CustomLayout.Element.header.kind,
            withReuseIdentifier: CustomLayout.Element.header.id
        )
        
        collectionView.register(
            UINib(nibName: "MenuView", bundle: nil),
            forSupplementaryViewOfKind: CustomLayout.Element.menu.kind,
            withReuseIdentifier: CustomLayout.Element.menu.id
        )
        
        customLayout.settings.itemSize = CGSize(width: collectionView.frame.width, height: 290)
        customLayout.settings.headerSize = CGSize(width: collectionView.frame.width, height: 50)
        customLayout.settings.menuSize = CGSize(width: collectionView.frame.width, height: 50)
        customLayout.settings.sectionsHeaderSize = CGSize(width: collectionView.frame.width, height: 1)
        customLayout.settings.sectionsFooterSize = CGSize(width: collectionView.frame.width, height: 1)
        customLayout.settings.isHeaderStretchy = true
        customLayout.settings.isAlphaOnHeaderActive = true
        customLayout.settings.headerOverlayMaxAlphaValue = CGFloat(0.6)
        customLayout.settings.isMenuSticky = true
        customLayout.settings.isSectionHeadersSticky = true
        customLayout.settings.isParallaxOnCellsEnabled = false
        customLayout.settings.maxParallaxOffset = 50
        customLayout.settings.minimumInteritemSpacing = 0
        customLayout.settings.minimumLineSpacing = 3
    }
}

extension FeedsView: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sections.count == 0 {
            return 0
        }else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomLayout.Element.cell.id, for: indexPath)
        if let feedCell = cell as? FeedsCell {
            let feedItem = sections[indexPath.section]
            switch feedItem?.notificationTypeId {
            case 1:
                self.showBloodRequestsIn(cell: feedCell, data: feedItem!)
            case 3:
                self.showQuotationIn(cell: feedCell, data: feedItem!)
            default:
                print("")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CustomLayout.Element.sectionHeader.id, for: indexPath)
            if let sectionHeaderView = supplementaryView as? SectionHeaderView {
                //sectionHeaderView.title.text = sections[indexPath.section]
            }
            return supplementaryView
            
        case UICollectionElementKindSectionFooter:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CustomLayout.Element.sectionFooter.id, for: indexPath)
            if let sectionFooterView = supplementaryView as? SectionFooterView {
                //sectionFooterView.mark.text = "Strength: \(teams[displayedTeam].marks[indexPath.section])"
            }
            return supplementaryView
            
        case CustomLayout.Element.header.kind:
            let topHeaderView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CustomLayout.Element.header.id,
                for: indexPath
            )
            return topHeaderView
            
        case CustomLayout.Element.menu.kind:
            let menuView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CustomLayout.Element.menu.id,
                for: indexPath
            )
            if let menuView = menuView as? MenuView {
                //menuView.delegate = self
            }
            return menuView
        default:
            fatalError("Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.collectionVw_feeds?.cellForItem(at: indexPath)  as! FeedsCell
        
        let theAttributes:UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        let cellFrameInSuperview:CGRect!  = collectionView.convert(theAttributes.frame, to: collectionView.superview)
        
        let cardFrame = CGRect(x: cell.viewShadowStyle.frame.origin.x, y: cellFrameInSuperview.origin.y + 8, width: cell.viewShadowStyle.frame.size.width, height: cell.viewShadowStyle.frame.size.height)
        
        let cardCenter = cell.center
        let imgFrame = cell.picture.frame
        let titleFrame = cell.label_quotes.frame
        let descFrame = cell.label_quotes.frame
        let shareFrame = cell.view_shareLikeContainer.frame
    
        presenter?.showFeedsDetailScreen(with: cardFrame, cardCenter: cardCenter, imageFrame: imgFrame, titleFrame: titleFrame, descFrame: descFrame, bottomViewFrame: shareFrame)
    }
    
    func showBloodRequestsIn(cell:FeedsCell, data:FeedsModel) {
        cell.arrayHorizontalItems = data.notificationDetailList!
        cell.viewBloodRequestCollectionContainer.isHidden = false
        cell.viewShadowStyle.isHidden = true
        cell.button_viewAllRequests.addTarget(self, action: #selector(showAllRequests(sender:)), for: .touchUpInside)
    }
    
    func showQuotationIn(cell:FeedsCell, data:FeedsModel) {
        cell.viewBloodRequestCollectionContainer.isHidden = true
        cell.viewShadowStyle.isHidden = false
    }
    
    @objc func showAllRequests(sender:Any?) {
        presenter?.showAllBloodRequestsScreen()
    }
}

extension FeedsView: NavigationBarProtocol {
    func didPressNotificationBellButton() {
        presenter?.showNotificationScreen()
    }
}





