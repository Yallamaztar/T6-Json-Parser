/**
 * Reads a file from the specified path and returns its contents as a string.
 * 
 * @param path The path to the file relative to the game's root directory
 * @return String containing the file contents, or "" if file cannot be read
 */
readFile(path) {
    if (!isDefined(path)) {
        println("ReadFile Error: No file path provided");
        return;
    }
    
    fileHandle = fs_fopen(path, "read");
    if (!isDefined(fileHandle)) {
        println("ReadFile Error: Could not open file: " + path);
        return;
    }
    
    contents = "";
    
    while(true) {
        line = fs_readline(fileHandle);
        if (!isDefined(line))
            break;
            
        contents += line;
    }

    fs_fclose(fileHandle);
    println("ReadFile: Successfully read file: " + path);
    println("ReadFile: Content length: " + contents.size);
    
    return contents;
}
/**
 * Safely attempts to read a JSON file with error handling.
 * 
 * @param path The path to the JSON file
 * @return String containing the JSON contents, or "" if operation fails
 */
readJSONFile(path) {
    if (fs_testfile(path) == 0) {
        println("ReadFile Error: File does not exist: " + path);
        return;
    }
    
    contents = readFile(path);
    if (!isDefined(contents) || contents == "") {
        println("ReadFile Error: File is empty or could not be read: " + path);
        return;
    }

    return contents;
}

/**
 * Writes a JSON string to a file.
 * 
 * @param path The name of the file to write to
 * @param json The JSON string to write
 * @return boolean Success or failure of write operation
 */
writeJSONToFile(path, json) {
    if (!isDefined(path) || !isDefined(json))
        println("writeJSONToFile Error: Invalid parameters passed to writeJSONToFile");
        return;
     
    println("writeJSONToFile called with path: " + path);
    println("JSON content: " + json);
    
    fileHandle = fs_fopen(path, "write");

    if (isDefined(fileHandle) && fileHandle > 0) {
        fs_writeline(fileHandle, json);
        fs_fclose(fileHandle);
 
        println("Successfully wrote JSON to file: " + path);
        return true;
    } else { 
        println("Error: Could not open file for writing: " + path);
        return false;
    }
}

/**
 * Safely appends a JSON object to an array in a JSON file.
 * If the file doesn't exist, creates it with an array containing the JSON.
 * 
 * @param path The path to the JSON file
 * @param json The JSON string to append
 * @return boolean Success or failure of append operation
 */
appendToJSONArray(path, json) {
    if (!isDefined(path) || !isDefined(json)) {
            println("appendToJSONArray Error: Invalid parameters");
        return false;
    }

    existingContent = readFile(path);
    jsonArray = "";

    if (!isDefined(existingContent) || existingContent == "") {
        jsonArray = "[" + json + "]";

    // trim trailing ']' and append
    } else if (existingContent[0] == "[" && existingContent[existingContent.size - 1] == "]") {
        trimmed = getSubStr(existingContent, 0, existingContent.size - 1);
        // Append comma + new JSON + closing bracket
        jsonArray = trimmed + ", " + json + "]";
    } else {
        println("appendToJSONArray Error: Existing content is not a JSON array");
        return false;
    }

    println("Final JSON Array to Write: " + jsonArray);
    return writeJSONToFile(path, jsonArray);
}