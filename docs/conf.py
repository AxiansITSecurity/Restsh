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
    "path_to_docs": "docs/",
    "home_page_in_toc": True,
    "repository_url": "https://github.com/AxiansITSecurity/Restsh",
    "repository_branch": "master",
    "use_repository_button": True,
    "logo": {
        "image_light": "assets/logo-light.svg",
        "image_dark": "assets/logo-dark.svg",
    },
}

# Options for sphinx.ext.autosectionlabel
# https://www.sphinx-doc.org/en/master/usage/extensions/autosectionlabel.html
autosectionlabel_prefix_document = True
autosectionlabel_maxdepth = 2
