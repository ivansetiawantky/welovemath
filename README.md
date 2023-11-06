welovemath
====

Mainly jupyter notebook for math problem and solution.

# Preparation

## Create & activate virtual environment using `venv`

```bash
$ python3 -m venv ~/pyvenvs/welovemathnb
$ source ~/pyvenvs/welovemathnb/bin/activate
$ deactivate # to deactivate the virtual env
```

## pip-install the required python modules

```bash
(welovemathnb)$ pip install --upgrade pip
(welovemathnb)$ pip install jupyter
(welovemathnb)$ pip install matplotlib
#? (welovemathnb)$ pip install jupyter_contrib_nbextensions
#? (welovemathnb)$ pip install --upgrade notebook==6.4.12 # DOWNGRADE
#? (welovemathnb)$ pip uninstall traitlets
#? (welovemathnb)$ pip install traitlets==5.9.0

(welovemathnb)$ pip freeze | grep kernel # just for checking
(welovemathnb)$ jupyter --version # just for checking
(welovemathnb)$ jupyter --path # just for checking

(welovemathnb)$ cd PATH_TO_WELOVEMATH_CLONE
(welovemathnb)$ jupyter notebook
    Press Control-C to end server.
```

* Then open any ipynb file.

# How to convert to html

```bash
$ jupyter nbconvert 20200208_prob_sin2x.ipynb --to html --HTMLExporter.theme=dark --output asdf.html
```

# How to convert to pdf (error: ! LaTeX Error: File `tcolorbox.sty' not found.)

## Preparation for \TeX

### Add template path

```bash
% cat ~/.jupyter/jupyter_nbconvert_config.json
{
    "extra_template_paths": [
      ".",
      "/home/username/pyvenvs/welovemathnb/lib/python3.11/site-packages/jupyter_contrib_nbextensions/templates",
      "/home/username/pyvenvs/welovemathnb/share/jupyter/nbconvert/templates/latex" # Add this to solve "jinja2.exceptions.TemplateNotFound: index.tex.j2"
    ],
}
```

### Modify index.tex.j2 to use Japanese article (`\documentclass[11pt]{article}` will become `\documentclass[xelatex,ja=standard]{bxjsarticle}`)

* `vi /home/username/pyvenvs/welovemathnb/share/jupyter/nbconvert/templates/latex/index.tex.j2`
* Change `\documentclass[11pt]{article}` to `\documentclass[xelatex,ja=standard]{bxjsarticle}`.

## Output to \TeX file

* Because it is difficult to solve the `tcolorbox.sty` problem, so first we convert the ipynb to \LaTeX.

```bash
#? $ jupyter nbconvert 20200208_prob_sin2x.ipynb --to=latex --TemplateExporter.exclude_input=True --template=../../latex-tplx/ivans_style_jupyter.tplx --output="mytest"
#? Above is bad, because ivans_style_jupyter.tplx is NOT considered at all...
$ jupyter nbconvert 20200208_prob_sin2x.ipynb --to=latex --TemplateExporter.exclude_input=True --output="mytest"
```

* Then finally, use \LaTeX container (vscode devcontainer) to compile the \TeX file.

* In case the header of the tex file is `\documentclass[11pt]{article}`, then use `lualatex`

```bash
$ cd /path/to/texfile_directory
$ docker run --rm --name latex-template-ja -it -v ${PWD}:/workdir ghcr.io/being24/latex-docker
# lualatex mytest.tex
# lualatex mytest.tex (Run more than 2 times to get reference number correct)
```

* In case the header of the tex file is `\documentclass{jsarticle}`, then use `uplatex` which is called by `latexmk`

```bash
$ cd /path/to/texfile_directory
$ docker run --rm --name latex-template-ja -it -v ${PWD}:/workdir ghcr.io/being24/latex-docker
# xelatex mytest.tex
# xelatex mytest.tex (Run more than 2 times to get reference number correct)
```

## For English only \TeX source file

```bash
$ pwd
~/welovemath/smak1/20200208_prob_sin2x
$ jupyter nbconvert 20200208_prob_sin2x.ipynb --to=pdf --TemplateExporter.exclude_input=True --template=../../latex-tplx/ivans_style_jupyter.tplx && open 20200208_prob_sin2x.pdf
$ jupyter nbconvert 20200208_prob_sin2x.ipynb --to=pdf --TemplateExporter.exclude_input=True --template=../../latex-tplx/ivans_style_jupyter.tplx --output="mytest" --debug
```

## 日本語混じりの \TeX source file

```bash
$ pwd
~/welovemath/misc/testjpfont
#? $ rm -rf output-dir; jupyter nbconvert testjpfont.ipynb --to=latex --TemplateExporter.exclude_input=True --template=../../latex-tplx/ivans_jsarticle.tplx --output-dir=output-dir
#? Above is bad, because ivans_style_jupyter.tplx is NOT considered at all...
$ rm -rf output-dir; jupyter nbconvert testjpfont.ipynb --to=latex --TemplateExporter.exclude_input=True --output-dir=output-dir

#? $ cd output-dir
#? $ ptex2pdf -u -l -ot "-shell-escape" testjpfont.tex
#? $ ptex2pdf -u -l -ot "-shell-escape" testjpfont.tex
#? $ ptex2pdf -u -l -ot "-shell-escape" testjpfont.tex
#? $ open testjpfont.pdf

$ docker run --rm --name latex-template-ja -it -v ${PWD}:/workdir ghcr.io/being24/latex-docker
# cd output-dir
# xelatex testjpfont.tex
# xelatex testjpfont.tex (Run more than 2 times to get reference number correct)
```
