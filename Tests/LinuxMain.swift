import XCTest
import Quick

@testable import AOCTests

QCKMain([
          DayOne_InverseCaptchaSpec.self,
          DayTwo_ChecksumSpec.self,
          DayThree_SpiralMemorySpec.self,
          DayFour_HighEntropyPassphrases.self,
          DayFive_AMazeOfTwistyTrampolinesSpec.self,
          DaySix_MemoryReallocationSpec.self,
          DaySeven_RecursiveCircusSpec.self,
        ])
