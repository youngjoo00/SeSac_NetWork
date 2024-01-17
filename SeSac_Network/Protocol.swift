//
//  Protocol.swift
//  SeSac_Network
//
//  Created by youngjoo on 1/17/24.
//

import UIKit

protocol ReusableProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableProtocol {
    static var identifier: String {
        return "\(self)"
    }
}

extension UITableViewCell: ReusableProtocol {
    static var identifier: String {
        return "\(self)"
    }
}

extension UICollectionViewCell: ReusableProtocol {
    static var identifier: String {
        return "\(self)"
    }
}
