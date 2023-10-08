%dw 2.4

import fromHexToBinary, hexToBinaryTable, fromHexToString from Binaries
import fixedXor from algorithms::Xor
import rightPad from dw::core::Strings
import fromStringToHex from Binaries

var asciiPrintableCharacters = ((1 to 255) as Array map $ as Binary as String) filter ($ matches /[ -~]/)
var hexCharacters = asciiPrintableCharacters map ((character) -> fromStringToHex(character))

fun singleCharacterXorScores(hexString: String): Object =
    do {
        hexCharacters reduce ((character, acc = {}) -> acc ++ {
            (fromHexToString(character)): 
                do {
                    var secret = rightPad(character, sizeOf(hexString), character)
                    var xoredHexString = fixedXor(hexString, secret)
                    ---
                    scoreHexString(xoredHexString)
                }
        })
    }

fun scoreHexString(hexString: String): Number =
    scoreString(fromHexToString(hexString))

fun scoreString(string: String): Number =
    do {
        var candidates = upper(string) splitBy  ""
        var twoPointLetters  = ["E", "T", "A", "O", "I", "N"]
        var onePointLetters  = ["S", "H", "R", "D", "L", "U"]
        var twoPointerScores = twoPointLetters map ((character) -> sizeOf(candidates filter (entry) -> character == entry))
            then (scores) -> sum(scores) * 2
        var onePointerScores = onePointLetters map ((character) -> sizeOf(candidates filter ((entry) -> character == entry)))
            then (scores) -> sum(scores)
        ---
        twoPointerScores + onePointerScores
    }

fun xorDecryptHexString(hexString: String, candidate: String): String =
    do {
        var paddedCandidate = rightPad(candidate, sizeOf(hexString), candidate)
        ---
        fixedXor(hexString, paddedCandidate)
    }
