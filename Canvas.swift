//
//  Canvas.swift
//  Test
//
//  Created by Сергей Дорошенко on 23.12.2019.
//  Copyright © 2019 Сергей Дорошенко. All rights reserved.
//

import UIKit

class Canvas: UIView {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        guard !lines.isEmpty else { return }
        
        lines.forEach{ line in
            context.setStrokeColor(line.color)
            context.setLineWidth(line.strokeWidth)
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 { context.move(to: p) }
                else { context.addLine(to: p) }
            }
            context.strokePath()
        }
        
    }
        
    var lines = [Line]()
    
}
