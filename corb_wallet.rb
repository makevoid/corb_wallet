require_relative 'config/env'


class CorbWallet < Roda

  plugin(:assets,
    css: ["style.css"],
    js:  ["vendor/underscore.js", "vendor/qrcode.js"],
  )

  # plugin :render, engine: :haml # TODO: PR to Roda to accept hashes
  plugin :render, engine: "haml"
  plugin :partials
  plugin :not_found

  def json_route
    response['Content-Type'] = 'application/json'
  end

  def wallet
    @@wallet ||= Wallet.new
  end

  def params
    symbolize request.params
  end

  # monkeypatches

  def symbolize(hash)
    Hash[hash.map{|(k,v)| [k.to_sym,v]}]
  end

  # view

  def body_class
    request.path.split("/")[1]
  end

  def table_row(text, colspan: 5)
    haml_tag(:tr) do
      haml_tag(:td, colspan: colspan) do
        haml_concat text
      end
    end
  end

  route do |r|

    r.root do
      r.redirect "/receive"
    end

    r.on "receive" do
      r.is do
        r.get do
          view "receive"
        end
      end
    end

    r.on "send" do
      r.is do
        r.get do
          view "send"
        end

        r.post do
          wallet.send params[:to], params[:amount].to_f
        end
      end
    end

    r.on "transactions" do
      r.is do
        r.get do
          view "transactions"
        end
      end
    end

    r.on "extra" do
      r.is do
        r.get do
          view "extra"
        end
      end
    end

    r.assets
  end

  not_found do
    view "not_found"
  end
end
