//
//  Extension+CGPoint+CGSize.swift
//  CoinStackV2
//
//  Created by Michael Heide on 13.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI

extension CGPoint {
    static func -(lhs: Self, rhs: Self) ->CGSize{
        CGSize(width: lhs.x - rhs.x, height: lhs.y - rhs.y)
    }
    
    static func +(lhs: Self, rhs: Self) ->CGSize{
        CGSize(width: lhs.x + rhs.x, height: lhs.y + rhs.y)
    }
    
    static func *(lhs: Self, rhs: Self) ->CGSize{
        CGSize(width: lhs.x * rhs.x, height: lhs.y * rhs.y)
    }
    
    static func /(lhs: Self, rhs: Self) ->CGSize{
        CGSize(width: lhs.x / rhs.x, height: lhs.y / rhs.y)
    }
    
}

extension CGSize {
    static func -(lhs: Self, rhs: Self) ->CGSize{
        CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
    
    static func +(lhs: Self, rhs: Self) ->CGSize{
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    static func *(lhs: Self, rhs: Self) ->CGSize{
        CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
    }
    
    static func /(lhs: Self, rhs: Self) ->CGSize{
        CGSize(width: lhs.width / rhs.width, height: lhs.height / rhs.height)
    }
    
}
