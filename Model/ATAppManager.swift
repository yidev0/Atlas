//
//  AppManager.swift
//  Atlas
//
//  Created by Yuto on 2023/05/06.
//

import SwiftUI

class ATAppManager: ObservableObject {
    
    static var shared = ATAppManager()
    
    @Published var apps:Set<ATApp> = []
    @Published var categories:Set<ATAppCategoryType> = []
    
    @Published var position: CGPoint = .zero
    @Published var windowSize: CGSize = .init(width: 300, height: 400)
    
    @Published var columnCount = 0
    
    private var scriptURL: URL?
    
    //    https://stackoverflow.com/questions/49071722/is-it-possible-to-determine-the-x-y-position-of-an-icon-in-the-dock-on-the-displ
    
    init() {
        checkDockPosition(completion: {})
        DispatchQueue.main.async {
            self.getAllApplications()
        }
    }
    private func updateDockPosition(to point: CGPoint) {
        DispatchQueue.main.async {
            self.position = point
        }
    }
    
    public func checkDockPosition(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let script = NSAppleScript(
                    source: """
                        set returnName to {0, 0}
                        
                        tell application "System Events"
                            tell process "Dock"
                                set dockItems to a reference to (every UI element of list 1 whose role is "AXDockItem" and name is "Atlas")
                                if dockItems is not {} then
                                    set returnPosition to position of item 1 of dockItems
                                else
                                    set returnPosition to {0, 0} -- Default position if "Atlas" dock item is not found
                                end if
                            end tell
                        end tell
                        
                        return returnPosition
                        """
                )
                var errorDict: NSDictionary?
                let result = script?.executeAndReturnError(&errorDict)
                
                var x = result?.atIndex(1)?.doubleValue ?? 0.0
                var y = result?.atIndex(2)?.doubleValue ?? 0.0
                if let screenSize = NSScreen.main?.frame.size {
                    y = screenSize.height - y
                    if y > self.windowSize.height {
                        y = self.windowSize.height
                    }
                    if x > screenSize.width - self.windowSize.width * 1.5 {
                        x = screenSize.width - self.windowSize.width * 1.5
                    } else if x < self.windowSize.width * 0.5 {
                        x = self.windowSize.width * 0.5
                    }
                }
                
                self.updateDockPosition(
                    to: CGPoint(
                        x: x,
                        y: y
                    )
                )
                print(x, y)
                completion()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAppFrom(_ url: URL) -> (ATApp?, ATAppCategoryType?) {
        let appBundle = Bundle(url: url)
        
        let appIcon = NSWorkspace.shared.icon(forFile: url.path)
        
        let appCategory = appBundle?.object(forInfoDictionaryKey: "LSApplicationCategoryType") as? String
        
        var appName: String?
        if let displayName = appBundle?.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            appName = displayName
        } else if let bundleName = appBundle?.object(forInfoDictionaryKey: "CFBundleName") as? String {
            appName = bundleName
        } else {
            appName = url.deletingPathExtension().lastPathComponent
        }
        
        var appIdentifier: String?
        if let bundleIdentifier = appBundle?.bundleIdentifier {
            appIdentifier = bundleIdentifier
        } else if let infoDictionary = NSDictionary(contentsOf: url.appendingPathComponent("Contents/Info.plist")),
                  let identifier = infoDictionary["CFBundleIdentifier"] as? String {
            appIdentifier = identifier
        }
        
        var appSource: ATAppSource? = nil
        let appStoreReceiptURL = url.appendingPathComponent("Contents/_MASReceipt/receipt")
        let fileManager = FileManager()
        if fileManager.fileExists(atPath: appStoreReceiptURL.path) {
            appSource = .AppStore
        }
        
        if let name = appName, let identifier = appIdentifier {
            var app: ATApp?; var category: ATAppCategoryType?
            app = ATApp(
                name: name,
                identifier: identifier,
                category: ATAppCategoryType(rawValue: appCategory ?? ""),
                icon: appIcon,
                source: appSource
            )
            
            if let appCategory = appCategory {
                category = ATAppCategoryType(rawValue: appCategory)
            }
            
            return (app, category)
        } else {
            return (nil, nil)
        }
    }
    
    private func getAllApplications() {
        let fileManager = FileManager.default
        let applicationsURLs = [URL(fileURLWithPath: "/Applications"), URL(fileURLWithPath: "/System/Applications")]
        
        for applicationsURL in applicationsURLs {
            if let appURLs = getApplicationURLs(in: applicationsURL, fileManager: fileManager) {
                for appURL in appURLs {
                    let (app, category) = getAppFrom(appURL)
                    if let app = app {
                        self.apps.insert(app)
                    }
                    if let category = category {
                        self.categories.insert(category)
                    }
                }
            }
        }
    }

    private func getApplicationURLs(in directoryURL: URL, fileManager: FileManager) -> [URL]? {
        guard let directoryContents = try? fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil, options: [.skipsHiddenFiles]) else {
            return nil
        }
        
        var appURLs: [URL] = []
        
        for url in directoryContents {
            if url.pathExtension == "app" {
                appURLs.append(url)
            } else if url.hasDirectoryPath {
                if let nestedAppURLs = getApplicationURLs(in: url, fileManager: fileManager) {
                    appURLs.append(contentsOf: nestedAppURLs)
                }
            }
        }
        
        return appURLs
    }
    
    public func searchApp(with search: String) -> [ATApp] {
        if search == "" {
            return self.apps.sorted(by: { $0.name < $1.name })
        } else {
            return self.apps.filter({ $0.name.lowercased().contains(search) }).sorted(by: { $0.name < $1.name })
        }
    }
    
}
