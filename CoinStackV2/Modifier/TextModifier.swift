//
//  TextModifier.swift
//  CoinStackV2
//
//  Created by Michael Heide on 16.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import SwiftUI

extension View {
    
    //When App Starts
    func titleStyle() -> some View {
        self.modifier(Title())
    }
    
    //subTitle
    func subTitleStyle() -> some View {
        self.modifier(SubTitle())
    }
    
    func headerStyle() -> some View {
        self.modifier(Header())
    }
    
    func headerSecondaryStyle() -> some View {
        self.modifier(HeaderSecondary())
    }
    
    func headerSecondaryLightStyle() -> some View {
        self.modifier(HeaderSecondaryLight())
    }
    
    func descriptionStyle() -> some View {
        self.modifier(Description())
    }
    
    func descriptionBoldStyle() -> some View {
        self.modifier(DescriptionBold())
    }
    
    func bodyStyle() -> some View {
        self.modifier(BodyText())
    }
    
    func bodyLightStyle() -> some View {
        self.modifier(BodyTextLight())
    }
    
    func smallNumberStyle() -> some View {
        self.modifier(SmallNumber())
    }
    
    func smallGreenIndicatorStyle() -> some View {
        self.modifier(SmallGreenIndicatorStyle())
    }
    
    func smallRedIndicatorStyle() -> some View {
        self.modifier(SmallRedIndicatorStyle())
    }
    
    
    
    
    
}
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 39, weight: .bold))
            .foregroundColor(.newPrimaryColor)
    }
}

struct SubTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 16))
            .foregroundColor(.newPrimaryColorLight)
    }
}

struct Header: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 34, weight: .bold))
            .foregroundColor(.newPrimaryColor)
    }
}

struct HeaderSecondary: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.newPrimaryColor)
    }
}

struct HeaderSecondaryLight: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22, weight: .bold))
            .foregroundColor(.newSecondaryColorBluish)
    }
}

struct Description: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 11))
            .foregroundColor(.newSecondaryColorBluish)
    }
}

struct DescriptionBold: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(.newSecondaryColorBluish)
    }
}

struct BodyText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.newPrimaryColor)
    }
}

struct BodyTextLight: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.newSecondaryColorBluish)
    }
}

struct SmallNumber: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .bold))
            .foregroundColor(.newPrimaryColor)
    }
}

struct SmallGreenIndicatorStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(.greenIndicator)
    }
}

struct SmallRedIndicatorStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(.redIndicator)
    }
}




