//
//  PlayingCardView.swift
//  PlayingCards
//
//  Created by JOEL CRAWFORD on 05/11/2019.
//  Copyright © 2019 PlayingCards. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    

    //this is a view that knows nothing about the rank and suit in the model
    //if the view change the rank has to redraw, hence its a good use of didSet
    //u dont need to use setNeedsLayout() if there is no subviews
    
    var rank: Int = 5 { didSet { setNeedsDisplay(); setNeedsLayout()}}
    var suit: String = "🖤" { didSet { setNeedsDisplay(); setNeedsLayout()}}
    var isFaceUp: Bool = true { didSet { setNeedsDisplay(); setNeedsLayout()}}
    
    //CREATING FUNC TO DO ATTRIBUTED STRING
    private func CenteredAttributedString(_ string: String, fontSize: CGFloat) -> NSAttributedString {
        //using prefered font, .withsize is used for scaling the font
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        //metrics to scale the font based on the slider of the phone
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        
        //for the text
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        return NSAttributedString(string: string, attributes: [NSAttributedString.Key.paragraphStyle:paragraphStyle, .font:font])
        
        
    }
    private var cornerString: NSAttributedString {
        return CenteredAttributedString(rankString+"\n"+suit, fontSize: cornerFontsize)
    }
   // private var upperLeftCornerLabel: UILabel
    //use lazy type type since its not initialisd but a funct being called on it
//    private var upperLeftCornerLabel = createCornerLabel()
//    private var lowerRightCornerLabel = createCornerLabel()
    
    private lazy var lowerRightCornerLabel = createCornerLabel()
    private lazy var upperLeftCornerLabel = createCornerLabel()
    
    //CREATEING FUNC TO CREATE THE UILABEL DECLARED
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        //initialisng label putting it to means use as many lines as u need
        label.numberOfLines = 0
        //adding the label as a subview
        addSubview(label)
        return label
        
    }
    // we dont need external name(_) coz the name of the func implies erternal name
    private func  configureCornerlabel(_ label: UILabel) {

        label.attributedText = cornerString
        //the label already has a width and sizetofit will make it taller to correct we reset it,
        //clear its size before doing size to fit
        label.frame.size = CGSize.zero
        
        //size the label to fit its content
        label.sizeToFit()
        //if not faced up we hide the label
        label.isHidden = !isFaceUp
        
    }
    
    //FONT ON SLIDER CHANGE
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    //are u landscape, potrait and size
        setNeedsDisplay()
        setNeedsLayout()
        
    }
    //function for redrawing a view incase its change to lanscape , portrait
    //layout subview is used to add subviews
    
    override func layoutSubviews() {
        
        //UIView uses auto layout, make sure to call super
        //setNeed display, the system will call draw rect funct
        //setneeds layout, the system will layoutsubviews
        super.layoutSubviews()
        configureCornerlabel(upperLeftCornerLabel)
        upperLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
        //moves the card from the letft to insid then in the view
        configureCornerlabel(lowerRightCornerLabel)
        //transforming the card, CGFloat.pi rotates it half degree
        lowerRightCornerLabel.transform = CGAffineTransform.identity
            .translatedBy(x: lowerRightCornerLabel.frame.size.width, y: lowerRightCornerLabel.frame.size.height)
            .rotated(by: CGFloat.pi)
        lowerRightCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
        .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -lowerRightCornerLabel.frame.size.width, dy: -lowerRightCornerLabel.frame.size.height)
    }

    //
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
     
    override func draw(_ rect: CGRect) {
        // Drawing code
        //1. GET THE CONTEXT FIRST, it might return nil, thats y we used if let
//        if let context = UIGraphicsGetCurrentContext() {
//            //2. adding a context to draw circle, startAngle: 0, endAngle: CGFloat.pi, 0 is off to the right, upto 2 * pi, angle in randians
//            context.addArc(center: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//            //3. setting drawing attributes
//            context.setLineWidth(5.0)
//            //4. setting stroke and fill color
//            UIColor.green.setFill()
//            UIColor.red.setStroke()
//            context.strokePath()
//            context.fillPath()
//
//        }
        
//        //USING UIBEZIERPATH
//        //1. start with empty path
//        let path = UIBezierPath()
//    //2.move around, addPath, arcs, etc
//        path.addArc(withCenter: CGPoint(x: bounds.midX, y: bounds.midY), radius: 100.0, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
//        path.lineWidth = 5.0
//        UIColor.green.setFill()
//        UIColor.red.setStroke()
//        path.stroke()
//        path.fill()
//        path.close()
        
//DRAWING A CARD
        let RoundedRectPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        //want to draw inside the rounded rect, hence add a clip
        RoundedRectPath.addClip()
        UIColor.white.setFill()
        RoundedRectPath.fill()
        RoundedRectPath.close()
        
        //DRAWING IMAGES(should add image in the assets folder
        if let faceCardImage = UIImage(named: rankString+suit) {
            faceCardImage.draw(in: bounds.zoom(by: SizeRatio.faceCardImagesizeToBoundSize))
        }
        
    }
    

}

extension PlayingCardView {
    ///SETTING CONSTANTS IN SWIFT USING DTRUCT
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImagesizeToBoundSize: CGFloat = 0.75
        
    }
    
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    private var cornerFontsize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    private var rankString: String {
        switch rank {
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
            
        }
    }
    
}
extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    var rightHalf: CGRect {
        return CGRect(x: midX, y: midY, width: width/2, height: height)
    }
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
        
    }
    func sized(to size: CGSize) -> CGRect{
        return CGRect(origin: origin, size: size)
    }
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth)/2, dy: (height - newHeight)/2)
        
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
        
    }
}
