\LoadClass[10pt]{article}
\pagenumbering{gobble}

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{cultvoucher}[3/13/2016 custom CV class]

\RequirePackage{xhfill,soul,xcolor}
% \RequirePackage{soul}
% \RequirePackage{xcolor}

% \definecolor{lightgray}{rgb}{0.96, 0.76, 0.76}
\definecolor{lightgray}{rgb}{0.86, 0.86, 0.86}
\definecolor{darkgray}{rgb}{0.3, 0.3, 0.3}
\definecolor{keyword}{rgb}{1.0, 0.5, 0.5}

\setul{-.4ex}{0.8ex}
\setulcolor{lightgray}


\RequirePackage[explicit]{titlesec}

\newcommand*{\raisedrulefill}[1]{%
    \leaders\hbox{\textcolor{lightgray}
        {\rule[0.323ex]{0.5pt}{0.5pt}}}\hfill
}

\titleformat{\section}
    {\Large\scshape}
    {}
    {0em}
    {\ul{#1}\raisedrulefill}

\titleformat{\subsection}
    {\normalsize\raggedright}
    {}
    {0em}
    {#1}
    
\newenvironment{tightitemize}{
    \vspace{-\topsep}
    \begin{itemize}
    \setlength{\itemindent}{-10pt}
    \setlength{\itemsep}{0pt}
    \setlength{\parskip}{0pt}
    \setlength{\parsep}{0pt}
}{
    \end{itemize}\vspace{-\topsep}
}


\newcommand{\rhsentry}[3]{
    \textbf{#1}\hfill\textcolor{darkgray}{\slshape #2}

    #3
}

\newcommand{\lhsentry}[3]{
    \textbf{#1}: #2 \hfill \textcolor{darkgray}{\slshape #3}
}




% \newcommand{\datedsection}[2]{\section[#1]{#1 \hfill \textcolor{lightgray}{{\sffamily #2}}}}
% \newcommand{\datedsubsection}[2]{\subsection[#1]{#1 \hfill \textcolor{darkgray}{{\slshape #2}}}}
  
\newcommand{\education}[2]{#1 \hfill #2 \\}
\newcommand{\teaching}[3]{{#1 \hfill #2} \\ \textit{#3} \\} 
\newcommand{\prize}[2]{#1 \hfill #2 \\} 
\newcommand{\news}[3]{{#1 \hfill #2} \\ \textit{#3} \\}

% \newcommand{\random}{}

\newcommand{\inlinemain}[1]{%
\color{subheadings}\fontsize{11pt}{13pt}\raleway{Medium} #1 \normalfont}

\newcommand{\inlineextra}[1]{%
\color{headings}\fontsize{10pt}{12pt}\raleway{Medium} #1 \normalfont}

\newcommand{\entryhead}[3]{%
\ifthenelse{\equal{#1}{}}{}{\subsection{#1}}%
\inlinemain{#2}%
\inlineextra{#3}%
\ifthenelse{\equal{#2}{}}{}{\\}%
\color{primary}}

% \published{year}{title}{publisher}{authors}{venue}
\newcommand{\published}[5]{%
\entryhead{#2}{}{}%
#4, #1. \ifthenelse{\equal{#5}{}}{\textit{#3}}{In \textit{#5}}.%
\sectionspace}

% \employed[organisation]{dates}{title}{location}{description}
\newcommand{\employed}[5][]{%
\entryhead{#1}{#3}{#2, #4.}%
#5%
\sectionspace}

% \degree[institute]{dates}{qualification}{grade}{description}
\newcommand{\degree}[5][]{%
\entryhead{#1}{#3}{#2\ifthenelse{\equal{#4}{}}{}{, #4}.}%
#5%
\sectionspace}

% \contribution[name]{dates}{title}{link}{description}
\newcommand{\contribution}[5][]{%
\entryhead{#1}{#3}{#2. \hfill #4}%
#5%
\sectionspace}

% \project[name]{link}{summary}{description}
\newcommand{\project}[4][]{%
\entryhead{#1}{#3}{\hfill #2}%
#4%
\sectionspace}

% -----------------------------------------------------------------------------
% -- Extras

% Emphasise a keyword.
\newcommand{\keyword}[1]{\textcolor{keyword}{#1}}

% 'itemize', but with less spacing.
% \newenvironment{tightitemize}{\vspace{-\topsep}\begin{itemize}\itemsep1pt \parskip0pt \parsep0pt}{\end{itemize}\vspace{-\topsep}}
