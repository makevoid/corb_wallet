require 'json'

class Transaction
  attr_reader :account, :address, :category, :amount, :vout, :confirmations, :blockhash, :blockindex, :blocktime, :txid, :walletconflicts, :time, :timereceived

  def initialize(account:, address:, category:, amount:, vout:, confirmations:, blockhash:, blockindex:, blocktime:, txid:, walletconflicts:, time:, timereceived:)
    @account = account
    @address = address
    @category = category
    @amount = amount
    @vout = vout
    @confirmations = confirmations
    @blockhash = blockhash
    @blockindex = blockindex
    @blocktime = blocktime
    @txid = txid
    @walletconflicts = walletconflicts
    @time = time
    @timereceived = timereceived
  end

  def tx_id_short
    "#{txid[0..6]}...#{txid[-3..-1]}"
  end

  def time_s
    Time.at(time).strftime("%H:%M - %d %b '%y")
  end

  def amount_s
    "%.6f" % amount
  end
end

class Wallet

  def initialize
    @client = BitcoinClient::Client.new 'bitcoinrpc', RPC_PASSWORD, host: RPC_HOST, cache: true
  end

  def address
    @client.getaccountaddress ""
  end

  def balance
    @client.balance
  end

  def balance_zeroconf
    @client.balance "", 0
  end

  def send(to, amount)
    @client.sendtoaddress to, amount
  end

  def transactions
    txs = @client.listtransactions.reverse
    txs.map do |tx|
      tx = symbolize tx
      Transaction.new(
        account:         tx.fetch(:account),
        address:         tx.fetch(:address),
        category:        tx.fetch(:category),
        amount:          tx.fetch(:amount),
        vout:            tx.fetch(:vout),
        confirmations:   tx.fetch(:confirmations),
        blockhash:       tx[:blockhash],
        blockindex:      tx[:blockindex],
        blocktime:       tx[:blocktime],
        txid:            tx.fetch(:txid),
        walletconflicts: tx.fetch(:walletconflicts),
        time:            tx.fetch(:time),
        timereceived:    tx.fetch(:timereceived),
      )
    end
  end

  if APP_ENV == "development"
    def dev
      @client
    end
  end

  private

  # TODO: move

  def symbolize(hash)
    Hash[hash.map{|(k,v)| [k.to_sym,v]}]
  end

end
