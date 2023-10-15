////
////  DateToolTip.swift
////  MacroZladagApp
////
////  Created by Celine Margaretha on 09/10/23.
////
//
//import UIKit
//
//enum ToolTipPosition: Int {
//     case left
//     case right
//     case middle
// }
//
//class DateToolTipView: UIView {
//
//    var roundRect:CGRect!
//    let toolTipWidth : CGFloat = 20.0
//    let toolTipHeight : CGFloat = 12.0
//    let tipOffset : CGFloat = 20.0
//    var tipPosition : ToolTipPosition = .middle
//    
//    convenience init(frame: CGRect, text : String, tipPos: ToolTipPosition){
//        self.init(frame: frame)
//        self.tipPosition = tipPos
//    }
//    
//    roundRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height — toolTipHeight)
//    let roundRectBez = UIBezierPath(roundedRect: roundRect, cornerRadius: 5.0)
//    
//    
//    func createTipPath() -> UIBezierPath{
//       let tooltipRect = CGRect(x: getX(), y: roundRect.maxY, width: toolTipWidth, height: toolTipHeight)
//       let trianglePath = UIBezierPath()
//       trianglePath.move(to: CGPoint(x: tooltipRect.minX, y: tooltipRect.minY))
//       trianglePath.addLine(to: CGPoint(x: tooltipRect.maxX, y: tooltipRect.minY))
//       trianglePath.addLine(to: CGPoint(x: tooltipRect.midX, y: tooltipRect.maxY))
//       trianglePath.addLine(to: CGPoint(x: tooltipRect.minX, y: tooltipRect.minY))
//       trianglePath.close()
//       return trianglePath
//    }
//    
//    func drawToolTip(_ rect : CGRect){
//       roundRect = CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height — toolTipHeight)
//       let roundRectBez = UIBezierPath(roundedRect: roundRect, cornerRadius: 5.0)
//       let trianglePath = createTipPath()
//       roundRectBez.append(trianglePath)
//       let shape = createShapeLayer(roundRectBez.cgPath)
//       self.layer.insertSublayer(shape, at: 0)
//    }
//    func createShapeLayer(_ path : CGPath) -> CAShapeLayer{
//       let shape = CAShapeLayer()
//       shape.path = path
//       shape.fillColor = UIColor.darkGray.cgColor
//       shape.shadowColor = UIColor.black.withAlphaComponent(0.60).cgColor
//       shape.shadowOffset = CGSize(width: 0, height: 2)
//       shape.shadowRadius = 5.0
//       shape.shadowOpacity = 0.8
//       return shape
//    }
//    
//    override func draw(_ rect: CGRect) {
//       super.draw(rect)
//       drawToolTip(rect)
//    }
//    
//    /*
//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//    }
//    */
//
//}
