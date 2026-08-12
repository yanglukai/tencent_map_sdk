//
//  TencentMapUtil.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/2/3.
//

import Foundation

struct TencentMapUtil {
    static func pointAnnotationView(_ title:String) -> UIView {
        let imageView = UIImageView(image: UIImage(named: "map_customer"))
        imageView.frame = CGRect(x: 0, y: 0, width: 130, height: 50)
        let label = UILabel()
        label.text = title
        label.frame = CGRect(x: 17, y: 4, width: 96, height: 30)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 13)
        imageView.addSubview(label)
        return imageView
    }
    
    static func clusterAnnotationViewWidth(_ count: UInt) -> Double {
        if count >= 10000 {
            return 90
        } else if count >= 1000 {
            return 75
        } else if count >= 100 {
            return 65
        } else if count >= 10 {
            return 55
        } else {
            return 50
        }
    }
    
    static func clusterAnnotationViewText(_ count: UInt) -> String {
        if count > 10000 {
            return "10000+"
        } else if count > 5000 {
            return "5000+"
        } else if count > 1000 {
            return "1000+"
        } else if count > 500 {
            return "500+"
        } else if count > 100 {
            return "100+"
        } else if count > 50 {
            return "50+"
        } else if count > 20 {
            return "20+"
        } else if count > 10 {
            return "10+"
        } else {
            return String(count)
        }
    }
}

extension UIColor {
    convenience init(_ rgbValue: Int, alpha: CGFloat = 1.0) {
        self.init(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255.0,
                  green: ((CGFloat)((rgbValue & 0xFF00) >> 8)) / 255.0,
                  blue: ((CGFloat)(rgbValue & 0xFF)) / 255.0,
                  alpha: alpha)
    }
}

extension UIView {
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        self.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
