//
//  Extensions.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-28.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for eachView in views {
            addSubview(eachView)
        }
    }
    
    func setupShadow(cornerRadius: CGFloat? = nil, opacity: Float = 0.05) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        if let cornerRadius = cornerRadius {
            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        } else {
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        }
    }
    
    func makeRound() {
        layer.cornerRadius = frame.width / 2
    }
}

enum ImageEncodingQuality {
    case png
    case jpeg(CGFloat)
}

extension KeyedEncodingContainer {

    mutating func encode(_ value: UIImage,
                         forKey key: KeyedEncodingContainer.Key,
                         quality: ImageEncodingQuality = .jpeg(0)) throws {
        guard let reducedImage = value.resized(withPercentage: 0.20) else {
            throw LRError.encodingError
        }
        var imageData: Data!
        switch quality {
        case .png:
            imageData = reducedImage.pngData()
        case .jpeg(let quality):
            imageData = reducedImage.jpegData(compressionQuality: quality)
        }
        print("imageData.count \(imageData.count)")
        try encode(imageData, forKey: key)
    }
}

extension KeyedDecodingContainer {
    
    public func decode(_ type: UIImage?.Type, forKey key: KeyedDecodingContainer.Key) throws -> UIImage? {
        guard let encodedImage = try? decode(String.self, forKey: key) else {
            return nil
        }
        guard let data = Data(base64Encoded: encodedImage, options: .ignoreUnknownCharacters) else {
            return nil
        }
        if let image = UIImage(data: data) {
            return image
        } else {
            throw LRError.imageConversionError
        }
    }
    
    public func decodeIfPresent(_ type: UIImage?.Type, forKey key: KeyedDecodingContainer.Key) throws -> UIImage? {
        guard let encodedImage = try? decodeIfPresent(String.self, forKey: key) else {
            return nil
        }
        guard let data = Data(base64Encoded: encodedImage, options: .ignoreUnknownCharacters) else {
            return nil
        }
        if let image = UIImage(data: data) {
            return image
        } else {
            throw LRError.imageConversionError
        }
    }
}

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
    
    func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
          let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
          let format = imageRendererFormat
          format.opaque = isOpaque
          return UIGraphicsImageRenderer(size: canvas, format: format).image {
              _ in draw(in: CGRect(origin: .zero, size: canvas))
          }
      }
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
