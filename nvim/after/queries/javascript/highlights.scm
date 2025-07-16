;; ========== JavaScript Declarations ==========
(function_declaration name: (identifier) @function)
(method_definition name: (property_identifier) @method)
(arrow_function) @function
(class_declaration name: (identifier) @type)

(variable_declarator name: (identifier) @variable)

;; ========== Parameters ==========
(formal_parameters (identifier) @parameter)
(required_parameter name: (identifier) @parameter)
(optional_parameter name: (identifier) @parameter)
(rest_parameter name: (identifier) @parameter)

;; ========== Literals ==========
(string) @string
(template_string) @string
(number) @number
(true) @boolean
(false) @boolean
(null) @constant.builtin
(undefined) @constant.builtin

;; ========== Keywords ==========
(keyword) @keyword
(import_statement source: (string) @string)
(import_clause (identifier) @namespace)
(this) @variable.builtin

;; ========== Operators & Punctuation ==========
(assignment_expression operator: "=") @operator
(binary_expression operator: _) @operator
(unary_expression operator: _) @operator
(update_expression operator: _) @operator
(ternary_expression ["?" ":"] @operator)

(punctuation.separator) @punctuation.delimiter
(punctuation.bracket) @punctuation.bracket

;; ========== Comments ==========
(comment) @comment

;; ========== Misc ==========
(identifier) @variable
(property_identifier) @property

