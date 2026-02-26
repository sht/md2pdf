# Markdown to PDF Converter Guide

## Usage

```bash
./md2pdf.sh input.md                  # Output: input.pdf
./md2pdf.sh input.md custom_name.pdf  # Output: custom_name.pdf
```

## Special Formatting Syntax

### Center-Aligned Title

Use raw LaTeX to center a title:

```markdown
\begin{center}
\LARGE\textbf{YOUR TITLE HERE}
\end{center}
```

**Note:** Don't use `#` heading inside `\begin{center}` - use `\LARGE\textbf{}` instead.

### Page Break

Insert a page break anywhere in your document:

```markdown
\newpage
```

Or:

```markdown
\pagebreak
```

## Supported Markdown Features

| Feature | Syntax | Example |
|---------|--------|---------|
| Heading 1 | `# Title` | `# Main Title` |
| Heading 2 | `## Title` | `## Section` |
| Heading 3 | `### Title` | `### Subsection` |
| Bold | `**text**` | `**important**` |
| Italic | `*text*` | `*emphasis*` |
| Bullet list | `- item` | `- First item` |
| Numbered list | `1. item` | `1. Step one` |
| Table | `\| Col1 \| Col2 \|` | See below |
| Horizontal rule | `---` | `---` |

### Table Example

```markdown
| Field | Value |
|:------|:------|
| Name | John Doe |
| Email | john@example.com |
```

## PDF Settings

- **Font:** Inter
- **Margins:** 1 inch
- **Tables:** Left-aligned
- **Table row height:** 1.3x
- **Paragraph spacing:** 1em
- **Bullet/List spacing:** 0.2em

## Requirements

- Pandoc
- XeLaTeX (MacTeX or TeX Live)
- Inter font (installed via `brew install --cask font-inter`)
