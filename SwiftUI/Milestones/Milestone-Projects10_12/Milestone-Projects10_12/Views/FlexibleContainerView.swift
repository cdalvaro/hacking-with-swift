//
//  FlexibleContainerView.swift
//  Milestone-Projects10_12
//
//  Created by Carlos Álvaro on 9/11/23.
//

import SwiftUI

// Sources:
// https://www.fivestars.blog/articles/flexible-swiftui/
// https://stackoverflow.com/a/64024339/3398062

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

struct FlexibleContainerView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let availableWidth: CGFloat
    let data: Data
    let spacing: CGFloat
    let aligment: HorizontalAlignment
    let content: (Data.Element) -> Content

    @State var elementsSize: [Data.Element: CGSize] = [:]

    var body: some View {
        VStack(alignment: aligment, spacing: spacing) {
            ForEach(computedRows(), id: \.self) { rowElements in
                HStack(spacing: spacing) {
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                            .fixedSize()
                            .readSize { size in
                                elementsSize[element] = size
                            }
                    }
                }
            }
        }
    }

    private func computedRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth

        for element in data {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]

            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow += 1
                rows.append([element])
                remainingWidth = availableWidth
            }

            remainingWidth -= elementSize.width + spacing
        }

        return rows
    }
}

#Preview {
    FlexibleContainerView(availableWidth: 200,
                          data: [
                              "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the", "troublemakers", "the", "round", "pegs", "in", "the", "square", "holes", "the", "ones", "who", "see", "things", "differently", "they’re", "not", "fond", "of", "rules"
                          ],
                          spacing: 15,
                          aligment: .leading)
    { item in
        Text(verbatim: item)
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
            )
    }
}
