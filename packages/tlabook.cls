% Copyright (c) 2024-2025, Laszlo Attila Toth
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tlabook}[2025/12/05 TlaBook class]

% Load the base class with fixed options
\LoadClass[a4paper,10pt,twoside,openright]{book}

% Prevent options from being passed to this class
\DeclareOption*{%
  \ClassError{mybook}{Unknown option `\CurrentOption'}%
    {This class does not accept options.}%
}

% Process options (none are allowed, so this just enforces the error above)
\ProcessOptions\relax


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%             PACKAGES
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{color}
\RequirePackage{calc}
\RequirePackage{fontspec} % LuaLaTeX
\RequirePackage{fancyhdr}
\RequirePackage[top=2cm,bottom=2.5cm]{geometry}
\RequirePackage{marginnote}
\RequirePackage[all]{nowidow}
\RequirePackage{tikz}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{hyperref}
\RequirePackage{varioref}
\RequirePackage{cleveref} % last


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%             COLOR DEFINITIONS and HYPERLINK COLOR SETUP
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\definecolor{darkblue}{rgb}{0, 0, 0.4}
\definecolor{ChapNoColor}{cmyk}{0.17,0.12,0.12,0}
\definecolor{ChapTitleColor}{rgb}{.2,.2,.8}
\definecolor{HighlightTitleColor}{RGB}{71, 107, 133}
\definecolor{HighlightBodyColor}{cmyk}{0.57,0.48,0.48,0.15} % Highlight Env. Color


\hypersetup{
  colorlinks = true,
  linkcolor=darkblue,
  urlcolor=blue,
  citecolor=blue
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%             GEOMETRY / LAYOUT
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\setlength{\headheight}{15pt}

%% Place 'This page intentionally left blank' to empty pages
\makeatletter
\def\cleardoublepage{%
  \clearpage
  \if@twoside
    \ifodd\c@page
    \else
      \null
      \thispagestyle{empty}
      \vfill
      \begin{center}
        \textit{This page intentionally left blank}
      \end{center}
      \vfill
      \newpage
    \fi
  \fi
}
\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%             FONTS and PARAGRAPHS
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\setmainfont{EB Garamond}

% Placeholders, don't want to change it here
\newcommand{\ChapterMarkFont}{}
\newcommand{\HighlightTitleFont}{}
\newcommand{\HighlightBodyFont}{}

\newcommand{\BigPartLetterFont}{}

\renewcommand\marginfont{\strut\color{darkblue}\sffamily\it}

\newcommand{\BigPartLetter}[1]{
  {\BigPartLetterFont\fontsize{35}{36}\selectfont\color{ChapTitleColor}#1}
}


% Increase the vertical space between the paragraphs
\setlength{\parskip}{5pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%             TITLE PAGE
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\makeatletter
%% \subtitle and \email for title page
\def\@subtitle{\@latex@warning@no@line{No \noexpand\subtitle given}}
\def\@email{\@latex@warning@no@line{No \noexpand\email given}}
\DeclareRobustCommand*\subtitle[1]{\gdef\@subtitle{#1}}
\DeclareRobustCommand*\email[1]{\gdef\@email{#1}}

%% and the title page (\maketitle)
\renewcommand{\maketitle}{%
  \begin{titlepage}
    \raggedleft
    \hspace{.025\textwidth}
    \parbox[b]{\textwidth}{
    \vspace{1.5cm}
    {\Huge\bfseries\@title} \\
    [20pt] {\Large\textit\@subtitle}}
    \vfill
    \rule{1pt}{.14\textheight}
    \hspace{.025\textwidth}
    \raisebox{10pt}{\parbox[b]{.95\textwidth}{%
    {\Large\textsc{\@author} \\%
    [10pt] \@email} \\
    [25pt] {\Large\@date}}

    \global\let\@subtitle\@empty
    \global\let\subtitle\relax
    \global\let\@email\@empty
    \global\let\email\relax
    }
  \end{titlepage}
}
\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%             HEADERS and FOOTERS (PAGE STYLES)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Redefine chapter and section marks
\renewcommand{\chaptermark}[1]{%
  \markboth{#1}{}% only chapter title in leftmark
}
\renewcommand{\sectionmark}[1]{%
  \markright{\thesection\ \ \ #1}%
}
\fancypagestyle{twoside}{%
  \fancyhf{}%
  \fancyhead[CE]{{\textcolor{black}{\nouppercase{\textbf \leftmark}}}}%
  \fancyhead[CO]{{\textcolor{black}{\nouppercase{\textbf \rightmark}}}}%
  \fancyhead[RE]{\thepage}
  \fancyhead[LO]{\thepage}
}

\fancypagestyle{TBMainPageStyle}{
  \fancyhf{}%
  \fancyhead[RO]{%
    \makebox[0pt][l]{%
      \begin{tikzpicture}[remember picture,overlay, shift={(current page.north east)}]

        \node[anchor=south east]
        at (-\marginparwidth+\marginparsep+1cm,-1in-\topmargin-\headheight-\voffset+2pt) {\bf\rightmark};
      \end{tikzpicture}%
    }%
  }
  \fancyhead[LE]{%
    \makebox[0pt][r]{%
      \begin{tikzpicture}[remember picture,overlay, shift={(current page.north west)}]
        \fill[blue!40]
        (0, 0) rectangle
        (\marginparwidth-\marginparsep-1cm,-1in-\topmargin-\headheight-\voffset-\headruleskip);
        % vertical bar
        \draw[line width=4pt]
        (\marginparwidth-\marginparsep-1cm,0) --
        (\marginparwidth-\marginparsep-1cm,-1in-\topmargin-\headheight-\voffset-\headruleskip);
        % chapter number
        \node[anchor=south east]
        at (\marginparwidth-\marginparsep-1.3cm,-1in-\topmargin-\headheight-\voffset+2pt) {%
          \ifnum\value{chapter}>0%
          \bf\LARGE\color{white}\thechapter%
          \fi%
        };
        % chapter title / left mark
        \node[anchor=south west]
        at (\marginparwidth-\marginparsep-0.7cm,-1in-\topmargin-\headheight-\voffset +2pt) {\bf\leftmark};
      \end{tikzpicture}%
    }%
  }
  \renewcommand{\headrulewidth}{0pt}
  \fancyfoot[LE]{\bf\thepage}
  \fancyfoot[RO]{\bf\thepage}

  \renewcommand{\headrule}{%
    \vskip-6pt
    \vskip-\headruleskip
    \ifodd\value{page}%
      \makebox[0pt][l]{%
        \rule{\paperwidth - \oddsidemargin - 1in}{0.5pt}}%
    \else%
      \hspace*{-\evensidemargin}\hspace*{-1in}%
      \makebox[0pt][l]{%
        \rule{\textwidth + \evensidemargin + 1in}{0.5pt}}%
    \fi%
    \vskip\headruleskip
    \vskip\headrulewidth
  }
}

\fancypagestyle{PageStyle}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
}

\fancypagestyle{FrontMatterMainPages}{
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
}

\renewcommand{\headrule}{%
  \vskip-6pt
  \vskip-\headruleskip
  \ifodd\value{page}%
    \makebox[0pt][l]{%
      \rule{\paperwidth - \oddsidemargin - 1in}{0.5pt}}%
  \else%
    \hspace*{-\evensidemargin}\hspace*{-1in}%
    \makebox[0pt][l]{%
      \rule{\textwidth + \evensidemargin + 1in}{0.5pt}}%
  \fi%
  \vskip\headruleskip
  \vskip\headrulewidth
}

\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[RO]{\bf \thepage}%
  \renewcommand{\headrulewidth}{0pt}

  \renewcommand{\headrule}{}

}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%             TITLE FORMATS
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Part title definiton
\titleclass{\part}{top}
\titleformat{\part}[display]
{\vspace*{-3cm}\raggedleft\color{ChapTitleColor}}
{
  \raggedleft\resizebox{!}{\baselineskip}{\underline{\partname~\thepart}}
}
{20pt}
{\ChapHeadFont\fontsize{40pt}{42pt}\selectfont}[\vspace{-5cm}]

\newcommand\ChapHeadFont{}
\newcommand{\LowerRule}[1]{\vspace{-15pt}\rule{#1\linewidth}{0.5pt}}


\titleformat{\chapter}[display]
{%
  \vspace*{1.5ex}\huge\centering%
}%
{\raggedleft{\resizebox{!}{6\baselineskip}{\itshape\fontsize{225pt}{230pt}\color{ChapNoColor} \thechapter}}}
{-110pt}
{\ChapHeadFont\fontsize{30pt}{30pt}\selectfont\color{ChapTitleColor}\bf}
[\LowerRule{0.7}\vspace{2cm}]


\newcommand{\useappendixchapterformat}{
  \titleformat{\chapter}[display]
  {%
    \vspace*{1.5ex}\huge\centering%
  }%
  {\raggedleft{\itshape\color{ChapNoColor}\textbf{Appendix}\resizebox{!}{6\baselineskip}{%
        \itshape\color{ChapNoColor} \thechapter}}}%
  {-110pt}%
  {\ChapHeadFont\fontsize{30pt}{30pt}\selectfont\color{ChapTitleColor}\bf}
  [\LowerRule{0.7}\vspace{2cm}]
}

%% Formatting the Front Matter Numberless Chapters, Preface, Acknowledgments,...
\titleformat{name=\chapter,numberless}[display]
{\vspace*{7cm}\raggedleft}{}{0pt}
{\ChapHeadFont\fontsize{30pt}{30pt}\selectfont\color{ChapTitleColor}}
[\LowerRule{1}]
\makeatother

\newcommand\tocseparatorsymbol{{\tiny\ensuremath{\textcolor{gray}\blacksquare}}}
\titlespacing*{\chapter}{1pc}{*4}{*2.3}[1pc]
\titlecontents*{subsection}[50pt]{\small\itshape\fillast}{}{}{\enskip\thecontentspage}[\enskip\tocseparatorsymbol\enskip]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%             OTHER COMPONENTS (NOTES, HIGHLIGHTS)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\NewDocumentCommand{\TBMarginNote}{m O{8pt}}{%
  \marginnote{#1}[#2]}



\newenvironment{TBNote}{
  \begin{center}
    \begin{minipage}{0.9\textwidth}
      {\ChapterMarkFont\fontsize{11.5pt}{12pt}\selectfont
        \color{SecLevelsColor} NOTE~ }
      }{
    \end{minipage}
  \end{center}
}

\newenvironment{TlaBookHighlight}[1]{ % Use: <\par\noindent> in front of Body Paragraph
  \vspace{0.5cm}
  \begin{tcolorbox}
    {\HighlightTitleFont\fontsize{14}{15}\selectfont #1}
    \vspace{5pt}
    \begin{spacing}{1.2}
      \HighlightBodyFont\fontsize{12}{13}\color{HighlightBodyColor}\selectfont
      }{
    \end{spacing}
    \vspace{-0.5pt}
  \end{tcolorbox}
  \vspace{0.5cm}
}
