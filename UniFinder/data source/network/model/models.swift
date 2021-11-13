// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let aPIResponse = try? newJSONDecoder().decode(APIResponse.self, from: jsonData)

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseAPIResponse { response in
//     if let aPIResponse = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

// MARK: - APIResponse
struct APIResponse<T:Codable>: Codable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: T?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseResult { response in
//     if let result = response.result.value {
//       ...
//     }
//   }

// MARK: - Result
struct UniversityDTO: Codable {
    let pk: Int?
    let thumbnail, logo: String?
    let ulScore: Double?
    let name: String?
        let province: Province?
        let country: Country?
        let url, apiURL, slug: String?
        let isFavorited: Bool?
        let averageTuition: String?
        let averageTuitionCurrency: String?
        let hasBachelor, hasMaster, hasOnline: Bool?
        let homePageOrder: Int?
        let isBright: Bool?
        let minIelts, minToefl: Int?

        enum CodingKeys: String, CodingKey {
            case pk, thumbnail, logo
            case ulScore = "ul_score"
            case name, province, country, url
            case apiURL = "api_url"
            case slug
            case isFavorited = "is_favorited"
            case averageTuition = "average_tuition"
            case averageTuitionCurrency = "average_tuition_currency"
            case hasBachelor = "has_bachelor"
            case hasMaster = "has_master"
            case hasOnline = "has_online"
            case homePageOrder = "home_page_order"
            case isBright = "is_bright"
            case minIelts = "min_ielts"
            case minToefl = "min_toefl"
        }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCountry { response in
//     if let country = response.result.value {
//       ...
//     }
//   }

// MARK: - Country
struct Country: Codable {
    let pk: Int?
    let slug, name: String?
    let image: String?
    let internetScoreAvg, airScoreAvg, safetyScoreAvg, costScoreAvg: Double?
    let purchasingPower, propertyPriceToIncomeRatio, trafficCommuteTime, pollution: Int?

    enum CodingKeys: String, CodingKey {
        case pk, slug, name, image
        case internetScoreAvg = "internet_score_avg"
        case airScoreAvg = "air_score_avg"
        case safetyScoreAvg = "safety_score_avg"
        case costScoreAvg = "cost_score_avg"
        case purchasingPower = "purchasing_power"
        case propertyPriceToIncomeRatio = "property_price_to_income_ratio"
        case trafficCommuteTime = "traffic_commute_time"
        case pollution
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseProvince { response in
//     if let province = response.result.value {
//       ...
//     }
//   }

// MARK: - Province
struct Province: Codable {
    let pk: Int?
    let name: String?
    let image: String?
    let slug: String?
    let internetScore: Double?
    let internetSpeed, airScore, safetyScore, costScore: Int?
    let purchasingPower, healthCare, propertyPriceToIncomeRatio, pollution: Int?
    let trafficCommuteTime, qualityOfLife: Int?
    let population: String?

    enum CodingKeys: String, CodingKey {
        case pk, name, image, slug
        case internetScore = "internet_score"
        case internetSpeed = "internet_speed"
        case airScore = "air_score"
        case safetyScore = "safety_score"
        case costScore = "cost_score"
        case purchasingPower = "purchasing_power"
        case healthCare = "health_care"
        case propertyPriceToIncomeRatio = "property_price_to_income_ratio"
        case pollution
        case trafficCommuteTime = "traffic_commute_time"
        case qualityOfLife = "quality_of_life"
        case population
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Alamofire response handlers

