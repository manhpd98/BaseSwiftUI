//
//  DownloadTaskPublisher.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation
import Combine

/// The extension for Download task
extension URLSession {

    /// Create a download task publisher with the given `request`
    /// - Parameter request: The URLRequest of the file
    /// - Returns: A Download task publisher
    func downloadTaskPublisher(for request: URLRequest) -> URLSession.DownloadTaskPublisher {
        return DownloadTaskPublisher(request: request, session: self)
    }

    /// The Publisher of the download task
    struct DownloadTaskPublisher: Publisher {
        // MARK: Properties
        typealias Output = (url: URL, response: URLResponse)
        typealias Failure = URLError

        let request: URLRequest
        let session: URLSession

        /// Inititlization the DownloadTaskPublisher
        /// - Parameters:
        ///   - request: The URLRequest of the file
        ///   - session: The URLSession for the request
        init(request: URLRequest, session: URLSession) {
            self.request = request
            self.session = session
        }

        /// Attaches the specified subscriber to this publisher.
        /// - Parameter subscriber: The subscriber to attach to this Publisher, after which it can receive values.
        func receive<S>(subscriber: S) where S: Subscriber,
            DownloadTaskPublisher.Failure == S.Failure,
            DownloadTaskPublisher.Output == S.Input {
            let subscription = DownloadTaskSubscription(subscriber: subscriber, session: self.session, request: self.request)
            subscriber.receive(subscription: subscription)
        }
    }
}

/// Extension for Download task
extension URLSession {

    /// Define Subscription for Download Task
    final class DownloadTaskSubscription<SubscriberType: Subscriber>: Subscription where
        SubscriberType.Input == (url: URL, response: URLResponse),
        SubscriberType.Failure == URLError {
        // MARK: Properties
        private var subscriber: SubscriberType?
        private weak var session: URLSession!
        private var request: URLRequest
        private var task: URLSessionDownloadTask!

        /// Inititlization of DownloadTaskSubscription
        /// - Parameters:
        ///   - subscriber: The Subscriber type
        ///   - session: The URLSession of the download task
        ///   - request: The URLRequest of the download task
        init(subscriber: SubscriberType, session: URLSession, request: URLRequest) {
            self.subscriber = subscriber
            self.session = session
            self.request = request
        }

        /// Request wtih the Demand
        /// - Parameter demand: The Subscriber Demand
        func request(_ demand: Subscribers.Demand) {
            guard demand > 0 else {
                // When no demand items found, do nothing
                return
            }
            self.task = self.session.downloadTask(with: request) { [weak self] url, response, error in
                if let error = error as? URLError {
                    // There's a failure error
                    self?.subscriber?.receive(completion: .failure(error))
                    return
                }
                guard let response = response else {
                    // There's failure bad server response
                    self?.subscriber?.receive(completion: .failure(URLError(.badServerResponse)))
                    return
                }
                guard let url = url else {
                    self?.subscriber?.receive(completion: .failure(URLError(.badURL)))
                    return
                }
                do {
                    let cacheDir = Constants.Folders.caches
                    let fileUrl = cacheDir.appendingPathComponent(UUID().uuidString)
                    try FileManager.default.moveItem(atPath: url.path, toPath: fileUrl.path)
                    _ = self?.subscriber?.receive((url: fileUrl, response: response))
                    self?.subscriber?.receive(completion: .finished)

                } catch {
                    // Throw when cannot save file to the Caches directory
                    self?.subscriber?.receive(completion: .failure(URLError(.cannotCreateFile)))
                }
            }
            self.task.resume()
        }

        /// Cancel the download task
        func cancel() {
            self.task.cancel()
        }
    }
}
