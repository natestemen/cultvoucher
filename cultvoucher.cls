\LoadClass[11pt]{article}

\usepackage[
    top=2.5cm,
    bottom=2.5cm,
    left=6cm,
    right=2.5cm,
    marginparwidth=3cm,
    marginparsep=0.5cm,
    reversemarginpar
]{geometry}

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{cultvoucher}[3/13/2016 custom CV class]

\RequirePackage{xhfill}
\RequirePackage{soul}
\RequirePackage{xcolor}

% \definecolor{lightgray}{rgb}{0.96, 0.76, 0.76}
\definecolor{lightgray}{rgb}{0.86, 0.86, 0.86}
\definecolor{darkgray}{rgb}{0.3, 0.3, 0.3}
\definecolor{keyword}{rgb}{1.0, 0.5, 0.5}
\definecolor{olive}{rgb}{0.33, 0.42, 0.18}
\RequirePackage[colorlinks=true,urlcolor=olive]{hyperref}
\RequirePackage[protrusion=true,expansion=true]{microtype}
\RequirePackage{newpxtext}

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
\fancyfoot[L]{November 2019}
\fancyfoot[C]{}
\fancyfoot[R]{\thepage{}\ of\ \pageref*{LastPage}}
\renewcommand{\footrulewidth}{0.4pt}

\fancypagestyle{firststyle}{
    \fancyhf{}
    \renewcommand{\headrulewidth}{0pt}
    \fancyfoot[L]{November 2019}
    \fancyfoot[R]{\thepage{}\ of\ \pageref*{LastPage}}
}

\newcommand{\rhsentry}[3]{
    \textbf{#1}\hfill\textcolor{darkgray}{\slshape #2}\par
    #3
}

\newcommand{\lhsentry}[3]{
    \textbf{#1}: #2\hfill\textcolor{darkgray}{\slshape #3}\par
}


% \newcommand{\education}[2]{#1 \hfill #2 \\}
% \newcommand{\teaching}[3]{{#1 \hfill #2} \\ \textit{#3} \\} 
% \newcommand{\prize}[2]{#1 \hfill #2 \\} 
% \newcommand{\news}[3]{{#1 \hfill #2} \\ \textit{#3} \\}


% \newcommand{\inlinemain}[1]{%
% \color{subheadings}\fontsize{11pt}{13pt}\raleway{Medium} #1 \normalfont}

% \newcommand{\inlineextra}[1]{%
% \color{headings}\fontsize{10pt}{12pt}\raleway{Medium} #1 \normalfont}

% \newcommand{\entryhead}[3]{%
% \ifthenelse{\equal{#1}{}}{}{\subsection{#1}}%
% \inlinemain{#2}%
% \inlineextra{#3}%
% \ifthenelse{\equal{#2}{}}{}{\\}%
% \color{primary}}


% \project[name]{link}{summary}{description}
% \newcommand{\project}[4][]{%
% \entryhead{#1}{#3}{\hfill #2}%
% #4%
% \sectionspace}

% Emphasise a keyword.
\newcommand{\keyword}[1]{\textbf{#1}}
