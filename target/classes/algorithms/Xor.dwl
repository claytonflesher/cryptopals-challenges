%dw 2.4

import * from Binaries
import substringEvery from dw::core::Strings

fun fixedXor(hexString: String, secret: String): String =
    do {
        var binaryInput = (fromHexToBinary(hexString) joinBy  "") splitBy  ""
        var binarySecret = (fromHexToBinary(secret) joinBy  "") splitBy  ""
        ---
        (zip(binaryInput, binarySecret)) reduce ((pair, acc = "") -> 
            if(pair[0] == pair[1]) 
                acc ++ "0" 
            else 
                acc ++ "1")
        then (binary) -> fromBinaryToHex([binary])

    }
