# pokegay
### _ava fox_

mastodon bot to tell you which pokemon is gay

(its all of them. theyre all gay. every single one of them.)

## Building

using [roswell](https://github.com/roswell/roswell):

```shell
$ mkdir ~/common-lisp
$ git clone https://github.com/compufox/pokegay-bot ~/common-lisp/pokegay
$ ros run --eval "(ql:quickload :pokegay)" --eval "(asdf:make :pokegay)" --eval "(quit)"
```

expects a config file (named `config.file`) containing the mastodon instance and access keys. 

also expects a tracery json file named `pokemon.json` with keys "alert" and "names"

## License

NPLv1+

