%dw 2.0
import * from dw::test::Tests
import * from dw::test::Asserts

import * from algorithms::Xor
import rightPad, substring from dw::core::Strings
import fromHexToString, fromStringToHex from Binaries
---
"Xor" describedBy [
    "fixedXor" describedBy [
        "It applies a fixed Xor algorithm when given a hex string and equally long hex secret" in do {
            fixedXor("57", "F3") must equalTo("A4")
        },
        "It applies a fixed Xor algorithm when given a hex string of 69 and a secret of F3" in do {
            fixedXor("69", "F3") must equalTo("9A") 
        },
        "It applies a fixed Xor algorithm when given a longer hex string and secret" in do {
            do {
                var left = upper("1c0111001f010100061a024b53535009181c")
                var right = upper("686974207468652062756c6c277320657965")
                ---
                fixedXor(left, right) must equalTo(upper("746865206b696420646f6e277420706c6179"))
            }
        },
        "It applies a fixed Xor algorithm when given 123A and AAAA and returns B890" in do {
            fixedXor("123A", "AAAA") must equalTo(upper("B890"))
        },
        "It applies a fixed Xor to 1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736 with a key of X" in do {
            var hexString = upper("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736")
            var key = fromStringToHex("X")
            var secret = substring(rightPad(key, sizeOf(hexString), key), 0, sizeOf(hexString))
            ---
            fromHexToString(fixedXor(hexString, secret)) must equalTo("Cooking MC's like a pound of bacon")
        },
        "It applies a fixed Xor to 7b5a4215415d544115415d5015455447414c155c46155f4058455c5b523f with a key of 5" in do {
            var hexString = upper("7b5a4215415d544115415d5015455447414c155c46155f4058455c5b523f")
            var key = fromStringToHex("5")
            var secret = substring(rightPad(key, sizeOf(hexString), key), 0, sizeOf(hexString))
            ---
            fromHexToString(fixedXor(hexString, secret)) must equalTo("Now that the party is jumping\n")
        }
    ],
    "repeatingKeyXor" describedBy  [
        "It applies a repeating-key Xor to 1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736 with a key of X" in do {
            var hexString = upper("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736")
            var secret = fromStringToHex("X")
            ---
            fromHexToString(repeatingKeyXor(hexString, secret)) must equalTo("Cooking MC's like a pound of bacon")
        },
        "It applies a repeating-key Xor to 7b5a4215415d544115415d5015455447414c155c46155f4058455c5b523f with a key of 5" in do {
            var hexString = upper("7b5a4215415d544115415d5015455447414c155c46155f4058455c5b523f")
            var secret = fromStringToHex("5")
            ---
            fromHexToString(repeatingKeyXor(hexString, secret)) must equalTo("Now that the party is jumping\n")
        },
        "It applies a repeating-key Xor to the sample file" in do {
            var file = readUrl("classpath://samples/repeating_key_xor.txt", "text/plain") as String
            var secret = fromStringToHex("ICE")
            var statement = repeatingKeyXor(fromStringToHex(file), secret)
            var expectedResult = "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272" ++
                "a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f"
            ---
            lower(statement) must equalTo(expectedResult)
        },
    ]
]
