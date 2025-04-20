initParser() {
    level.JSON_NULL = "null";
    level.JSON_TRUE = 1;  
    level.JSON_FALSE = 0;

    setDvar("scr_allowFileIo", "1");
}

/**
 * Parses a JSON string into a GSC structure
 * @param jsonString The JSON string to parse
 * @return Parsed structure or undefined if invalid
 */
parseJSON(jsonString) {
    self.index = 0;
    self.jsonText = jsonString;
    return self scripts\mp\json\core\parser::parseValue();
}



