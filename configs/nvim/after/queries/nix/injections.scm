; extends

(binding
  attrpath: (attrpath
    (identifier) @_path)
  expression: [
    (string_expression
      ((string_fragment) @injection.content
        (#set! injection.language "bash")))
    (indented_string_expression
      ((string_fragment) @injection.content
        (#set! injection.language "bash")))
  ]
  (#any-of? @_path "shellHook" "activationScript")
  (#set! injection.combined))

(binding
  attrpath: (attrpath) @_path
  expression: [
    (string_expression
      ((string_fragment) @injection.content
        (#set! injection.language "bash")))
    (indented_string_expression
      ((string_fragment) @injection.content
        (#set! injection.language "bash")))
  ]
  (#match? @_path "activation")
  (#set! injection.combined))

(binding
  attrpath: (attrpath
    (identifier) @_path)
  expression: [
    (string_expression
      ((string_fragment) @injection.content
        (#set! injection.language "zsh")))
    (indented_string_expression
      ((string_fragment) @injection.content
        (#set! injection.language "zsh")))
  ]
  (#eq? @_path "initContent")
  (#set! injection.combined))

(binding
  attrpath: (attrpath
    (identifier) @_path)
  expression: [
    (string_expression
      ((string_fragment) @injection.content
        (#set! injection.language "bash")))
    (indented_string_expression
      ((string_fragment) @injection.content
        (#set! injection.language "bash")))
  ]
  (#eq? @_path "initExtra")
  (#set! injection.combined))

((apply_expression
  function: (apply_expression
    function: (_) @_func)
  argument: (indented_string_expression
    (string_fragment) @injection.content
    (#set! injection.language "zsh")))
  (#lua-match? @_func "optionalString$")
  (#set! injection.combined))
