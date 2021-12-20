//
//  String+Extension.swift
//  simple-iOS
//
//  Created by Tommy on 20/12/21.
//

import Foundation

extension String {
    func cliningText()-> String{
        var newText = ""
        var brackets: [String] = []
        for element in self {
            if element == "<" {
                brackets.append(String(element))
            }
            if brackets.isEmpty {
                newText = newText + String(element)
            }
            if element == ">" {
                brackets.removeLast()
            }
        }
        return newText
    }
}
