#include scripts\mp\json\_json;

init() {
    initParser(); // Initialize the JSON parser

    println("===============================");
    println("Manual Value Access Example");
    println("===============================");

    jsonString = "{\"name\":\"John\",\"age\":29,\"isAdmin\":false,\"scores\":[100,95,88],\"settings\":{\"theme\":\"dark\",\"notifications\":false}}";
    parsed = parseJSON(jsonString);

    if(isDefined(parsed)) {
        println("Name: " + parsed["name"]);
        println("Scores: " + parsed["scores"][0] + ", " + parsed["scores"][1] + ", " + parsed["scores"][2]);
        println("Settings Notifications: " + parsed["settings"]["notifications"]);
    } else { println("^1JSON Parsing Failed!"); }
}