FROM ubuntu:18.04

RUN apt update && apt install -y perl wget bsdtar curl && \
    curl -o /tmp/texlive2018.iso ftp://tug.org/historic/systems/texlive/2018/texlive2018.iso && \
    mkdir /tmp/install-tl && \
    bsdtar -xf /tmp/texlive2018.iso -C /tmp/install-tl/ && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "option_doc 0" \
      "option_src 0" \
      > /tmp/install-tl/texlive.profile && \
    /tmp/install-tl/install-tl --profile=/tmp/install-tl/texlive.profile
ENV PATH /usr/local/texlive/2018/bin/x86_64-linux:$PATH

RUN tlmgr option repository /tmp/install-tl/
RUN tlmgr install \
      collection-basic collection-latex \
      collection-latexrecommended collection-latexextra \
      collection-fontsrecommended collection-langjapanese latexmk
RUN apt install -y fontconfig && tlmgr install xetex
RUN apt install -y biber && tlmgr install biblatex biber
RUN tlmgr install logreq algorithm2e mathabx
RUN tlmgr install latexdiff ulem

RUN mkdir /workdir
WORKDIR /workdir
VOLUME ["/workdir"]

CMD ["bash"]

# latexdiff -e utf8 -t CFONT my_source.old.tex my_source.new.tex > my_diff.tex
# pdflatex -interaction=nonstopmode my_diff.tex
# pbibtex my_diff
# pdflatex -interaction=nonstopmode my_diff.tex
# pdflatex -interaction=nonstopmode my_diff.tex

