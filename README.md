# Iframe Extension For Quarto

This Quarto extension provides a shortcode to embed iframes in your HTML output.

It has optional and customizable PDF fallback text.

It is hopefully useful for embedding interactive content, exercises, or external web pages into your Quarto documents.

The example provided uses a downloaded maths question from [Numbas](https://numbas.mathcentre.ac.uk) which is then saved locally and pointed to by the iframe. The contents can be found in the `/numbas/` folder.

## Installing

```bash
quarto add david-hodge/iframe
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Using

`{{< iframe path="..." >}}` is how you use it.

**Note**: when testing you will need to use `quarto preview` and not `quarto render` if you want your browser to via the iframe, as browsers will not render an iframe locally (i.e. not from a webserver).

Here's a full example, though only the `path` parameter is required.

```
{{< iframe path="question.html" 
  width="600px" 
  height="400px" 
  class="NQ" 
  url="https://example.com" 
  urltext="Go to quiz" 
  pdftext="The HTML version contains a question here." >}}
```

However, the `pdftext` is only used if no `url` is provided. Otherwise the PDF version provides a hyperlink.

### Parameters

| Parameter  | Default | Description |
|------------|---------|-------------|
| `class`    | `"NQ"`  | CSS class applied to the outer `<div>` (historical reasons) |
| `path`     | *none*  | Mandatory. The source of the iframe (can be a local file) |
| `width`    | `"600px"` | Width of the iframe |
| `height`   | `"400px"` | Height of the iframe |
| `url`      | `""`     | Optional URL to use in PDF output |
| `urltext`  | `"Link to question"` | Text for hyperlink when `url` is provided |
| `pdftext`  | `"A question appears here in the HTML version."` | Text displayed in PDF if no `url` is provided |

## Example

Here is the source code for more examples: [example.qmd](example.qmd).

