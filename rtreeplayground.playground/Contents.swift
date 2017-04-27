import UIKit
import GameKit

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
    
    var minVector : vector_float2 {
        return (CGPoint(minX, minY)).vector
    }
    
    var maxVector : vector_float2 {
        return (CGPoint(maxX, maxY)).vector
    }

}
extension CGPoint {
    
    init(_ x:CGFloat, _ y:CGFloat) {
        self.init(x:x, y:y)
    }
    
    var vector : vector_float2 {
        return vector_float2(Float(x),Float(y))
    }
}


class Widget: UIView {

    var name: String = "?"
    
    override var description: String {
        return String(format: "%@ %@", self.name, self.frame.debugDescription)
    }
    
    var minVector : vector_float2 {
        return self.frame.minVector
    }
    
    var maxVector : vector_float2 {
        return self.frame.maxVector
    }
}

// https://developer.apple.com/reference/gameplaykit/gkrtree
func rtree() {
    let w1 = Widget(frame: CGRect(0,0,2,2))
    w1.name = "One"
    let w2 = Widget(frame: CGRect(2,2,2,2))
    w2.name = "Two"
    let w3 = Widget(frame: CGRect(4,4,2,2))
    w3.name = "Three, yo"
    let w4 = Widget(frame: CGRect(8,8,2,2))
    w4.name = "4"
    
    let widgets = [w1, w2, w3, w4]
    
    let tree = GKRTree(maxNumberOfChildren: 2)
    
    for w in widgets {
        tree.addElement(w, boundingRectMin: w.minVector, boundingRectMax: w.maxVector, splitStrategy: GKRTreeSplitStrategy.reduceOverlap)
    }
    
    let region = CGRect(1,1,2.5,2.5)
    print("region: \(region)")
    print("minVector: \(region.minVector)")
    print("maxVector: \(region.maxVector)")
    
    let elements = tree.elements(inBoundingRectMin: region.minVector, rectMax: region.maxVector)
    print("elements: ")
    for e in elements {
        print("\(e.description)")
    }
}

rtree()

