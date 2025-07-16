; Inject HTML inside <template> blocks
(element
  name: (tag_name) @_tag
  (#eq? @_tag "template")
  (raw_text) @injection.content
  (#set! injection.language "html"))
