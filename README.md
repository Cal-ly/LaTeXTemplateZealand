# LaTeX Report Template
This is a LaTeX template designed to be used by faculty and students on Zealand Business College.
This repository contains a LaTeX class and associated files for creating reports and theses. 

## Installation

Clone the repository to your local machine:
```bash
git clone https://github.com/yourusername/latex-report-template.git
```

## Usage

To create a new document, use the `zbc-report.cls` class. Examples is provided throughout like:

```latex
\chapter{2nd Chapter}
\label{chapter:2ndchapter}

This is the second chapter.

\section{SCRUM}
I think that \emph{SCRUM} is .. this is a reference \cref{fig:appendix-domain-model-diagram}.

\subsubsection{This is a subsubsection}
This is a subsubsection text, this is a cite \cite{connolly2023database}.
```
or just start filling out the blanks in the document

### Appsettings.json

Compile the document with `pdflatex` or your preferred LaTeX editor. A change to appsetting.json is included for VS Code in order to run

```json
{
    "python.terminal.activateEnvInCurrentTerminal": true,
    "latex-workshop.latex.autoBuild.run": "never",
    "latex-workshop.latex.autoClean.run": "onSucceeded",
    "latex-workshop.intellisense.citation.backend": "biblatex",
    "latex-workshop.intellisense.package.enabled": true,
    "latex-workshop.intellisense.subsuperscript.enabled": false,
    // Sync PDF with cursor position after compiling.
    "latex-workshop.synctex.afterBuild.enabled": true,
    // Automatically choose last used recipe on next build.
    "latex-workshop.latex.recipe.default": "lastUsed",
    "latex-workshop.latex.tools": [
        {
            "name": "pdflatex",
            "command": "pdflatex",
            "args": [
                "-shell-escape",
                "-synctex=1",
                "-interaction=nonstopmode",
                "-file-line-error",
                "%DOC%"
            ]
        },
        {
            "name": "biber",
            "command": "biber",
            "args": [
                "%DOCFILE%"
            ]
        },
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "pdflatex -> biber -> pdflatex * 2",
            "tools": [
                "pdflatex",
                "biber",
                "pdflatex",
                "pdflatex"
            ]
        }
    ]
}
```

### Minted

In order to use minted, which is used to present sourcecode directly from files, you need to install Pygmented. The changes to the appsettings.json incorporates the -shell-escape in order to run unhindered.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue to discuss changes.

## License

This template is licensed under the MIT License - see the LICENSE file for details.
