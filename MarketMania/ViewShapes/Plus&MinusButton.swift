//
//  Plus&MinusButton.swift
//  MarketMania
//
//  Created by Louai on 9/28/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import UIKit

class PushButton: UIButton {

   @IBInspectable var fillColor: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
   @IBInspectable var isAddButton: Bool = true
    
    private var halfWidth: CGFloat {
        return self.frame.size.width / 2
//        return bounds.width / 2
    }
      
    private var halfHeight: CGFloat {
        return self.frame.size.height / 2
//        return bounds.height / 2
    }
     

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(rect: CGRect(origin: .zero, size: CGSize(width: self.frame.size.width, height: self.frame.size.height)))
            fillColor.setFill()
            path.fill()
        let plusWidth = min(bounds.width, self.frame.size.height)
          * Constants.plusButtonScale
        let halfPlusWidth = plusWidth / 2
        let plusPath = UIBezierPath()
        plusPath.lineWidth = Constants.plusLineWidth
        plusPath.move(to: CGPoint(
          x: halfWidth - halfPlusWidth + Constants.halfPointShift,
          y: halfHeight + Constants.halfPointShift))
        plusPath.addLine(to: CGPoint(
          x: halfWidth + halfPlusWidth + Constants.halfPointShift,
          y: halfHeight + Constants.halfPointShift))
        if isAddButton {
        plusPath.move(to: CGPoint(
          x: halfWidth + Constants.halfPointShift,
          y: halfHeight - halfPlusWidth + Constants.halfPointShift))
        plusPath.addLine(to: CGPoint(
          x: halfWidth + Constants.halfPointShift,
          y: halfHeight + halfPlusWidth + Constants.halfPointShift))
        }
        UIColor.white.setStroke()
        plusPath.stroke()
        
        
    }
    
    private struct Constants {
      static let plusLineWidth: CGFloat = 3.0
      static let plusButtonScale: CGFloat = 0.6
      static let halfPointShift: CGFloat = 0.5
    }
      

    
}
