//
//  CheckList.swift
//  CheckList
//
//  Created by 전현성 on 2022/12/27.
//

import Foundation

struct CheckList {
    var item: [CheckListItem]
    var alarm: [Alarm]
}

struct CheckListItem {
    var title: String
    var isDone: Bool
}

struct Alarm {
    var time: String
    var day: [String]
}
