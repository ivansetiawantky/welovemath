# welovemath
Mainly jupyter notebook for math problem and solution.

# How to convert to pdf

## For English only \TeX source file

```console
$ pwd
~/welovemath/smak1/20200208_prob_sin2x
$ jupyter nbconvert 20200208_prob_sin2x.ipynb --to=pdf --TemplateExporter.exclude_input=True --template=../../latex-tplx/ivans_style_jupyter.tplx && open 20200208_prob_sin2x.pdf
```

## 日本語混じりの \TeX source file

```console
$ pwd
~/welovemath/misc/testjpfont
$ rm -rf output-dir; jupyter nbconvert testjpfont.ipynb --to=latex --TemplateExporter.exclude_input=True --template=../../latex-tplx/ivans_jsarticle.tplx --output-dir=output-dir
$ cd output-dir
$ ptex2pdf -u -l -ot "-shell-escape" testjpfont.tex
$ ptex2pdf -u -l -ot "-shell-escape" testjpfont.tex
$ ptex2pdf -u -l -ot "-shell-escape" testjpfont.tex
$ open testjpfont.pdf
```
