//
//  RectangleListView.swift
//  MarketMania
//
//  Created by Louai on 9/22/20.
//  Copyright © 2020 Louai. All rights reserved.
//

import UIKit

class RectangleListView: UIView {
    
    var path: UIBezierPath!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createRectangle() {
        // Initialize the path.
        path = UIBezierPath()

        // Specify the point that the path should start get drawn.
        path.move(to: CGPoint(x: 0.0, y: 0.0))

        // Create a line between the starting point and the bottom-left side of the view.
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))

        // Create the bottom line (bottom-left to bottom-right).
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))

        // Create the vertical line from the bottom-right to the top-right side.
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))

        // Close the path. This will create the last line automatically.
        path.close()

    }
    

    override func draw(_ rect: CGRect) {
        //create Rectangle fill and border properties
        self.createRectangle()
        UIColor.white.setFill()
        path.fill()
        UIColor.black.setStroke()
        path.stroke()
        path.lineWidth = 4
    }
    
   
}
