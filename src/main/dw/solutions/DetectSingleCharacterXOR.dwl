%dw 2.4
import singleCharacterXorScores from cypherBreaks::XorBreak
fun findSingleCharacterXor(file: String) =
    do {
        var lines = file splitBy "\n"
        var scores = lines map ((line, index) -> {
            scores: findHighestScore(singleCharacterXorScores(line)),
            lineIndex: index,
            line: line
        })
        ---
        scores reduce ((entry, accumulator) -> 
            if(valuesOf(entry.scores)[0] > valuesOf(accumulator.scores)[0])
                entry
            else
                accumulator
        )
    }

fun findHighestScore(scores: Object): Object =
    (valuesOf(scores) orderBy -$)[0]
    then (topScore) -> (scores filterObject ((value) -> value == topScore))
