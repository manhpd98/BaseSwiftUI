//
//  ContentViewModel.swift
//  BaseSwiftUI
//
//  Created by Duc Manh on 2020/11/26.
//

import Foundation
import Combine

/// The view model of ContentViewModel
class ContentViewModel: ObservableObject {
    private var disposables = Set<AnyCancellable>()

    /// Call api SignIn to sign in
    func testRequestApi() {
        let parameters = TestParameters(test: "")
        let testRequest: AnyPublisher<EmptyResponse, Error> = ApiServices.request(.testParameters(parameters: parameters))
        testRequest
            // Receive the response on Main thread
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                    case .failure(let error): print(error)
                    case .finished: break
                }
            }) { response in
              /// response
            }.store(in: &disposables)
    }
}

