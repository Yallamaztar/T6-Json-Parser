/**
 * Recursively prints a parsed structure
 * @param struct The structure to print
 * @param indent Current indentation level
 */
printStructure(struct, indent = "") {
    foreach(key, value in struct) {
        if(isArray(value)) {
            println(indent + key + ":");
            self printStructure(value, indent + "    ");
        } else {
            // Handle booleans specifically
            if(value == 0 || value == 1) {
                value = (value == 1) ? "true" : "false";
            }
            println(indent + key + ": " + value);
        }
    }
}

