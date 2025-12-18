# LaTeX/Mathematics

TeX (/tɛx/, see below), stylized within the system as TEX, is a typesetting system which was designed and written by computer scientist and Stanford University professor Donald Knuth[1] and first released in 1978. TeX is a popular means of typesetting complex mathematical formulae; it has been noted as one of the most sophisticated digital typographical systems.[2]

TeX is widely used in academia, especially in mathematics, computer science, economics, political science, engineering, linguistics, physics, statistics, and quantitative psychology. It has long since displaced Unix troff,[b] the previously favored formatting system, in most Unix installations. It is also used for many other typesetting tasks, especially in the form of LaTeX, ConTeXt, and other macro packages.

TeX was designed with two main goals in mind: to allow anybody to produce high-quality books with minimal effort, and to provide a system that would give exactly the same results on all computers, at any point in time (together with the Metafont language for font description and the Computer Modern family of typefaces).[3] TeX is free software, which made it accessible to a wide range of users.

One of the greatest motivating forces for Donald Knuth when he began developing the original TeX system was to create something that allowed simple construction of mathematical formulae, while looking professional when printed. The fact that he succeeded was most probably why TeX (and later on, LaTeX) became so popular within the scientific community. Typesetting mathematics is one of LaTeX's greatest strengths. It is also a large topic due to the existence of so much mathematical notation.

If your document requires only a few simple mathematical formulas, plain LaTeX has most of the tools that you will ever need. If you are writing a scientific document that contains numerous complex formulas, the amsmath package[1] introduces several new commands that are more powerful and flexible than the ones provided by basic LaTeX. The mathtools package fixes some amsmath quirks and adds some useful settings, symbols, and environments to amsmath.[2] To use either package, include:

\usepackage{amsmath}
or

\usepackage{mathtools}
in the preamble of the document. The mathtools package loads the amsmath package and hence there is no need to \usepackage{amsmath} in the preamble if mathtools is used.

## references

<https://en.wikibooks.org/wiki/LaTeX/Mathematics>

## Mathematics environments

LaTeX needs to know when the text is mathematical. This is because LaTeX typesets math notation differently from normal text. Therefore, special environments have been declared for this purpose. They can be distinguished into two categories depending on how they are presented:

text — text formulas are displayed inline, that is, within the body of text where it is declared, for example, I can say that

{\displaystyle a+a=2a} within this sentence.
displayed — displayed formulas are on a line by themselves.

As math requires special environments, there are naturally the appropriate environment names you can use in the standard way. Unlike most other environments, however, there are some handy shorthands for declaring your formulas. The following table summarizes them:

The quadratic formula is $-b \pm \sqrt{b^2 - 4ac} \over 2a$

The formula is printed in a way a person would write by hand, or typeset the equation. In a document, entering mathematics mode is done by starting with a $ symbol, then entering a formula in TeX syntax, and closing again with another of the same symbol. Knuth explained in jest that he chose the dollar sign to indicate the beginning and end of mathematical mode in plain TeX because typesetting mathematics was traditionally supposed to be expensive.[24] Display mathematics (mathematics presented centered on a new line) is similar but uses $$ instead of a single $ symbol. For example, the above with the quadratic formula in display math:
The quadratic formula is
$$-b \pm \sqrt{b^2 - 4ac} \over 2a$$

Writing expressions as blocks
To add a math expression as a block, start a new line and delimit the expression with two dollar symbols $$.

**The Cauchy-Schwarz Inequality**
$$\left( \sum_{k=1}^n a_k b_k \right)^2 \leq \left( \sum_{k=1}^n a_k^2 \right) \left( \sum_{k=1}^n b_k^2 \right)$$
