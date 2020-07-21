//
//  Extenstion+NSPredicate.swift
//  CoinStackV2
//
//  Created by Michael Heide on 28.06.20.
//  Copyright © 2020 Michael Heide. All rights reserved.
//

import Foundation

extension NSPredicate{
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}
