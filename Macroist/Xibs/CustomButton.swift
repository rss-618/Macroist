//
//  CustomButton.swift
//  ListBuilder
//
//  Created by Ryan Schildknecht on 1/21/21.
//

import SwiftUI
extension UIButton {
    .layer.cornerRadius = Constant.CORNER_RADIUS
    self.layer.shadowColor = #colorLiteral(red: 0.05560452491, green: 0.05528203398, blue: 0.05585758388, alpha: 1)
    self.layer.shadowRadius = Constant.SHADOW_RADIUS
    self.layer.shadowOffset = CGSize(width: Constant.SHADOW_OFFSET_X, height: Constant.SHADOW_OFFSET_Y)
    self.layer.shadowOpacity = Constant.SHADOW_OPACITY
}
