/**
 * Parse a JSON value
 * @return Parsed value or undefined if invalid
 */
parseValue() {
    self skipWhitespace();
    
    if(self.index >= self.jsonText.size)
        return undefined;
        
    char = self.jsonText[self.index];
    
    switch(char) {
        case "{":
            return self parseObject();
        case "[":
            return self parseArray();
        case "\"":
            return self parseString();
        case "-":
        case "0":
        case "1":
        case "2":
        case "3":
        case "4":
        case "5":
        case "6":
        case "7":
        case "8":
        case "9":
            return self parseNumber();
        default:
            return self parseLiteral();
    }
}

/**
 * Parse a JSON object
 * @return Object structure or undefined if invalid
 */
parseObject() {
    result = [];
    self.index++;
    
    while(self.index < self.jsonText.size) {
        self skipWhitespace();
        
        // Check for empty object or end of object
        if(self.jsonText[self.index] == "}") {
            self.index++;
            return result;
        }
        
        // Parse key
        key = self parseString();
        if(!isDefined(key))
            return undefined;
            
        self skipWhitespace();
        
        // Expect colon
        if(self.jsonText[self.index] != ":")
            return undefined;
            
        self.index++;
        
        // Parse value
        value = self parseValue();
        if(!isDefined(value))
            return undefined;
            
        result[key] = value;
        
        self skipWhitespace();
        
        // Check for comma or end of object
        if(self.jsonText[self.index] == "}") {
            self.index++;
            return result;
        }
        
        if(self.jsonText[self.index] != ",")
            return undefined;
            
        self.index++;
    }
    
    return undefined;
}

/**
 * Parse a JSON array
 * @return Array or undefined if invalid
 */
parseArray() {
    result = [];
    self.index++; // Skip [
    
    while(self.index < self.jsonText.size) {
        self skipWhitespace();
        
        if(self.jsonText[self.index] == "]") {
            self.index++;
            return result;
        }
        
        value = self parseValue();
        if(!isDefined(value))
            return undefined;
            
        result[result.size] = value;
        
        self skipWhitespace();
        
        // Check for comma or end of array
        if(self.jsonText[self.index] == "]") {
            self.index++;
            return result;
        }
        
        if(self.jsonText[self.index] != ",")
            return undefined;
            
        self.index++;
    }
    
    return undefined;
}

/**
 * Parse a JSON string
 * @return String value or undefined if invalid
 */
parseString() {
    if(self.jsonText[self.index] != "\"")
        return undefined;
        
    result = "";
    self.index++; 
    
    while(self.index < self.jsonText.size) {
        char = self.jsonText[self.index];
        
        if(char == "\"") {
            self.index++;
            return result;
        }
        
        result += char;
        self.index++;
    }
    
    return undefined;
}

/**
 * Skip whitespace characters
 */
skipWhitespace() {
    while(self.index < self.jsonText.size) {
        char = self.jsonText[self.index];
        if(char != " " && char != "\t" && char != "\n" && char != "\r")
            break;
        self.index++;
    }
}

/**
 * Parse a JSON number
 * @return Number value or undefined if invalid
 */
parseNumber() {
    numStr = "";
    
    while(self.index < self.jsonText.size) {
        char = self.jsonText[self.index];
        if(char != "-" && char != "." && (char < "0" || char > "9"))
            break;
        numStr += char;
        self.index++;
    }
    
    return int(numStr);
}

/**
 * Parse JSON literals (true, false, null)
 * @return Literal value or undefined if invalid
 */
parseLiteral() {
    if(self.index + 3 >= self.jsonText.size)
        return undefined;

    if(self.jsonText[self.index] == "t" &&
       self.jsonText[self.index + 1] == "r" &&
       self.jsonText[self.index + 2] == "u" &&
       self.jsonText[self.index + 3] == "e") {
        self.index += 4;
        return level.JSON_TRUE;
    }
    
    if(self.index + 4 >= self.jsonText.size)
        return undefined;
        
    if(self.jsonText[self.index] == "f" &&
       self.jsonText[self.index + 1] == "a" &&
       self.jsonText[self.index + 2] == "l" &&
       self.jsonText[self.index + 3] == "s" &&
       self.jsonText[self.index + 4] == "e") {
        self.index += 5;
        return level.JSON_FALSE;
    }
    
    if(self.index + 3 >= self.jsonText.size)
        return undefined;
        
    if(self.jsonText[self.index] == "n" &&
       self.jsonText[self.index + 1] == "u" &&
       self.jsonText[self.index + 2] == "l" &&
       self.jsonText[self.index + 3] == "l") {
        self.index += 4;
        return level.JSON_NULL;
    }
    
    return undefined;
}