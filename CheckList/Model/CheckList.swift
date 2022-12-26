//
//  CheckList.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/27.
//

import Foundation

struct CheckList {
    var checkList: [String]
    var alarm: [Alarm]
}

struct Alarm {
    var time: String
    var day: [String]
}
