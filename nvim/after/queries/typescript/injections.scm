;; Inject HTML into html`<div>...</div>`
(tagged_template
  tag: (identifier) @_tag
  (template_string) @injection.content
  (#eq? @_tag "html")
  (#set! injection.language "html"))

;; Inject CSS into css`...`
(tagged_template
  tag: (identifier) @_tag
  (template_string) @injection.content
  (#eq? @_tag "css")
  (#set! injection.language "css"))

;; Inject SQL into sql`...`
(tagged_template
  tag: (identifier) @_tag
  (template_string) @injection.content
  (#eq? @_tag "sql")
  (#set! injection.language "sql"))

;; Inject Markdown into md`...`
(tagged_template
  tag: (identifier) @_tag
  (template_string) @injection.content
  (#eq? @_tag "md")
  (#set! injection.language "markdown"))
