\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cultvoucher}[11/13/2021 custom CV class]

\LoadClass[10pt]{article}

\usepackage[
    top    = 2cm,
    bottom = 3cm,
    left   = 5cm,
    right  = 2cm,
]{geometry}

\renewcommand{\baselinestretch}{1.1} 
\renewcommand{\labelitemi}{\separator}

\RequirePackage{cultvoucher}
\RequirePackage{moresize}
\RequirePackage{booktabs}

\RequirePackage{soul}
\RequirePackage{xcolor}

\definecolor{lightgray}{rgb}{0.86, 0.86, 0.86}
\definecolor{darkgray}{rgb}{0.3, 0.3, 0.3}
\definecolor{keyword}{rgb}{1.0, 0.5, 0.5}
\definecolor{olive}{rgb}{0.33, 0.42, 0.18}
\RequirePackage[colorlinks=true,urlcolor=olive]{hyperref}
\RequirePackage{microtype}
\RequirePackage{newpxtext}
\RequirePackage{bookmark}

\newcommand{\email}[1]{\href{mailto:#1}{\texttt{#1}}}
\newcommand{\website}[1]{\href{https://#1}{\texttt{#1}}}
\newcommand{\separator}{{\scriptsize\textbullet{}}}

\setul{-0.5ex}{0.9ex}
\setulcolor{lightgray}

\RequirePackage[explicit]{titlesec}

\titleformat{\section}[leftmargin]
            {\Large\scshape}
            {}
            {0pt}
            {\ul{#1}}
\titlespacing{\section}{80pt}{0pt}{0pt}

\titleformat{\subsection}[runin]
            {\large\bfseries}
            {}
            {0pt}
            {#1}
\titlespacing{\subsection}{0pt}{0pt}{0.5em}

\titleformat{\subsubsection}[runin]
            {\bfseries}
            {}
            {0pt}
            {#1}
\titlespacing{\subsubsection}{0pt}{0pt}{0.5em}

\RequirePackage[strict]{changepage}
\RequirePackage{enumitem}
\RequirePackage{lastpage}
\RequirePackage{datetime}
\newdateformat{lowerdate}{\monthname[\THEMONTH] \THEYEAR}
\setlist{nosep}

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0.4pt}
\fancyfoot[L]{\lowerdate\today}
\fancyfoot[C]{}
\fancyfoot[R]{\thepage{}\ of\ \pageref*{LastPage}}


\RequirePackage{xparse}
\ExplSyntaxOn
\NewDocumentEnvironment{entry} { m m m o o } {
    \subsection{#1} #2 \hfill \textcolor{darkgray}{\slshape #3}\par
    \IfNoValueTF{#4}{}{#4}
    \IfNoValueTF{#5}{\begin{itemize}[itemsep=3pt,topsep=4pt]}{}
}{
    \IfNoValueTF{#5}{\end{itemize}}{}
}
\ExplSyntaxOff

\newcommand{\secitem}[3]{
    \subsubsection{#1} #2\hfill \textcolor{darkgray}{\slshape #3}\par
}

\newcommand{\graydate}[1]{
    \textcolor{darkgray}{\slshape #1}
}

% Emphasise a keyword.
\newcommand{\keyword}[1]{\textbf{#1}}
