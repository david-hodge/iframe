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

## New Youtube feature

YouTube videos embedded into Quarto via the usual `video` shortcode seem to suffer from the issue of pre-loading all the Google analytics, cookies and generally slowing down page loads.

Utilising the lite-youtube-embed code from here [https://github.com/justinribeiro/lite-youtube](https://github.com/justinribeiro/lite-youtube) this iframe extension also allows a lightweight way to embed YouTube videos without cookies etc..

You need to load the lite-yt-embed.js and lite-yt-embed.css from the repo above (see this repo's readme), for example in your `_quarto.yml`.

```
format:
  html:
    include-in-header:
          - text: |
              <script src="https://cdn.jsdelivr.net/npm/lite-youtube-embed@0.3.0/src/lite-yt-embed.js"></script>
              <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lite-youtube-embed@0.3.0/src/lite-yt-embed.css" />
```
Then in your Quarto Markdown file you just type:
```
{{< iframe youtube-light="GPsFwdZoDKo" >}}
```
where GPsFwsZ... is your YouTube video ID.

In the PDF a link will be printed to say "YouTube video link" with a hyperlink to the video.

The example.qmd doesn't demonstrate it live, so as not to forcibly load external js files against your wishes.
