-- Helper function for arguments with defaults
local function get_arg(kwargs, key, default)
  local val = pandoc.utils.stringify(kwargs[key] or "")
  if val == "" then val = default end
  return val
end

-- iframe shortcode Lua filter for Quarto
return {
  ["iframe"] = function(args, kwargs)
    local path      = get_arg(kwargs, "path", "")
    local width     = get_arg(kwargs, "width", "600px")
    local height    = get_arg(kwargs, "height", "400px")
    local url       = get_arg(kwargs, "url", "")
    local url_text  = get_arg(kwargs, "urltext", "Link to question")
    local plain_text  = get_arg(kwargs, "pdftext", "A question appears here in the HTML version.")
    local div_class = get_arg(kwargs, "class", "NQ")

    if path == "" then
      -- Check path has been passed (non-empty)
      io.stderr:write("\27[31m⚠️ Warning: 'path' parameter for iframe shortcode is empty.\27[0m\n")
      return pandoc.Para({pandoc.Str("⚠️ Warning: 'path' parameter for iframe shortcode is empty.")})
    end

    -- prepare raw content for HTML
    local raw = {}
    raw.html = string.format([[
<div class="%s">
<iframe src="%s" width="%s" height="%s" sandbox="allow-same-origin allow-scripts allow-forms">
<p>Your browser does not support iframes.</p>
</iframe>
</div>]], div_class, path, width, height)

    -- prepare shared text for LaTeX and fallback
    if url ~= "" then
      raw.latex = string.format("\\href{%s}{%s}", url, url_text)
      raw.string = string.format("[%s](%s)", url_text, url)
    else
      raw.latex = plain_text
      raw.string = plain_text
    end

    -- return based on Quarto output format
    if quarto.doc.isFormat("html") then
      return pandoc.RawBlock("html", raw.html)
    elseif quarto.doc.isFormat("pdf") then
      return pandoc.RawBlock("tex", raw.latex)
    else
      -- fallback for other formats (Markdown, Word, etc.)
      return pandoc.Para({pandoc.Str(raw.string)})
    end
  end
}
