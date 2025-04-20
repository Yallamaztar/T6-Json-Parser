#include scripts\mp\json\_json;

init() {
    initParser(); // Initialize the JSON parser

    println("===============================");
    println("Invalid JSON Example");
    println("===============================");

    jsonString = "{this is obviously not valid JSON lol}";
    parsed = parseJSON(jsonString);
    
    if(isDefined(parsed)) {
        self scripts\mp\json\core\utils::printStructure(parsed);
    } else { println("^1JSON Parsing Failed!"); }
}