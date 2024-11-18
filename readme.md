# TIA Portal Link Collection
## Description
This Repo contains a [collection of links](TIAPV17_Links_en.md) to the official downloads for TIA Portal. The sources are meant to be rendered by pandoc as pdf documents. Please consider the [disclaimer](disclaimerLinks_en.md).
## Usage
Files with *_placeholder.md do not contain the final links, but a keyword with a reference id. These files are the source of information.
The script replace_VXX.bat calls the script replace.ps1 and hands over the filename to be handled, e.g. "TIAPV19_Links_de_placeholder.md". The script then creates two files with the final links: "*.links.md", and "*.links.html".
This way, the original content is kept independant from how the links have to be structed.
The workflow could be: 
1. Change content in *_placeholder.md, and translate to descired languages.
1. Pass all *_placeholder.md files to replace.ps1 script.