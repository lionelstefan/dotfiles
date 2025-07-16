;; ========== Declarations ==========
(function_declaration name: (identifier) @function)
(method_definition name: (property_identifier) @method)
(arrow_function) @function
(class_declaration name: (identifier) @type)
(interface_declaration name: (type_identifier) @type)
(type_alias_declaration name: (type_identifier) @type)
(enum_declaration name: (identifier) @type)

(variable_declarator name: (identifier) @variable)

;; ========== Parameters ==========
(formal_parameters (identifier) @parameter)
(required_parameter name: (identifier) @parameter)
(optional_parameter name: (identifier) @parameter)
(rest_parameter name: (identifier) @parameter)
(type_parameter name: (type_identifier) @type)

;; ========== Type Keywords ==========
(type_annotation) @type
(predefined_type) @type.builtin
(type_identifier) @type
(type_arguments) @type
(type_parameters) @type
(as_expression) @keyword
(non_null_expression) @operator

;; ========== Keywords ==========
("function" @keyword)
("class" @keyword)
("interface" @keyword)
("return" @keyword)
("const" @keyword)
("let" @keyword)
("var" @keyword)
("if" @keyword)
("else" @keyword)
("switch" @keyword)
("case" @keyword)
("for" @keyword)
("while" @keyword)
("break" @keyword)
("continue" @keyword)
("throw" @keyword)
("try" @keyword)
("catch" @keyword)
("finally" @keyword)
("import" @keyword)
("export" @keyword)
("from" @keyword)
("extends" @keyword)
("implements" @keyword)
("as" @keyword)

;; ========== Literals ==========
(string) @string
(template_string) @string
(number) @number
(boolean) @boolean
(undefined) @constant.builtin
(null) @constant.builtin

;; ========== Operators & Punctuation ==========
"=" @operator
"==" @operator
"===" @operator
"!=" @operator
"!==" @operator
"+" @operator
"-" @operator
"*" @operator
"/" @operator
"%" @operator
"**" @operator
"&&" @operator
"||" @operator
"!" @operator
"<" @operator
">" @operator
"<=" @operator
">=" @operator
"?" @operator
":" @punctuation.delimiter
"." @punctuation.delimiter
"," @punctuation.delimiter
";" @punctuation.delimiter
"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

;; ========== Comments ==========
(comment) @comment

;; ========== Misc ==========
(this) @variable.builtin
(identifier) @variable
(property_identifier) @property
(import_clause (identifier) @namespace)
