# DEAC Wiki

## TODO

Linux tutorial links
https://support.ceci-hpc.be/doc/
https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html
https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html







## Modifying content, building the docs, and updating ReadtheDocs


### Style Conventions

Talk about using comments to separate, on the labels for cross-referencing, etc.


## Migrating from MediaWiki

First, install some basic software packages,

```sh
sudo apt install curl python3-sphinx-rtd-theme python3-sphinx-autobuild pandoc php php-xml php-curl
```

to facilitate the migration. We will be using the `mediawiki-to-markdown` tool
to convert to our wiki pages to reStructuredText. Download the tool and install
the requirements,

```sh
git clone git@github.com:philipashlock/mediawiki-to-markdown.git && cd mediawiki-to-markdown
curl -sS https://getcomposer.org/installer | php && php composer.phar install
```

All wiki pages need to be exported into XML format for subsequent conversion to
reStructuredText. This can be readily accomplished using the built-in MediaWiki
API. For instance,

```sh
curl -d "&action=submit&curonly=1&pages=$(curl --silent 'https://wiki.deac.wfu.edu/user/api.php?action=query&list=allpages&apfrom=a&apto=z&apnamespace=0&format=json&aplimit=500' | jq '.query.allpages | values | .[] | .title' | tr -d '"')" https://wiki.deac.wfu.edu/user/Special:Export -o "wiki_export.xml"
```

is a one-liner that queries the wiki, obtains every page name, and then proceeds
to export them in XML format. Once the base content is in XML format, we can use
the aforementioned tool to convert each page and separate them into individual
files,

```sh
php convert.php --filename=wiki_export.xml --output=export --format=rst
for file in export/*.md; do mv -- "$file" "${file%.md}.rst"; done
for file in export/*:*.rst; do mv -- "$file" "${file/:/-}"; done
```

Move the contents of the `export/` directory to the `source` directory that is
within the Sphinx framework. Likewise, we can automatically get all the image
and file URLs from the Mediawiki API and download them with `wget` with a
one-liner,

```sh
wget -q $(curl --silent 'https://wiki.deac.wfu.edu/user/api.php?action=query&format=json&list=allimages&aisort=timestamp&ailimit=500' | jq '.query.allimages | .[] | .url' | tr -d '"')
```

which will silently download everything. Place these files in the
`source/images` directory within the Sphinx framework.
