%dw 2.0
import * from dw::test::Tests
import * from dw::test::Asserts

import * from Binaries
---
"Binaries" describedBy [
    "fromHexToBase64" describedBy [
        "It should convert a hex string to base64" in do {
            fromHexToBase64("49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d") 
                must equalTo("SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t")
        },
    ],
    "fromHexToBinary" describedBy  [
        "It should convert a hex string to Binary" in do {
            fromHexToBinary("1234") must equalTo(["0001", "0010", "0011", "0100"])
        }
    ],
    "fromHexToString" describedBy [
        "It should convert a hex string to a ASCII string" in do {
            fromHexToString("68656C6C6F") must equalTo("hello")
        }
    ],
    "fromStringToHex" describedBy  [
        "It should convert a string to a hex string" in do {
            fromStringToHex("hello") must equalTo("68656C6C6F")
        }
    ],
    "fromBase64ToBinary" describedBy  [
        "It should convert a base64 string to Binary" in do {
            fromBase64ToBinary("Hello") must equalTo(["000111", "011110", "100101", "100101", "101000"])
        }
    ],
    "fromBinaryToHex" describedBy [
        "It should convert a binary to hex" in do {
            fromBinaryToHex(["0001", "0010", "0011", "0100"]) must equalTo("1234")
        },
        "It should convert binary from 'hello' string into hex" in do {
            fromBinaryToHex(["01101000","01100101","01101100","01101100","01101111"]) must equalTo("68656C6C6F")
        }
    ],
    "divideBy2" describedBy  [
        "It should convert decimal numbers to binary numbers" in do {
            divideBy2(233) must equalTo("11101001")
        }
    ],
    "fromStringToBinary" describedBy  [
        "It should convert a string to binary numbers" in do {
            fromStringToBinary("man\n") must equalTo(["01101101", "01100001", "01101110", "00001010"])
        },
        "It should convert hello to binary numbers" in do {
            fromStringToBinary("hello") must equalTo(["01101000","01100101","01101100","01101100","01101111"])
        }
    ],
    "fromBinaryToString" describedBy  [
        "It should convert a binary array to a string" in do {
            fromBinaryToString(["01101101", "01100001", "01101110", "00001010"]) must equalTo("man\n")
        }
    ],
    "findDecimalOfBinary" describedBy  [
        "It should convert a binary number to a decimal" in do {
            findDecimalOfBinary("10011") must equalTo(19)
        }
    ],
    "fromBinaryToHex" describedBy [
        "It should convert a binary array to a Hex string" in do {
            fromBinaryToHex(["01101101", "01100001", "01101110", "00001010"]) must equalTo("6D616E0A")
        }
    ],
    "fromBinaryToBase64" describedBy  [
        "It should convert a binary array to a base64 string" in do {
            fromBinaryToBase64(["01101101", "01100001", "01101110", "00001010"]) must equalTo("bWFuCg==")
        }
    ]
]
