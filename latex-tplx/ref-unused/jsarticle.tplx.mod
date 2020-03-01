% Default to the notebook output style
((* if not cell_style is defined *))
    ((* set cell_style = 'style_ipython.tplx' *))
((* endif *))

% Inherit from the specified cell style.
((* extends cell_style *))


%===============================================================================
% Latex Article
%===============================================================================

((* block docclass *))
\documentclass[uplatex,dvipdfmx,11pt,a4j]{jsarticle}
\usepackage{graphicx}
\usepackage{hyperref}
\usepackage{pxjahyper}
((* endblock docclass *))

((* block packages *))
\usepackage[T1]{fontenc}
% \usepackage{xeCJK}
\setlength{\parindent}{0in}  % comment out this line from the output tex source,
                             % in case indent at new paragraph is needed.

% Basic figure setup, for now with no caption control since it's done
% automatically by Pandoc (which extracts ![](path) syntax from Markdown).
\usepackage{graphicx}
% Maintain compatibility with old templates. Remove in nbconvert 6.0
\let\Oldincludegraphics\includegraphics
% Ensure that by default, figures have no caption (until we provide a
% proper Figure object with a Caption API and a way to capture that
% in the conversion process - todo).
\usepackage{caption}
% \DeclareCaptionFormat{nocaption}{}
% \captionsetup{format=nocaption,aboveskip=0pt,belowskip=0pt}

\usepackage[Export]{adjustbox} % Used to constrain images to a maximum size
\adjustboxset{max size={0.9\linewidth}{0.9\paperheight}}
\usepackage{float}
\floatplacement{figure}{H} % forces figures to be placed at the correct location
\usepackage{xcolor} % Allow colors to be defined
\usepackage{enumerate} % Needed for markdown enumerations to work
\usepackage{geometry} % Used to adjust the document margins
\usepackage{amsmath} % Equations
\usepackage{amssymb} % Equations
\usepackage{calc} % for bigfrown
\usepackage{textcomp} % defines textquotesingle
% Hack from http://tex.stackexchange.com/a/47451/13684:
\AtBeginDocument{%
    \def\PYZsq{\textquotesingle}% Upright quotes in Pygmentized code
}
\usepackage{upquote} % Upright quotes for verbatim code
\usepackage{eurosym} % defines \euro
\usepackage[mathletters]{ucs} % Extended unicode (utf-8) support
\usepackage{fancyvrb} % verbatim replacement that allows latex
\usepackage{grffile} % extends the file name processing of package graphics
                     % to support a larger range
\makeatletter % fix for grffile with XeLaTeX
\def\Gread@@xetex#1{%
  \IfFileExists{"\Gin@base".bb}%
  {\Gread@eps{\Gin@base.bb}}%
  {\Gread@@xetex@aux#1}%
}
\makeatother

% The hyperref package gives us a pdf with properly built
% internal navigation ('pdf bookmarks' for the table of contents,
% internal cross-reference links, web links for URLs, etc.)
\usepackage{hyperref}
% The default LaTeX title has an obnoxious amount of whitespace. By default,
% titling removes some of it. It also provides customization options.
\usepackage{titling}
\usepackage{longtable} % longtable support required by pandoc >1.10
\usepackage{booktabs}  % table support for pandoc > 1.12.2
\usepackage[inline]{enumitem} % IRkernel/repr support (it uses the enumerate* environment)
\usepackage[normalem]{ulem} % ulem is needed to support strikethroughs (\sout)
                            % normalem makes italics be italics, not underlines
\usepackage{mathrsfs}
((* endblock packages *))


((* block maketitle *))

((*- if nb.metadata.get("latex_metadata", {}).get("title", ""): -*))
\title{((( nb.metadata["latex_metadata"]["title"] )))}
((*- else -*))
((*- set nb_title = nb.metadata.get('title', '') or resources['metadata']['name'] -*))
\title{((( nb_title | escape_latex )))}
((*- endif *))

((*- if nb.metadata.get("latex_metadata", {}).get("author", ""): -*))
\author{((( nb.metadata["latex_metadata"]["author"] )))}
((*- else -*))
    ((* if 'authors' in nb.metadata *))
    \author{((( nb.metadata.authors | join(', ', attribute='name') )))}
    ((* else *))
    \author{Johanes Ivan Setiawan}
    ((* endif *))
((*- endif *))

((* if nb.metadata["date"]: *))
\date{((( nb.metadata["date"] )))}
((* endif *))

\maketitle

((* endblock maketitle *))
