//
//  main.swift
//  NewIdAlgorithm
//
//  Created by Woo0 on 2021/02/17.
//

import Foundation

extension String{
    func getArrayAfterRegex(regex: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}


var new_id = String(readLine()!)
var overlap = "."
var over = false

new_id = new_id.lowercased()
var new_id1 = ""
for x in new_id.getArrayAfterRegex(regex: "[a-z0-9|-|_|.]+") {
    new_id1 += x
}

var new_id2 = ""
for x in new_id1 {
    if over {
        if !String(x).elementsEqual(overlap) {
            new_id2 += String(x)
            over = false
        }
    } else {
        new_id2 += String(x)
        over = false
    }
    if String(x).elementsEqual(overlap) {
        over = true
    }
}

if "." == new_id2[new_id2.startIndex] {
    let strRange = new_id2.startIndex ... new_id2.startIndex
    new_id2.removeSubrange(strRange)
}
var endIndex = new_id2.index(before: new_id2.endIndex)
if "." == new_id2[endIndex] {
    let strRange = new_id2.index(before: new_id2.endIndex) ... new_id2.index(before: new_id2.endIndex)
    new_id2.removeSubrange(strRange)
}

if new_id2.count > 15 {
    let strRange = new_id2.index(new_id2.startIndex, offsetBy: 15) ... new_id2.index(before: new_id2.endIndex)
    new_id2.removeSubrange(strRange)
}

if new_id2.count <= 2 {
    for x in new_id2.count...2 {
        var strInsert = new_id2[new_id2.index(before: new_id2.endIndex)]
        new_id2.append(strInsert)
    }
}

print(new_id2)
