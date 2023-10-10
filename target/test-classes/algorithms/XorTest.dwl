%dw 2.0
import * from dw::test::Tests
import * from dw::test::Asserts

import * from algorithms::Xor
import rightPad from dw::core::Strings
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
            fixedXor("1c0111001f010100061a024b53535009181c", "686974207468652062756c6c277320657965") must equalTo(upper("746865206b696420646f6e277420706c6179"))
        },
        "It applies a fixed Xor algorithm when given 123A and AAAA and returns B890" in do {
            fixedXor("123A", "AAAA") must equalTo(upper("B890"))
        },
        "It applies a fixed Xor to 1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736 with a key of 7" in do {
            var hexString = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
            var secret = rightPad("58", sizeOf(hexString), "58")
            ---
            fromHexToString(fixedXor(hexString, secret)) must equalTo("Cooking MC's like a pound of bacon")
        },
        "It applies a fixed Xor to 7b5a4215415d544115415d5015455447414c155c46155f4058455c5b523f with a key of 5" in do {
            var hexString = "7b5a4215415d544115415d5015455447414c155c46155f4058455c5b523f"
            var key = fromStringToHex("5")
            var secret = rightPad(key, sizeOf(hexString), key)
            ---
            fromHexToString(fixedXor(hexString, secret)) must equalTo("Now that the party is jumping\n")
        }
    ],
]
