\LoadClass[10pt]{article}

\usepackage[
    top=3cm,
    bottom=3cm,
    left=6cm,
    right=2.5cm,
    marginparwidth=3cm,
    marginparsep=0.5cm,
    reversemarginpar,
    headheight=14pt
]{geometry}

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{cultvoucher}[3/13/2016 custom CV class]

\RequirePackage{xhfill}
\RequirePackage{soul}
\RequirePackage{xcolor}

\definecolor{lightgray}{rgb}{0.86, 0.86, 0.86}
\definecolor{darkgray}{rgb}{0.3, 0.3, 0.3}
\definecolor{keyword}{rgb}{1.0, 0.5, 0.5}
\definecolor{olive}{rgb}{0.33, 0.42, 0.18}
\RequirePackage[colorlinks=true,urlcolor=olive]{hyperref}
\RequirePackage{microtype}
\RequirePackage{newpxtext}

\newcommand{\email}[1]{\href{mailto:#1}{\texttt{#1}}}
\newcommand{\website}[1]{\href{https://#1}{\texttt{#1}}}
\newcommand{\separator}{{\scriptsize\textbullet{}}}

\setul{-.4ex}{0.8ex}
\setulcolor{lightgray}

\RequirePackage[explicit]{titlesec}

\newcommand*{\raisedrulefill}[1]{%
    \leaders\hbox{\textcolor{lightgray}{\rule[0.323ex]{0.5pt}{0.5pt}}}\hfill
}

\titleformat{\section}[block]
            {\Large\scshape}
            {}
            {0pt}
            {\marginnote{\raggedright\ul{#1}\raisedrulefill}}
\titlespacing{\section}{0pt}{\baselineskip}{0pt}


\RequirePackage{parskip}
\RequirePackage[strict]{changepage}
\RequirePackage{marginnote}
\RequirePackage{enumitem}
\RequirePackage{lastpage}
\RequirePackage{datetime}
\newdateformat{lowerdate}{\monthname[\THEMONTH] \THEYEAR}
\setlist{noitemsep,leftmargin=*}

\RequirePackage{fancyhdr}
\setlength{\headwidth}{\dimexpr\textwidth+\marginparsep+\marginparwidth}
% \fancyhead{}
% \renewcommand{\headrule}{}

\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{Nathaniel T. Stemen}
\fancyhead[C]{}
\fancyhead[R]{}
\renewcommand{\headrulewidth}{0.4pt}
\fancyfoot[L]{\lowerdate\today}
\fancyfoot[C]{}
\fancyfoot[R]{\thepage{}\ of\ \pageref*{LastPage}}
\renewcommand{\footrulewidth}{0.4pt}

\fancypagestyle{firststyle}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[L]{\lowerdate\today}
    \fancyfoot[R]{\thepage{}\ of\ \pageref*{LastPage}}
}

\newcommand{\rhsentry}[3]{
    \textbf{#1}\hfill\textcolor{darkgray}{\slshape #2}\par
    #3
}

\newcommand{\lhsentry}[3]{
    \textbf{#1}: #2\hfill\textcolor{darkgray}{\slshape #3}\par
}

% Emphasise a keyword.
\newcommand{\keyword}[1]{\textbf{#1}}
