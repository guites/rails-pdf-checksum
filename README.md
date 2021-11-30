# rails-pdf-checksum

Simple rails app based on `bin/rails create blog`

For each blog entry, creates a pdf using the title and body, and associates different checksums to it \(md5, sha1, sha128, sha256\).

These values can them be confirmed by downloading the pdf.

On a linux system:

```
shasum -a 1 article_1.pdf
shasum -a 256 article_1.pdf
shasum -a 512 article_1.pdf
md5 article_1.pdf
```


## Instalation

```
git clone git@github.com:guites/rails-pdf-checksum.git && cd rails-pdf-checksum
bundle install
bin/rake db:migrate
bin/rails s
```


### To-do

- [ ] Create upload functionallity to verify checksums on server side.
- [ ] Create custom key to be verified via endpoint.
