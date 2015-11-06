# Corb Wallet
### Ruby Web Wallet based on Bitcoin Core

site: http://makevoid.github.io/corb_wallet  (gh pages)

#### Simple UI + secure and custom wallet API on top of the standard Bitcoin Core JSON RPC API

#### Bitcoin Core

you need to download Bitcoin Core from bitcoin.org

you can find precompiled binaries for your system or compile the source yourself

the JSON API is available on both `bitcoind` and `bitcoin-qt` (the QT GUI)

#### Installing

to install this wallet app you need ruby 2.1+ installed, then run:

    gem i bundler

    bundle

#### Running it

    rackup

#### Configurations

check `config/env.rb`

you need to configure your `~/.bitcoin/bitcoin.conf`

this is a simple example config:

    rpcuser=bitcoinrpc
    rpcpassword=YOUR_PASSWORD_HERE

    server=1

run `bitcoind`

#### Why Ruby?

Simplicity, gives the ability to create DSL easily

#### Why on Bitcoin Core?

Bitcoin Core is the most common, reliable, and most frequently updated implementation we have at the moment, until libbitcoin will be the reference implementation, the JSON RPC API provided by bitcoin core is the easiest and most straightfoward way to run the latest (full) bitcoin on your machine/server.
Interacting with it's API is easy and fun! Especially in a dynamic language like Ruby!

#### Why the name CoRb?

Co stands for Core and Rb is for Ruby :D


#### powered by

- Roda, the routing tree framework, fast, concise and fun!

- Bitcoin-Client

- Haml

- Redis (optional, get commands cache)


enjoy!
