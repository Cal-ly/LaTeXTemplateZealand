%% ----------------------------------------------------------------------
%% Preamble: Setting up the class, packages, and basic configurations
%% ----------------------------------------------------------------------

% Specifies the type of document you are writing and passes options to the base class
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{zbc-report}[2023/06/30 v1.7 ZBC Report Class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass[10pt,oneside]{book}

%% ----------------------------------------------------------------------

% Required packages for the class
\RequirePackage[utf8]{inputenc}

\RequirePackage{array}

% Fundamental packages for mathematics, symbols, and SI units
\RequirePackage{mathtools, amssymb, siunitx}

% Packages for handling keys and class options
\RequirePackage{xkeyval, kvoptions, keyval}

% Table and tabular enhancements
\RequirePackage{tabularx, booktabs, longtable, multirow, multicol}

% Graphics and floating object enhancements
\RequirePackage{graphicx, float}

% Caption customization
\RequirePackage[labelfont=bf, justification=centering, footnotesize]{caption}
\RequirePackage{subcaption}

% Including PDFs and managing hyperlinks
\RequirePackage{pdfpages}
\RequirePackage[pdfusetitle, hidelinks]{hyperref}

% Cross-referencing
\RequirePackage[noabbrev]{cleveref}

% Color support
\RequirePackage{xcolor, colortbl, color}

% Diagrams and drawings
\RequirePackage{tikz}

% Improvements to spacing and text formatting
\RequirePackage{xspace, microtype}

% Page layout customization
\RequirePackage{geometry}

% Customization of section titles and table of contents
\RequirePackage{titlesec, titletoc}

% Headers and footers customization
\RequirePackage{fancyhdr}

% Customization of list environments
\RequirePackage{enumitem}

% Customization of text width in various environments, Included varwidth for flexible box widths
\RequirePackage{varwidth}

% Programming facilities for conditional statements and loops
\RequirePackage{etoolbox, iftex, ifthen}

% Date and time formatting
\RequirePackage{datetime}

% Additional utilities for file handling and conditional checks
\RequirePackage{shellesc, ifplatform, pdftexcmds, xstring, lineno, framed, catchfile}

% Package for enhanced source code listings
\RequirePackage{listings}

%% ----------------------------------------------------------------------
%% Document configuration and custom commands
%% ----------------------------------------------------------------------

% Document geometry setup
\geometry{a4paper, hscale=0.75, vscale=0.8}

% Version definition
\newcommand*{\zbcversion}{1.7}

% Commands for title page customization
\newcommand*{\subtitle}[1]{\def\@subtitle{#1}}
\newcommand*{\subject}[1]{\def\@subject{#1}}
\newcommand*{\affiliation}[1]{\def\@affiliation{#1}}
\newcommand*{\coverimage}[1]{\def\@coverimage{#1}}
\newcommand*{\covertable}[1]{\def\@covertable{#1}}

%% ----------------------------------------------------------------------
%% Font setup for different compilers
%% ----------------------------------------------------------------------

\ifPDFTeX
    \RequirePackage[T1]{fontenc}
    \RequirePackage{newpxtext, newpxmath}
    % Custom title styles using Roboto Slab for pdfLaTeX users
    \newcommand{\titlestyle}{\fontfamily{RobotoSlab-TLF}\fontseries{light}\selectfont}
    \newcommand{\largetitlestyle}{\fontfamily{RobotoSlab-TLF}\fontseries{thin}\selectfont}
\else
    \RequirePackage[no-math]{fontspec}
    % Custom title styles using Roboto Slab for XeLaTeX or LuaLaTeX users
    \setmainfont{Arial}
    \setmathsf{Arial}
    \setmathtt{Arial}
    \newfontfamily\titlestyle{Roboto Slab Light}
    \newfontfamily\largetitlestyle{Roboto Slab Thin}
\fi

%% ----------------------------------------------------------------------
%% Formatting section titles, table of contents, headers, and footers
%% ----------------------------------------------------------------------

% Chapter titles formatting
\titleformat{\chapter}[display]
    {\flushright}
    {\fontsize{50}{50}\selectfont\largetitlestyle\thechapter}
    {0pt}
    {\huge\titlestyle}
\titlespacing*{\chapter}{0pt}{0pt}{2\baselineskip}

% Section and subsection titles formatting
\titleformat{\section}{\Large\titlestyle\bfseries}{\thesection.}{5pt}{}
\titlespacing*{\section}{0pt}{\baselineskip}{0pt}
\titleformat{\subsection}{\large\titlestyle\bfseries}{\thesubsection.}{5pt}{}
\titlespacing*{\subsection}{0pt}{\baselineskip}{0pt}
\titleformat{\subsubsection}{\titlestyle\bfseries}{}{0pt}{}
\titlespacing*{\subsubsection}{0pt}{\bigskipamount}{0pt}

% TOC formatting for chapters
\dottedcontents{chapter}[1.5em]{\vspace{0.5\baselineskip}\bfseries}{1.5em}{0pt}

% Header and footer customization
\fancypagestyle{plain}{%
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[C]{\titlestyle\thepage}}
\pagestyle{fancy}
\if@twoside
    \fancyhf{}
    \fancyhead[LE,RO]{\titlestyle\thepage}
    \fancyhead[RE]{\titlestyle\nouppercase{\leftmark}}
    \fancyhead[LO]{\titlestyle\nouppercase{\rightmark}}
    \RequirePackage{emptypage}
\else
    \fancyhf{}
    \fancyhead[R]{\titlestyle\thepage}
    \fancyhead[L]{\titlestyle\nouppercase{\rightmark}}
\fi

%% ----------------------------------------------------------------------
%% Cover page setup with TikZ
%% ----------------------------------------------------------------------

\newcommand*{\makecover}{
    \usetikzlibrary{positioning}
    \thispagestyle{empty}
    \begin{tikzpicture}[overlay,remember picture]
        % Cover image
        \node[above=0,inner sep=0] at (current page.south) {\includegraphics[width=\paperwidth]{\@coverimage}};
        % Affiliation and logo
        \node[rotate=90,below right=40mm and 3mm] at (current page.west) {\ifdefvoid{\@affiliation}{}{\color{white}\titlestyle\@affiliation}};
        \node[above right=10mm] at (current page.south west) {\includegraphics[width=0.35\linewidth]{figures/template-figures/zealandcombinedlogowhite.png}};
        % Title banner
        \node[below=2cm,fill=black!85,minimum width={\paperwidth},inner ysep=25pt,opacity=0.6,text opacity=1] at (current page.north) {
            \begin{minipage}{0.9\paperwidth}
                \color{title}\raggedright\largetitlestyle\fontsize{50}{50}\selectfont \@title \\[0.5ex]
                \color{white}\titlestyle\fontsize{22}{22}\selectfont \ifdefvoid{\@subtitle}{}{\@subtitle \\[2.5ex]} \ifdefvoid{\@subject}{}{\@subject \\[0.5ex]}
                \largetitlestyle\fontsize{24}{24}\selectfont \ifdefvoid{\@covertable}{\@author}{\@covertable}
            \end{minipage}};
    \end{tikzpicture}
    \newpage
}

%% ----------------------------------------------------------------------
%% Configuration for listings and minted (code highlighting)
%% ----------------------------------------------------------------------

% listings package configuration
\lstset{
  basicstyle=\ttfamily\footnotesize,
  backgroundcolor=\color{gray!10},
  keywordstyle=\color{red!75!black},
  stringstyle=\color{green!40!black},
  commentstyle=\color{blue!30!black},
  numbers=left,
  numbersep=5pt,
  numberstyle=\tiny,
  breaklines=true,
}

%% ----------------------------------------------------------------------
%% Figure and table captions customization
%% ----------------------------------------------------------------------

\newcommand*{\figuretitle}[1]{%
    {\centering%   <--------  will only affect the title because of the grouping (by the
    \textbf{#1}%              braces before \centering and behind \medskip). If you remove
    \par\medskip}%            these braces the whole body of a {figure} env will be centered.
}