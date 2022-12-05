//
//  ZIPFoundationErrorConditionTests.swift
//  ZIPFoundation
//
//  Copyright © 2017-2021 Thomas Zoechling, https://www.peakstep.com and the ZIP Foundation project authors.
//  Released under the MIT License.
//
//  See https://github.com/weichsel/ZIPFoundation/blob/master/LICENSE for license information.
//

import XCTest
@testable import ZIPFoundation

extension ZIPFoundationTests {

    func testArchiveInvalidEOCDRecordConditions() {
        let emptyECDR = Archive.EndOfCentralDirectoryRecord(data: Data(),
                                                            additionalDataProvider: {_ -> Data in
            return Data() })
        XCTAssertNil(emptyECDR)
        let invalidECDRData = Data(count: 22)
        let invalidECDR = Archive.EndOfCentralDirectoryRecord(data: invalidECDRData,
                                                              additionalDataProvider: {_ -> Data in
            return Data() })
        XCTAssertNil(invalidECDR)
    }
    
    func testUnzip() {
        let url = URL.init(fileURLWithPath: "/Users/djhan/Desktop/test.zip")
        let targetUrl = URL.init(fileURLWithPath: "/Users/djhan/Desktop/testExtract")
        
        guard FileManager.default.isReadableFile(atPath: url.path) == true else {
            print("파일 접근 불가 에러")
            return
        }
        let fileSystemRepresentation = FileManager.default.fileSystemRepresentation(withPath: url.path)
        guard let _ = fopen(fileSystemRepresentation, "rb") else {
            print("fopen: 파일 접근 불가 에러")
            return
        }

        do {
            try FileManager.default.unzipItem(at: url, to: targetUrl)
        }
        catch {
            print("에러 발생 = \(error)")
        }
    }
}
