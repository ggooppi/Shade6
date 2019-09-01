//
//  Utilities.swift
//  Shade6
//
//  Created by gopinath.a on 01/09/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import Foundation
import UIKit

class Utilities: NSObject {
    
    override init() {
        
    }
}

extension String {
    func toRGBColor() -> UIColor {
        var cString:String = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIColor {
    
    @nonobjc class var themeYellow: UIColor {
        return UIColor(red: 255.0 / 255.0, green: 193.0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var themeGreen: UIColor {
        return UIColor(red: 0 / 255.0, green: 193.0 / 255.0, blue: 0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var themeLightGrayBlue: UIColor {
        return "8a8a8f".toRGBColor()
    }
    
    
    @nonobjc class var themeTextBlue: UIColor {
        return "0087fc".toRGBColor()
    }
    
    @nonobjc class var themeLightBlue: UIColor {
        return "00c6ce".toRGBColor().withAlphaComponent(0.3)
    }
    
}

extension UITableView {
    
    func showNoData(title: String, description: String, image: UIImage? = nil, actionTitle: String? = nil, action: (() -> Void)?) -> Void {
        
        let bgView = UIView(frame: self.frame)
        
        let verticalStackView = UIStackView(frame: bgView.frame)
        verticalStackView.distribution = .fillProportionally
        verticalStackView.alignment = .center
        verticalStackView.spacing = 10
        verticalStackView.axis = .vertical
        bgView.addSubview(verticalStackView)
        verticalStackView.center = bgView.center
        
        let topPaddingView = UIView(frame: CGRect.zero)
        topPaddingView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        topPaddingView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        verticalStackView.addArrangedSubview(topPaddingView)
        
        
        let noDataImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 180))
        noDataImageView.contentMode = .scaleAspectFit
        if image != nil {
            noDataImageView.image = image
        } else {
            noDataImageView.image = UIImage(named: "noData")
        }
        noDataImageView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        noDataImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        verticalStackView.addArrangedSubview(noDataImageView)
        
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 20))
        titleLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        verticalStackView.addArrangedSubview(titleLabel)
        
        
        let groupView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width - 40, height: 70))
        groupView.widthAnchor.constraint(equalToConstant: self.frame.width - 40).isActive = true
        groupView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        let descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: groupView.frame.width, height: 50))
        descriptionLabel.text = description
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.textAlignment = .center
        descriptionLabel.textColor = .themeLightGrayBlue
        descriptionLabel.numberOfLines = 0
        groupView.addSubview(descriptionLabel)
        descriptionLabel.center.x = groupView.center.x
        
        
        if actionTitle != nil {
            let actionButton = UIButton(frame: CGRect(x: 0, y: 0, width: descriptionLabel.frame.width, height: 20))
            actionButton.setTitle(actionTitle!, for: UIControl.State.normal)
            actionButton.titleColor(for: UIControl.State.normal)
            actionButton.setTitleColor(UIColor.themeTextBlue, for: UIControl.State.normal)
            actionButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            if action != nil {
                actionButton.addAction(for: UIControl.Event.touchUpInside) {
                    action!()
                }
            }
            groupView.addSubview(actionButton)
            actionButton.center = CGPoint(x: groupView.center.x, y: descriptionLabel.frame.maxY)
        }
        
        verticalStackView.addArrangedSubview(groupView)
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView = bgView
        
    }
    
    func hideNoData() -> Void {
        self.backgroundView = nil
    }
    
    
    func showHeaderStatus(message: NSAttributedString) -> Void {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 0))
        view.backgroundColor = .themeLightBlue
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-20, height: 70))
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.textColor = .white
        
        messageLabel.attributedText = message
        
        self.tableHeaderView = view
        
        var newFrame = self.tableHeaderView!.frame
        newFrame.size.height = 74
        
        // Get the reference to the header view
        let tableHeaderView = self.tableHeaderView
        
        // Animate the height change
        UIView.animate(withDuration: 0.3, animations: {
            tableHeaderView?.frame = newFrame
            self.tableHeaderView = tableHeaderView
            self.layoutIfNeeded()
        }) { (completed) in
            view.addSubview(messageLabel)
            messageLabel.center = view.center
        }
        
    }
    
    func hideHeaderStatus() -> Void {
        
        var newFrame = self.tableHeaderView!.frame
        newFrame.size.height = 0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.tableHeaderView?.frame = newFrame
            self.layoutIfNeeded()
        }) { (completed) in
        }
        
    }
    
}

class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event, _ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "[\(arc4random())]", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
