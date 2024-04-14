//
//  File.swift
//  
//
//  Created by Nevio Hirani on 14.04.24.
//

import Foundation
import SwiftUI

@available(iOS 17.0, *)
class SCNImageCache {
    static let shared = SCNImageCache()
    private init() {}

    private let cache = URLCache(memoryCapacity: 100 * 1024 * 1024, // 100 MB memory cache
                                 diskCapacity: 500 * 1024 * 1024,   // 500 MB disk cache
                                 diskPath: nil)

    func getCachedImage(url: URL) -> Image? {
        if let data = cache.cachedResponse(for: URLRequest(url: url))?.data {
            if let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        }
        return nil
    }

    func cacheImage(data: Data, response: URLResponse) {
        let cachedData = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedData, for: URLRequest(url: response.url!))
    }
}

