class RootController < ApplicationController
  def index
    session['enable_bank_accounts'] = false unless session.to_h.keys.include? 'enable_bank_accounts'
    session['enable_documents'] = false unless session.to_h.keys.include? 'enable_documents'
    session['enable_factorybot'] = false unless session.to_h.keys.include? 'enable_factorybot'

    @examples = EXAMPLES.map { |k,v|
      [I18n.t("shared.examples.display_names.#{k}"), v]
    }
  end
end
