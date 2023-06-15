//
//  EndPointType.swift
//  Weather-Test-Assignment
//
//  Created by Ивченко Антон on 14.06.2023.
//

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String: Any] { get }
}
