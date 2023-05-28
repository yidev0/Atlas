//
//  FileManager + Extensions.swift
//  Atlas
//
//  Created by Yuto on 2023/05/27.
//

import Foundation

extension FileManager {
    func resolveAlias(_ url: URL) -> URL? {
        do {
            let resourceValues = try url.resourceValues(forKeys: [.isAliasFileKey])
            if resourceValues.isAliasFile! {
                let url = try URL(resolvingAliasFileAt: url)
                return url
            }
        } catch  {
            print(error)
        }
        
        return nil
    }
}
