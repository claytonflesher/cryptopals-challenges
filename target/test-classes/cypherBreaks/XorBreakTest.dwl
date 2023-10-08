%dw 2.0
import * from dw::test::Tests
import * from dw::test::Asserts

import * from cypherBreaks::XorBreak
import * from dw::core::Binaries
import hexToBinaryTable, fromHexToBinary, fromStringToBinary, fromBinaryToHex, 
       fromBinaryToString, fromHexToString, fromStringToHex from Binaries
import fixedXor from algorithms::Xor
import rightPad from dw::core::Strings
---
"XorBreak" describedBy [
    "singleCharacterXorScores" describedBy [
        "It should score every hex character against a hex string" in do {
            do {
                var scores = {
                    "0": 0,"6": 0,"C": 0,"1": 0,"7": 0,"D": 0,"2": 0,
                    "8": 0,"E": 0,"3": 0,"9": 0,"F": 0,"4": 0,"A": 1,
                    "5": 0,"B": 0
                }
                var xorEntry = fixedXor("68", "AA")
                ---
                singleCharacterXorScores(xorEntry) must equalTo(scores)
            }
        },
        "It should score A to be highest when hello world is encoded with that hex character" in do {
            do {
                var secret = fromStringToHex("A")
                var xorEntry = fixedXor(fromStringToHex("hello world"), rightPad(secret, 10, secret))
                var scores = singleCharacterXorScores(xorEntry)
                var topScore = (valuesOf(scores) orderBy -$)[0]
                var highestScores = scores filterObject ((value) -> value == topScore)
                ---
                log(highestScores) must  equalTo({A: 10, a: 10})
            }
        },
        "It should score 1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736" in do {
            do {
                var scores = {
                    "0": 0,  "6": 6, "C": 0, "1": 14, "7": 18, "D": 0,  "2": 0,
                    "8": 0,  "E": 0, "3": 1, "9": 0,  "F": 0,  "4": 15, "A": 0,
                    "5": 17, "B": 0
                }
                var hexString = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"
                ---
                singleCharacterXorScores(hexString) must equalTo(scores)
            }
        }
    ],
    "xorDecryptString" describedBy  [
        "It should decrypt a hex string when given a single character hex secret" in do {
            xorDecryptHexString("123A", "A") must equalTo("B890")
        },
        "It should convert hello as Hex string when given a single character hex secret" in do {
            do {
                var xorEncryptedHello = fixedXor(fromBinaryToHex(fromStringToBinary("hello")), "AAAAAAAAAA")
                ---
                xorDecryptHexString("68656C6C6F", "A") must equalTo(xorEncryptedHello)
            }
        },
        "It gives us back hello when we fromHexToString the xorDecrypted String" in do {
            do {
                var xorEncryptedHello = fixedXor(fromBinaryToHex(fromStringToBinary("hello")), "AAAAAAAAAA")
                var hello = fromHexToString((xorDecryptHexString(xorEncryptedHello, "A")))
                ---
                hello must equalTo("hello")
            }
        }
    ],
    "scoreString" describedBy [
        "It should score a string with two 'e's as 4" in do {
            scoreString("ee") must equalTo(4)
        },
        "It should score a string of hello as 7" in do {
            scoreString("hello") must equalTo(7)
        },
        "It should score a string of xyz as 0" in do {
            scoreString("xyz") must equalTo(0)
        }
    ],
    "scoreHexString" describedBy  [
        "It should score a hexString built from hello as 5" in do {
            var hello = fromStringToHex("hello")
            ---
            scoreHexString(hello) must equalTo(7)
        }
    ]
]
