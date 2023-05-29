//
//  NetworkManager.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/15.
//

import Foundation

typealias RequestParameters = [String: String]

final class NetworkManager {
   static let dummyURLString = "https://example.com"
   static let defaultPagingOffSet = 10
   
   private let baseURL = "http://43.200.199.205:8080/api"
   
   private let session: URLSessionInterface
   
   init(session: URLSessionInterface = URLSession.shared) {
      self.session = session
   }
   
   private func getData<T: Decodable>(
      for urlString: String,
      with query: [String: String]? = nil,
      dataType: T.Type,
      completion: @escaping (Result<T, Error>) -> Void)
   {
      let url: URL?
      if let query {
         guard var urlcomponent = URLComponents(string: urlString) else { return }
         let queryItems = query.map { item in URLQueryItem(name: item.key, value: item.value) }
         urlcomponent.queryItems = queryItems
         url = urlcomponent.url
      } else {
         url = URL(string: urlString)
      }
      guard let url else { return }
      var request = URLRequest(url: url)
      request.timeoutInterval = 15
      
      let completionHandler = { @Sendable (data: Data?, response: URLResponse?, error: Error?) in
         if let error {
            completion(.failure(error))
            return
         }
         
         guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
            completion(.failure(NetworkError.noResponse))
            return
         }
         
         guard let data else {
            completion(.failure(NetworkError.invalidData))
            return
         }
         
         do {
            let newData = try JSONDecoder().decode(dataType, from: data)
            completion(.success(newData))
            return
         } catch {
            completion(.failure(NetworkError.failToParse))
            return
         }
      }
      
      let dataTask = session.dataTask(with: request, handler: completionHandler)
      dataTask.resume()
   }
   
   // MARK: - Util
   
   func requestIssueList(filterList: FilterApplyList? = nil, pageNumber: Int? = nil, completion: @escaping (IssueListDTO) -> Void) {
      let issueListURL = baseURL + "/issues"
      
      var query: RequestParameters = [:]
      if let filters = filterList?.makeQuery() { filters.forEach { filter in query.updateValue(filter.value, forKey: filter.key) } }
      if let pageNumber {
         query.updateValue("\(Self.defaultPagingOffSet)", forKey: "offset")
         query.updateValue("\(pageNumber)", forKey: "pageNum")
      }
      
      getData(for: issueListURL,
                with: query,
                dataType: IssueListDTO.self) { result in
         switch result {
         case .success(let issueList):
            completion(issueList)
         case .failure(let error):
            print(error)
         }
      }
   }
   
   func requestIssueDetail(issueId: Int, completion: @escaping (IssueDetailDTO) -> Void) {
      let issueDetailURL = baseURL + "/issues/\(issueId)"
      
      getData(for: issueDetailURL,
                dataType: IssueDetailDTO.self) { result in
         switch result {
         case .success(let dto):
            completion(dto)
         case .failure(let error):
            print(error)
         }
      }
   }
   
   func requestLabelList(completion: @escaping (LabelListDTO) -> Void) {
      let labelListURL = baseURL + "/labels"
      
      getData(for: labelListURL,
                dataType: LabelListDTO.self) { result in
         switch result {
         case .success(let dto):
            completion(dto)
         case .failure(let error):
            print(error)
         }
      }
   }
   
   func requestMilestoneList(completion: @escaping (MilestoneListDTO) -> Void) {
      let url = baseURL + "/milestones"
      
      getData(for: url,
                dataType: MilestoneListDTO.self) { result in
         switch result {
         case .success(let dto):
            completion(dto)
         case .failure(let error):
            print(error)
         }
      }
   }
}
