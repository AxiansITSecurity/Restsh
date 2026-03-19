# SPDX-License-Identifier: GPL-3.0-or-later
# (c) Axians IT Security GmbH
# Jürgen Mang <juergen.mang@sec.axians.de>
# https://www.axians.de/security
# https://github.com/AxiansITSecurity/Restsh

# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information

project = 'Restsh'
copyright = 'Axians IT Security GmbH'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = [
    'sphinx_copybutton',
    'myst_parser',
    "sphinx.ext.autosectionlabel",
]

templates_path = ['_templates']
exclude_patterns = [
    '_includes/*'
]

# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'sphinx_book_theme'
html_static_path = [
    '_assets',
]
html_favicon = '_assets/automation-transparent.svg'
html_css_files = [
    'custom.css',
]
html_theme_options = {
    "announcement": "<div><svg width=\"50px\" height=\"50px\" enable-background=\"new 0 0 24 24\" version=\"1.1\" viewBox=\"0 0 24 24\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"m6.9515 11.542c-0.019221 0.14601-0.029159 0.29691-0.029159 0.45754 0 0.15572 0.0099 0.31151 0.034339 0.45752l-0.98821 0.76906c-0.087541 0.06807-0.1119 0.19953-0.058269 0.29689l0.93454 1.616c0.058269 0.10708 0.18008 0.14116 0.28716 0.10708l1.1632-0.46724c0.24335 0.18497 0.50133 0.34071 0.78852 0.45752l0.17525 1.2363c0.019158 0.1169 0.11689 0.19954 0.23362 0.19954h1.8691c0.11689 0 0.20928-0.08274 0.2288-0.19954l0.17525-1.2363c0.28717-0.1169 0.55002-0.27744 0.78851-0.45753l1.1633 0.46725c0.10708 0.03894 0.22873 0 0.28716-0.10709l0.92966-1.616c0.05834-0.10216 0.03895-0.22879-0.05833-0.29689l-0.98826-0.7691c0.02447-0.14601 0.04371-0.30664 0.04371-0.45754 0-0.15089-0.0099-0.31151-0.03427-0.45751l0.98821-0.76908c0.0875-0.0681 0.1119-0.19954 0.05834-0.29691l-0.93448-1.616c-0.058264-0.10708-0.18008-0.14117-0.28716-0.10708l-1.1633 0.46727c-0.2433-0.18501-0.50127-0.34076-0.78845-0.45759l-0.17523-1.2363c-0.024444-0.11674-0.11689-0.19955-0.23363-0.19955h-1.8691c-0.11689 0-0.21416 0.08274-0.22879 0.19954l-0.17524 1.2363c-0.28716 0.11689-0.55004 0.27258-0.78851 0.45752l-1.1633-0.46725c-0.10708-0.039018-0.22874 0-0.28717 0.10707l-0.93455 1.616c-0.058268 0.10708-0.034342 0.22879 0.05827 0.2969zm3.4754-1.2947c0.96374 0 1.7523 0.78852 1.7523 1.7523 0 0.96375-0.78852 1.7523-1.7523 1.7523-0.96375 0-1.7523-0.78851-1.7523-1.7523 0-0.96375 0.78853-1.7523 1.7523-1.7523z\" fill=\"#fff\" stroke-width=\".48676\"/><path d=\"m9.7186 3.0342c4.9511-0.43316 9.317 3.2303 9.7502 8.1814l2.9886-0.26146-3.6362 4.3334-4.3334-3.6362 2.9886-0.26147c-0.33729-3.8553-3.7282-6.7006-7.5835-6.3633-3.8553 0.33729-6.7006 3.7282-6.3633 7.5835 0.33729 3.8553 3.7282 6.7006 7.5835 6.3633 1.5043-0.13161 2.8562-0.74176 3.9312-1.6489l1.5401 1.3108c-1.4131 1.2881-3.2449 2.151-5.297 2.3305-4.9511 0.43316-9.317-3.2303-9.7502-8.1814-0.43316-4.9511 3.2303-9.317 8.1814-9.7502z\" fill=\"#fff\"/></svg><h4 class=\"ax-logo\">Restsh Documentation</h4></div><div></div>",
    "path_to_docs": "docs/",
    "home_page_in_toc": True,
}

# Options for sphinx.ext.autosectionlabel
# https://www.sphinx-doc.org/en/master/usage/extensions/autosectionlabel.html
autosectionlabel_prefix_document = True
autosectionlabel_maxdepth = 2
