//
//  PlantDetailTableViewCell.swift
//  Shade6
//
//  Created by gopinath.a on 01/09/19.
//  Copyright © 2019 vaaranam. All rights reserved.
//

import UIKit

class PlantDetailTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var downArrow: UIImageView!
    @IBOutlet weak var information: UILabel!
    
    //MARK: - Properties
    var show:Bool = true
    var complitionHandler: (() -> Void)?
    
    var type = LabelInformationType(rawValue: "")
    var contentToshow = PlantDetail()
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        container.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer (target: self, action: #selector(onTap(tapGesture:)))
        container.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if !show{
            container.backgroundColor = .themeGreen
            self.downArrow.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }else{
            container.backgroundColor = .white
            self.downArrow.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
        }
    }
    
    @objc func onTap(tapGesture: UITapGestureRecognizer) {
        complitionHandler!()
    }
    
    func setup(type: LabelInformationType, data: PlantDetail) -> Void {
        self.type = type
        self.contentToshow = data
        switch type {
        case .about:
            title.text = LabelInformationType.about.rawValue
        case .specification:
            title.text = LabelInformationType.specification.rawValue
        }
    }
    
    func showOrHideContent(showContent:Bool? = nil ) {
        if let value = showContent{
            self.show = value
        }
        
        switch type {
        case .about?:
            let detailText = NSMutableAttributedString()
            detailText.append(NSAttributedString(string: "\n"))
            
            detailText.append(NSAttributedString(string: "• Name: \(contentToshow.commonName)\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]))
            detailText.append(NSAttributedString(string: "• Family: \(contentToshow.familyCommonName), Native: \(contentToshow.nativeStatus)\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)]))
            detailText.append(NSAttributedString(string: "• Duration: \(contentToshow.duration)\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)]))
            
            if show{
                show = !show
                information.attributedText = detailText
            } else{
                show = !show
                information.text = ""
            }
            
        case .specification?:
            let detailText = NSMutableAttributedString()
            detailText.append(NSAttributedString(string: "\n"))
            
            detailText.append(NSAttributedString(string: "• Life Span: \(contentToshow.specifications.lifespan)\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .bold)]))
            detailText.append(NSAttributedString(string: "• Toxicity: \(contentToshow.specifications.toxicity), Nitrogen Fixation: \(contentToshow.specifications.nitrogen_fixation)\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)]))
            detailText.append(NSAttributedString(string: "• Shape And Orientation: \(contentToshow.specifications.shape_and_orientation)\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)]))
            detailText.append(NSAttributedString(string: "• Regrowth Rate: \(contentToshow.specifications.regrowth_rate)\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)]))
            if show{
                show = !show
                information.attributedText = detailText
            } else{
                show = !show
                information.text = ""
            }
            
        case .none:
            print("Unknown Entity")
        }
    }
    
}
