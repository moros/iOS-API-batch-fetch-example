//
//  StringExtensions.swift
//  BatchFetchApp
//
//  Created by Doug Mason on 7/27/19.
//  Copyright © 2018 Doug Mason. All rights reserved.
//

import Foundation

extension String
{
    func toISO8601Date() -> Date
    {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: self)!
    }
}
