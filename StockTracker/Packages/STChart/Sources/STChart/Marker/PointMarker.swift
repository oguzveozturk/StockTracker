import UIKit
import DGCharts

protocol PointMarkerConfigurable {
    func updateFillColor(_ color: UIColor)
    func updateStrokeColor(_ color: UIColor)
    func updateLineWidth(_ width: CGFloat)
    func updateRadius(_ radius: CGFloat)
}

final class PointMarker: MarkerView, PointMarkerConfigurable {
    private var fillColor: UIColor
    private var strokeColor: UIColor
    private var lineWidth: CGFloat
    private var radius: CGFloat

    init(fillColor: UIColor = .red,
         strokeColor: UIColor = .clear,
         lineWidth: CGFloat = 2,
         radius: CGFloat = 4) {
        self.fillColor = fillColor
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.radius = radius
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(context: CGContext, point: CGPoint) {
        super.draw(context: context, point: point)
        let x = point.x - radius
        let y = point.y - radius
        let width = radius * 2
        let height = width
        let rectangle = CGRect(x: x, y: y, width: width, height: height)

        context.setFillColor(fillColor.cgColor)
        context.setStrokeColor(strokeColor.cgColor)
        context.setLineWidth(lineWidth)
        
        context.addEllipse(in: rectangle)
        context.drawPath(using: .fillStroke)
    }
    
    func updateFillColor(_ color: UIColor) {
        self.fillColor = color
        setNeedsDisplay()
    }
    
    func updateStrokeColor(_ color: UIColor) {
        self.strokeColor = color
        setNeedsDisplay()
    }
    
    func updateLineWidth(_ width: CGFloat) {
        self.lineWidth = width
        setNeedsDisplay()
    }
    
    func updateRadius(_ radius: CGFloat) {
        self.radius = radius
        setNeedsDisplay()
    }
}
