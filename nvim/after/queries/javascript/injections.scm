;; Inject HTML from html`...`
(tagged_template
  tag: (identifier) @_tag
  (template_string) @injection.content
  (#eq? @_tag "html")
  (#set! injection.language "html"))

;; CSS-in-JS
(tagged_template
  tag: (identifier) @_tag
  (template_string) @injection.content
  (#eq? @_tag "css")
  (#set! injection.language "css"))

;; GraphQL queries
(tagged_template
  tag: (identifier) @_tag
  (template_string) @injection.content
  (#eq? @_tag "gql")
  (#set! injection.language "graphql"))

;; Markdown strings
(tagged_template
  tag: (identifier) @_tag
  (template_string) @injection.content
  (#eq? @_tag "md")
  (#set! injection.language "markdown"))

