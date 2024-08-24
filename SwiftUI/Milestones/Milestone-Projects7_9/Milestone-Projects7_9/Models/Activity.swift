//
//  Activity.swift
//  Milestone-Projects7_9
//
//  Created by Carlos Álvaro on 9/6/23.
//

import Foundation

class Activity: Codable, Equatable, Identifiable, ObservableObject {
    struct Log: Codable, Identifiable {
        var id = UUID()

        var date: Date
        var duration: Duration
    }

    var id = UUID()

    var name: String
    var icon: String

    @Published var records: [Log]

    var totalTime: Duration {
        records.reduce(Duration.seconds(0)) { partialResult, record in
            partialResult + record.duration
        }
    }

    enum CodingKeys: String, CodingKey {
        case name
        case icon
        case records
    }

    init(name: String, icon: String, records: [Log] = []) {
        self.name = name
        self.icon = icon
        self.records = records
    }

    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        icon = try container.decode(String.self, forKey: .icon)
        records = try container.decode([Log].self, forKey: .records)
    }

    static func == (lhs: Activity, rhs: Activity) -> Bool {
        lhs.id == rhs.id
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(icon, forKey: .icon)
        try container.encode(records, forKey: .records)
    }
}
