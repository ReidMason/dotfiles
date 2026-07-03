; extends

(raw_string_literal
  (raw_string_literal_content) @injection.content
  (#lua-match? @injection.content "^\s*\{")
  (#set! injection.language "json"))

(raw_string_literal
  (raw_string_literal_content) @injection.content
  (#lua-match? @injection.content "^%s*# @genqlient")
  (#set! injection.language "graphql"))

(raw_string_literal
  (raw_string_literal_content) @injection.content
  (#lua-match? @injection.content "^%s*query ")
  (#set! injection.language "graphql"))

(raw_string_literal
  (raw_string_literal_content) @injection.content
  (#lua-match? @injection.content "^%s*mutation ")
  (#set! injection.language "graphql"))

(raw_string_literal
  (raw_string_literal_content) @injection.content
  (#lua-match? @injection.content "^%s*subscription ")
  (#set! injection.language "graphql"))

(raw_string_literal
  (raw_string_literal_content) @injection.content
  (#lua-match? @injection.content "^%s*fragment ")
  (#set! injection.language "graphql"))
