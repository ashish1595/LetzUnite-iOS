//
//  StoryboardConstants.swift
//  LetzUnite
//
//  Created by Himanshu on 3/26/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import Foundation
import UIKit

let navigationSID = "NavigationController"
let loginSID = "LoginView"
let registrationSID = "RegistrationView"
let appBaseViewSID = "AppBaseView"
let tabBarViewSID = "TabBarView"
let feedsViewSID = "FeedsView"
let searchViewSID = "SearchView"
let createRequestViewSID = "CreateRequestView"
let rewardsViewSID = "RewardsView"
let profileViewSID = "ProfileView"
let historyViewSID = "HistoryView"
let donatedHistoryViewSID = "DonatedHistoryView"
let receivedHistoryViewSID = "ReceivedHistoryView"
let editProfileViewSID = "EditProfileView"
let notificationViewSID = "NotificationView"
let bloodRequestViewSID = "BloodRequestView"
let bloodRequestDetailViewSID = "BloodRequestDetailView"
let feedsDetailViewSID = "FeedsDetailView"
let visitProfileViewSID = "VisitProfileView"
let chatViewSID = "ChatView"

var mainStoryboard: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: Bundle.main)
}

enum CellIDs: String {
    case feedsCellID = "feedsCell"
    case bloodRequestCellID = "BloodRequestCollectionViewCell"
    case donatedHistoryCellID = "DonatedHistoryCell"
    case receivedHistoryCellID = "ReceivedHistoryCell"
    case notificationCell1ID = "NotificationCell1"
    case bloodRequestTableCellID = "BloodRequestTableCell"
    case chatOutgoingMessageTableCell = "ChatOutgoingMessageTableCell"
    case chatIncomingMessageTableCell = "ChatIncomingMessageTableCell"
}
