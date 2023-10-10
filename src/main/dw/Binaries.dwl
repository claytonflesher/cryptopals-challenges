%dw 2.4

import substringEvery, rightPad, leftPad from dw::core::Strings

var hexToBinaryTable = {
    "0": "0000", "6": "0110", "C": "1100",
    "1": "0001", "7": "0111", "D": "1101",
    "2": "0010", "8": "1000", "E": "1110",
    "3": "0011", "9": "1001", "F": "1111",
    "4": "0100", "A": "1010",  
    "5": "0101", "B": "1011",
}

var binaryToHexTable = 
    hexToBinaryTable mapObject ((value, key) -> (value as String): key as String)

var base64ToBinaryTable = {
    "A": "000000", "Q": "010000", "g": "100000", "w": "110000",
    "B": "000001", "R": "010001", "h": "100001", "x": "110001",
    "C": "000010", "S": "010010", "i": "100010", "y": "110010",
    "D": "000011", "T": "010011", "j": "100011", "z": "110011",
    "E": "000100", "U": "010100", "k": "100100", "0": "110100",
    "F": "000101", "V": "010101", "l": "100101", "1": "110101",
    "G": "000110", "W": "010110", "m": "100110", "2": "110110",
    "H": "000111", "X": "010111", "n": "100111", "3": "110111",
    "I": "001000", "Y": "011000", "o": "101000", "4": "111000",
    "J": "001001", "Z": "011001", "p": "101001", "5": "111001",
    "K": "001010", "a": "011010", "q": "101010", "6": "111010",
    "L": "001011", "b": "011011", "r": "101011", "7": "111011",
    "M": "001100", "c": "011100", "s": "101100", "8": "111100",
    "N": "001101", "d": "011101", "t": "101101", "9": "111101",
    "O": "001110", "e": "011110", "u": "101110", "+": "111110",
    "P": "001111"
}

var binaryToBase64Table =
    base64ToBinaryTable mapObject ((value, key) -> (value as String): key as String)

fun fromHexToBase64(data: String): String =
    (fromHexToBinary(data) joinBy "")
    then (binary) -> substringEvery(binary, 6)
    then (binaries) -> binaries map ((binary) -> rightPad(binary, 6, "0"))
    then (binaries) -> fromBinaryToBase64(binaries)

fun fromHexToBinary(data: String): Array<String> =
    do {
        var characters = data splitBy ""
        ---
        characters map ((character) -> hexToBinaryTable[upper(character)])
    }

fun fromHexToString(hexString: String): String =
    do {
        var eightBitBinaries = substringEvery((fromHexToBinary(hexString) joinBy  ""), 8)
        ---
        fromBinaryToString(eightBitBinaries)
    }

fun fromStringToHex(string: String): String =
    fromBinaryToHex(fromStringToBinary(string))

fun fromBase64ToBinary(data: String): Array<String> =
    do {
        var characters = data splitBy  ""
        ---
        characters map ((character) -> base64ToBinaryTable[character])
    }

fun fromBinaryToHex(data: Array<String>): String =
    substringEvery((data joinBy ""), 4)
    then (binaries) -> binaries map ((binary) -> rightPad(binary, 4, "0"))
    then (data) -> (data map ((number) -> (binaryToHexTable[number]) as String)) joinBy  ""

fun fromBinaryToBase64(data: Array<String>): String =
    substringEvery((data joinBy ""), 6)
    then (binaries) -> binaries map ((binary) -> rightPad(binary, 6, "0"))
    then (binaries) -> binaries map ((binary) -> binaryToBase64Table[binary])
    then (data) -> (data joinBy "")
    then (data) -> base64Padding(data)

fun divideBy2(decimalNumber: Number, results: Array<String> = []): String =
    if(decimalNumber > 0)  
        do {
            var remainder = (decimalNumber mod 2) as String
            var newDecimalNumber = floor(decimalNumber / 2)
            ---
            divideBy2(newDecimalNumber, [remainder] ++ results)
        }
    else
        results joinBy ""

fun fromStringToBinary(string: String): Array<String> =
    (string splitBy "") map ((character) -> eightBitPadding(divideBy2(character as Binary as Number)))

fun fromBinaryToString(binaryArray: Array<String>): String =
    binaryArray map ((binary) -> findDecimalOfBinary(binary) as Binary as String) joinBy  ""

fun findDecimalOfBinary(string: String): Number =
    do {
        var numbers = (string splitBy  "") map $ as Number
        ---
        numbers[1 to -1] reduce ((item, accumulator = numbers[0]) -> (accumulator * 2) + item)
    }

fun eightBitPadding(string: String): String =
    leftPad(string, 8, "0")

fun base64Padding(string: String): String =
    if ((sizeOf(string) mod 4) != 0)
        base64Padding(string ++ "=")
    else
        string