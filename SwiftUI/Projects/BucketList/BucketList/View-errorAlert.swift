//
//  View-errorAlert.swift
//  BucketList
//
//  Created by Carlos Álvaro on 12/8/24.
//

import SwiftUI

struct LocalizedAlertError: LocalizedError {
    let underlyingError: Error
    var errorDescription: String? {
        underlyingError.localizedDescription
    }

    init?(_ error: Error?) {
        guard let error else { return nil }
        underlyingError = error
    }
}

extension View {
    func errorAlert(error: Binding<Error?>, buttonTitle: String = "OK") -> some View {
        let localizedAlertError = LocalizedAlertError(error.wrappedValue)
        return alert(isPresented: .constant(localizedAlertError != nil),
                     error: localizedAlertError)
        { _ in
            Button(buttonTitle) {
                error.wrappedValue = nil
            }
        } message: { error in
            Text(error.errorDescription ?? "")
        }
    }
}
