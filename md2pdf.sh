#!/bin/bash
#
# Markdown to PDF Converter
# Uses Pandoc with XeLaTeX and Inter font
#

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Check if input file provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: No input file specified${NC}"
    echo ""
    echo "Usage: ./md2pdf.sh input.md [output.pdf]"
    echo ""
    echo "Examples:"
    echo "  ./md2pdf.sh document.md"
    echo "  ./md2pdf.sh document.md custom_name.pdf"
    exit 1
fi

INPUT_FILE="$1"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo -e "${RED}Error: File '$INPUT_FILE' not found${NC}"
    exit 1
fi

# Determine output filename
if [ -z "$2" ]; then
    OUTPUT_FILE="${INPUT_FILE%.md}.pdf"
else
    OUTPUT_FILE="$2"
fi

# Current date for the footer (e.g. "9 August 2026")
FOOTER_DATE=$(date '+%e %B %Y' | sed 's/^ *//')

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create LaTeX header (inline to keep everything in one script)
HEADER_FILE=$(mktemp)
cat > "$HEADER_FILE" << 'EOF'
% Load longtable package for table formatting
\usepackage{longtable}

% Left-align tables
\setlength{\LTleft}{0pt}
\setlength{\LTright}{\fill}

% Increase table row height/padding
\usepackage{array}
\renewcommand{\arraystretch}{1.3}


% Reduce space after headings (last value = gap BEFORE following text)
\usepackage{titlesec}
\titlespacing*{\section}{0pt}{12pt}{10pt}
\titlespacing*{\subsection}{0pt}{8pt}{8pt}
\titlespacing*{\subsubsection}{0pt}{6pt}{6pt}

% Make headings bold
\titleformat{\section}{\normalfont\Large\bfseries}{\thesection}{1em}{}
\titleformat{\subsection}{\normalfont\large\bfseries}{\thesubsection}{1em}{}

% Reduce space before longtable (tables)
\setlength{\LTpre}{4pt}
\setlength{\LTpost}{8pt}

% Disable tightlist (pandoc compresses lists by default)
\def\tightlist{}

% Spacing for bullet points and numbered lists
\usepackage{enumitem}
\setlist[itemize]{itemsep=0.2em, parsep=0.1em, topsep=-0.5em}
\setlist[enumerate]{itemsep=0.2em, parsep=0.1em, topsep=-0.5em}

% Paragraph spacing
\setlength{\parskip}{1em}

% --- Blockquote styling (pandoc uses the "quote" environment) ---
% Render Markdown blockquotes as a subtle gray callout box instead of an
% indented block, so "Note:" lines read cleanly.
\usepackage{xcolor}
\usepackage{framed}
\definecolor{quotebar}{gray}{0.75}
\definecolor{quotebg}{gray}{0.96}
\renewenvironment{quote}{%
  \def\FrameCommand{{\color{quotebar}\vrule width 3pt}\hspace{8pt}}%
  \MakeFramed{\advance\hsize-\width \FrameRestore}%
  \color{black!80}%
}{\endMakeFramed}

% --- Footer: faded gray date in the bottom-right corner ---
\usepackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}
\fancyfoot[R]{\footnotesize\textcolor{gray!60}{FOOTER_DATE_PLACEHOLDER}}
% Apply the same footer to the first page (article uses "plain" there)
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand{\headrulewidth}{0pt}%
  \fancyfoot[R]{\footnotesize\textcolor{gray!60}{FOOTER_DATE_PLACEHOLDER}}%
}
EOF

# Inject the current date into the footer placeholder
sed -i '' "s/FOOTER_DATE_PLACEHOLDER/${FOOTER_DATE}/" "$HEADER_FILE"

# Run pandoc
echo "Converting $INPUT_FILE to $OUTPUT_FILE..."

pandoc "$INPUT_FILE" \
    -o "$OUTPUT_FILE" \
    -H "$HEADER_FILE" \
    -V geometry:margin=1in \
    --pdf-engine=xelatex \
    -V mainfont:"Inter" \
    -L "$SCRIPT_DIR/bold-headers.lua" \
    2>&1

# Check if conversion was successful
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ PDF created successfully: $OUTPUT_FILE${NC}"
    # Cleanup temp file
    rm -f "$HEADER_FILE"
    exit 0
else
    echo -e "${RED}✗ Error creating PDF${NC}"
    rm -f "$HEADER_FILE"
    exit 1
fi
