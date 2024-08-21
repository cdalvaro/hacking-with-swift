//
//  RatingView.swift
//  Bookworm
//
//  Created by Carlos Álvaro on 5/7/23.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    var label = ""
    var maximumRating = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1 ... maximumRating, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundColor(number > rating ? offColor : onColor)
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityElement()
        .accessibilityLabel(label)
        .accessibilityValue(String(AttributedString(localized: "^[\(rating) \("star")](inflect: true)").characters))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maximumRating { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1 }
            default:
                break
            }
        }
    }

    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        }

        return onImage
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
