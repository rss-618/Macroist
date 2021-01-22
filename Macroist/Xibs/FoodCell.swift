//
//  FoodCell.swift
//  ListBuilder
//
//  Created by Ryan Schildknecht on 1/20/21.
//

import SwiftUI

class FoodCell: UITableViewCell{
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var caloriesText: UILabel!
    @IBOutlet weak var proteinText: UILabel!
    @IBOutlet weak var carbsText: UILabel!
    @IBOutlet weak var fatText: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: Constant.FOOD_INSET_SIDE, left: Constant.FOOD_INSET_TOP, bottom: .zero, right: Constant.FOOD_INSET_SIDE))
        contentView.layer.cornerRadius = 10
//        contentView.layer.shadowColor = #colorLiteral(red: 0.05560452491, green: 0.05528203398, blue: 0.05585758388, alpha: 1)
//        contentView.layer.shadowRadius = Constant.SHADOW_RADIUS
//        contentView.layer.shadowOffset = CGSize(width: Constant.SHADOW_OFFSET_X, height: Constant.SHADOW_OFFSET_Y)
//        contentView.layer.shadowOpacity = Constant.SHADOW_OPACITY
    }
}
