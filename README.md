# md2pdf

A simple shell script to convert Markdown files to professional-looking PDFs using Pandoc and XeLaTeX.

**Features:**
- Left-aligned tables (not centered like default Pandoc)
- Inter font (modern, highly readable)
- Optimized spacing for headings, paragraphs, lists, and tables
- Support for centered titles and page breaks
- Single command conversion

## Quick Start

```bash
# Clone the repo
git clone https://github.com/YOUR_USERNAME/md2pdf.git
cd md2pdf

# Make executable
chmod +x md2pdf.sh

# Convert your markdown
./md2pdf.sh document.md
```

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

## Installation (macOS)

### 1. Install Homebrew (if not installed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Pandoc
```bash
brew install pandoc
```

### 3. Install MacTeX (LaTeX distribution with XeLaTeX)
```bash
brew install --cask mactex
```

After installation, restart your terminal or run:
```bash
eval "$(/usr/libexec/path_helper)"
```

### 4. Install Inter Font
```bash
brew install --cask font-inter
```

### 5. Verify Installation
```bash
pandoc --version
xelatex --version
fc-list | grep -i inter
```

## Requirements Summary

| Dependency | Install Command | Purpose |
|------------|-----------------|---------|
| Pandoc | `brew install pandoc` | Markdown converter |
| MacTeX | `brew install --cask mactex` | PDF generation (XeLaTeX) |
| Inter Font | `brew install --cask font-inter` | Document font |

## Why This Exists

Pandoc's default PDF output has some issues:
- Tables are centered (looks unprofessional for documents)
- Tight list spacing (hard to read)
- Default fonts aren't great

This script fixes all of that with carefully tuned LaTeX settings.

## License

MIT

## Contributing

PRs welcome! If you have improvements to spacing, font choices, or additional features, feel free to contribute.
