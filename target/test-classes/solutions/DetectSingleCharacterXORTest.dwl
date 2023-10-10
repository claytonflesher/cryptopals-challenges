%dw 2.0
import * from dw::test::Tests
import * from dw::test::Asserts

import * from solutions::DetectSingleCharacterXOR
---
"DetectSingleCharacterXOR" describedBy [
    "findSingleCharacterXor" describedBy [
        "It returns the Object we think is xor'd with a single character" in do {
            do {
                var file = readUrl("classpath://samples/single_character_xor_find_small.txt", "text/plain") as String
                var answer = 
                {
                    scores: {
                        "5": 29
                    },
                    lineIndex: 5,
                    line: "7b5a4215415d544115415d5015455447414c155c46155f4058455c5b523f"
                }
                ---
                log(findSingleCharacterXor(file)) must equalTo(answer)
            }
        }
    ]
]
