//
//  SegmentioOptions.swift
//  Segmentio
//
//  Created by Dmitriy Demchenko
//  Copyright © 2016 Yalantis Mobile. All rights reserved.
//

import UIKit

// MARK: - Item

public struct SegmentioItem {
    var title: String?
    var image: UIImage?
    
    public init(title: String?, image: UIImage?) {
        self.title = title
        self.image = image
    }
    
}

// MARK: - Content view

public struct SegmentioState {
    var backgroundColor: UIColor
    var titleFont: UIFont
    var titleTextColor: UIColor
    
    public init(
        backgroundColor: UIColor = UIColor.clear,
        titleFont: UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
        titleTextColor: UIColor = UIColor.black) {
        self.backgroundColor = backgroundColor
        self.titleFont = titleFont
        self.titleTextColor = titleTextColor
    }
    
}

// MARK: - Horizontal separator

public enum SegmentioHorizontalSeparatorType {
    case top, bottom, topAndBottom
}

public struct SegmentioHorizontalSeparatorOptions {
    var type: SegmentioHorizontalSeparatorType
    var height: CGFloat
    var color: UIColor
    
    public init(
        type: SegmentioHorizontalSeparatorType = .topAndBottom,
        height: CGFloat = 1.0,
        color: UIColor = UIColor.clear) {
        self.type = type
        self.height = height
        self.color = color
    }
    
}

// MARK: - Vertical separator

public struct SegmentioVerticalSeparatorOptions {
    var ratio: CGFloat
    var color: UIColor
    
    public init(ratio: CGFloat = 1.0, color: UIColor = UIColor.clear) {
        self.ratio = ratio
        self.color = color
    }

}

// MARK: - Indicator

public enum SegmentioIndicatorType {
    case top, bottom
}

public struct SegmentioIndicatorOptions {
    var type: SegmentioIndicatorType
    var ratio: CGFloat
    var height: CGFloat
    var color: UIColor
    
    public init(
        type: SegmentioIndicatorType = .bottom,
        ratio: CGFloat = 1.0,
        height: CGFloat = 2.0,
        color: UIColor = UIColor.white) {
        self.type = type
        self.ratio = ratio
        self.height = height
        self.color = color
    }
    
}

// MARK: - Control options

public enum SegmentioStyle: String {
    case OnlyLabel, OnlyImage, ImageOverLabel, ImageUnderLabel, ImageBeforeLabel, ImageAfterLabel
    
    public static let allStyles = [
        OnlyLabel,
        OnlyImage,
        ImageOverLabel,
        ImageUnderLabel,
        ImageBeforeLabel,
        ImageAfterLabel
    ]
    
    public func isWithText() -> Bool {
        switch self {
        case .OnlyLabel, .ImageOverLabel, .ImageUnderLabel, .ImageBeforeLabel, .ImageAfterLabel:
            return true
        default:
            return false
        }
    }
    
    public func isWithImage() -> Bool {
        switch self {
        case .ImageOverLabel, .ImageUnderLabel, .ImageBeforeLabel, .ImageAfterLabel, .OnlyImage:
            return true
        default:
            return false
        }
    }
}

public typealias SegmentioStates = (defaultState: SegmentioState, selectedState: SegmentioState, highlightedState: SegmentioState)

public struct SegmentioOptions {
    var backgroundColor: UIColor
    var maxVisibleItems: Int
    var scrollEnabled: Bool
    var horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions?
    var verticalSeparatorOptions: SegmentioVerticalSeparatorOptions?
    var indicatorOptions: SegmentioIndicatorOptions?
    var imageContentMode: UIViewContentMode
    var labelTextAlignment: NSTextAlignment
    var states: SegmentioStates
    
    public init() {
        self.backgroundColor = UIColor(red:0.08, green:0.2, blue:0.38, alpha:1.0)
        self.maxVisibleItems = 2
        self.scrollEnabled = true
        
        self.horizontalSeparatorOptions = SegmentioHorizontalSeparatorOptions()
        self.verticalSeparatorOptions = SegmentioVerticalSeparatorOptions()
        
        self.indicatorOptions = SegmentioIndicatorOptions()
        
        self.imageContentMode = .center
        self.labelTextAlignment = .center
        
        self.states = SegmentioStates(
            defaultState: SegmentioState(
                backgroundColor: UIColor(red:0.08, green:0.2, blue:0.38, alpha:1.0),
                titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                titleTextColor: UIColor.white),
            selectedState: SegmentioState(backgroundColor: UIColor(red:0.08, green:0.2, blue:0.38, alpha:1.0),
                                          titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                                          titleTextColor: UIColor.white),
            highlightedState: SegmentioState(backgroundColor: UIColor(red:0.08, green:0.2, blue:0.38, alpha:1.0),
                                             titleFont: UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                                             titleTextColor: UIColor.white)
        )
        
    }

    
    public init(backgroundColor: UIColor, maxVisibleItems: Int, scrollEnabled: Bool, indicatorOptions: SegmentioIndicatorOptions?, horizontalSeparatorOptions: SegmentioHorizontalSeparatorOptions?, verticalSeparatorOptions: SegmentioVerticalSeparatorOptions?, imageContentMode: UIViewContentMode, labelTextAlignment: NSTextAlignment, segmentStates: SegmentioStates) {
        self.backgroundColor = backgroundColor
        self.maxVisibleItems = maxVisibleItems
        self.scrollEnabled = scrollEnabled
        self.indicatorOptions = indicatorOptions
        self.horizontalSeparatorOptions = horizontalSeparatorOptions
        self.verticalSeparatorOptions = verticalSeparatorOptions
        self.imageContentMode = imageContentMode
        self.labelTextAlignment = labelTextAlignment
        self.states = segmentStates
    }
    
}
