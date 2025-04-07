# Imperial Thesis Template - Typst

This is a Typst template for an Imperial Bachelor/Master's Dissertation/Thesis.

The base template was adapted from [TUM's thesis template](https://github.com/ls1intum/thesis-template-typst). The goal template is the LaTeX template that Imperial has released on [Overleaf](https://www.overleaf.com/latex/templates/meng-beng-msc-report-template-eee-imperial-college-london-v1-dot-2-0/qtkpngktpwpw).

(I don't plan on particularly maintaining this, but will happily merge PRs or let someone else maintain this)

>[!NOTE]
> The `main` branch contains the default template based completely on the EEE department's template\
> The `doc_format` branch contains an adapted template that I've modified for my usage in the Computing department

## How to Use

>[!TIP]
>This is only a template. You have to adapt the template to your thesis and discuss the structure of your thesis with your supervisor!

### 1. Set Metadata

Fill in your thesis details in the [`metadata.typ`](/metadata.typ) file: 
- `university`, e.g. `"Imperial College London"`
- `department`, e.g. `"Department of Computing"`
- `logo_file` - path to university logo image, e.g. `"/figures/icl_logo.png"`
- `location` - where are you based for this, e.g. `"Lapland"`
- `program` - or **course**, e.g. `"Electronic and Information Engineering"`
- `degree_type`, e.g. `"Master of Engineering"`, `"Bachelor of Science"`
- `report_level`, e.g. `"Interim"`, `"Final"`
- `supervisors` - add names to this array, e.g. `("Dr Marios Kogias", "Prof. A. Nother",)`
- `advisors` - add names to this array, e.g. `("Karl der Krümelmonster (MSc)",)`
- `author` - your name, e.g. `"E.A. Sports"`
- `student_id`, e.g. `"02020202"` (CIDs for Imperial students)
- `paper_title`, e.g. `"Attention is All you Need"`
- `subtitle`, e.g. `"And maybe some sleep"`
- `submissionDate`, e.g. `datetime(day: 23, month: 1, year: 2025)`

These datetimes don't need to be set lest you plan to add them to the document:
- `startDate`, e.g. `datetime(day: 1, month: 10, year: 2024)`
- `presentationDate`, e.g. `datetime(day: 24, month: 1, year: 2025)`
- `feedbacklogSubmissionDate`, e.g. `datetime(day: 1, month: 1, year: 2024)`

These values will be used to fill in various bits of data within the template, mostly within the [titlepage](/layout/titlepage.typ).

### 2. Write your thesis

Most of the formatting is handled within the [`layout/`](/layout/) files, so your written content can just look like regular content.

Your written content goes in the files in the [`content/`](/content/) sections:

- [`content/preamble/`](/content/preamble/) contains the contents of the preamble, e.g. abstract, disclaimers, etc.
- [`content/sections/`](/content/sections/) contains the main content sections, e.g. Introduction, Background, etc.
- [`content/appendices/`](/content/appendices/) contains any appendices you want to add
- [`content/conclusions`](/content/conclusions.typ) is a file for the conclusions section (sth. that Imperial added after the rest of the sections)

To ensure that things are correctly imported and displayed, there are a few things in [`thesis.typ`](/thesis.typ), you'll need to update:
- `sections` and `appendices` variables to include/exclude new or modified files
- `disclaimers` variable to import and order the disclaimer sections for your thesis
- `figure_list` and `table_list` boolean variables passed into `#thesis(...)`
  - they just define whether or not these will be displayed (default: true)
- at the top, there are multiple includes/imports to get preamble section contents, e.g. `abstract`, `conclusions`, etc.
- [`acronyms`](/content/preamble/acronyms.typ) is a file containing a variable containing 2-tuples with acronyms to be used in the text

If there are things you wish to change in the base layout or otherwise, please feel free to edit the [`thesis_template`](/layout/thesis_template.typ) directly.

>[!IMPORTANT]
> In order to maintain the `minitoc` at the start of each content section, please remember to include the `#minitoc()` command after the primary heading, e.g. `= Introduction`

#### Editing the Template

Though one _should_ be able to get by without needing to touch the [`layout/`](/layout/) folder at all, lest you do, these are the most important files:

- [`titlepage`](/layout/titlepage.typ) - styling for the title page...
- [`basic_formatting`](/layout/basic_formatting.typ) - handles the more basic sections, like the preamble and conclusions section
  - sets the page numbering header style
  - styles the headings, particularly the level 1 headings
  - sets the text styling
- [`content_formatting`](/layout/content_formatting.typ) - style the main content sections, like [`sections/`](/content/sections/) and [`appendices/`](/content/appendices/)
  - styles the headings, particularly Imperial's imposing level 1 headings
  - sets the page numbering header style
  - computes and places the chapter numbering thumb labels
  - sets the text styling
- [`thesis_template`](/layout/thesis_template.typ) - defines the main layout for the thesis, and handles applying the styles to the various sections
  - breaks all sections that require different primary styles into separate scopes
    - and sets configurations for the basic/content formatting layout rules
  - defines the order that sections and section content is laid out
  - resets counters and counter styling for page and heading numbering
- [`disclaimers`](/layout/disclaimers.typ) - defines the overall of the disclaimers section
  - feel free to change this, the current layout is just my preference


#### Utilities

You shouldn't need to worry about these too much, but in case you wish to use them:

- [`print_pagebreak`](/utils/print_pagebreak.typ) - previously written function to automatically reconfigure pagebreaks for print and non-print settings
  - Imperial prefers the `is_print == true` setting, with chapters and things starting on the left page of a double-page spread
- [`minitoc`](/utils/minitoc.typ) - I wrote my own implementation of the [`minitoc`](https://typst.app/universe/package/minitoc/) function since it wasn't working for me
- [`titlepage_spacer`](/utils/titlepage_spacer.typ) - a small convenience function to compute the spacing of the titles, names, and bottom section on the titlepage
- [`todo`](/utils/todo.typ) - previously written function to print prominent todo blocks for things yet to be written

### 3. Compile PDFs (local)

#### VSCode

I, personally, use the VSCode extension. Please refer to [this section](#working-with-vs-code) if you'd prefer this.

To compile, the `Run Code` button can be used, while the main file [`thesis.typ`](/thesis.typ) is open. Or, you can follow the [CLI instructions](#cli).

This has the added benefit of syntax highlighting and a preview that recompiles on changes.

#### Typst Web Editor

This is also a great option, and the compilation is as easy as pressing a little button in the top corner, too.

See [here](#working-with-the-typst-web-editor) for instructions on setting this up.

#### CLI

<!-- Slightly modify this section from original TUM README -->

Once you have [installed Typst](https://github.com/typst/typst), you can use it like this:
```sh
# Creates `thesis.pdf` in working directory.
typst compile thesis.typ

# Creates PDF file at the desired path.
typst compile thesis.typ path/to/output.pdf
```

You can also watch source files and automatically recompile on changes. This is
faster than compiling from scratch each time because Typst has incremental
compilation.
```sh
# Watches source files and recompiles on changes.
typst watch thesis.typ
```

## Typst

My assumption is that if you're here, it's because you already prefer Typst to LaTeX, so probably don't need this, but just in case:

For detailed installation instructions, please refer to the [official installation guide](https://github.com/typst/typst).

<!-- Keep these sections from original TUM README -->

### Working with the Typst Web Editor

If you prefer an integrated IDE-like experience with autocompletion and instant preview, the Typst web editor allows you to import files directly into a new or existing document. Here's how you can do this:

1. Navigate to the [Typst Web Editor](https://typst.app/).
2. Create a new blank document.
3. Click on "File" on the top left menu, then "Upload File".
4. Select all .typ and .bib files along with the figures provided in this template repository.

**Note:** You can select multiple files to import. The editor will import and arrange all the files accordingly. Always ensure you have all the necessary .typ, .bib, and figures files you need for your document.

### Working with VS Code

If you prefer to have a more integrated experience with your favorite code editor, you can use the Typst VS Code extension. The extension provides syntax highlighting, autocompletion, and error checking for Typst files. You can install the extension from the [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=nvarner.typst-lsp).

1. Open your project in VS Code
2. Set the correct file (`thesis.typ` or `proposal.typ`) as the main file. This can be done by opening the respective file and running the command `Typst: Pin the main file to the currently opened document`. Just hit `CMD + Shift + P` and search for the command.

## Further Resources

- [Typst Documentation](https://typst.app/docs/)
- [Typst Guide for LaTeX Users](https://typst.app/docs/guides/guide-for-latex-users/)
- [Typst VS Code Extension (inofficial)](https://marketplace.visualstudio.com/items?itemName=nvarner.typst-lsp)
