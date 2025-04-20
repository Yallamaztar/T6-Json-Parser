#include scripts\mp\json\_json;

init() {
    initParser(); // Initialize the JSON parser

    println("=====================");
    println("Parse and print Example");
    println("=====================");

    jsonString = "{\"name\":\"John\",\"age\":29,\"isAdmin\":false,\"scores\":[100,95,88],\"settings\":{\"theme\":\"dark\",\"notifications\":false}}";
    parsed = parseJSON(jsonString);

    if(isDefined(parsed)) {
        self scripts\mp\json\core\utils::printStructure(parsed); // Print the parsed JSON in a structure
        // Optionally, you can also just print the JSON string
        // println(jsonString);
    } else { println("^1JSON Parsing Failed!"); }
}