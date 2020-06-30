class RootController < ApplicationController
  def index
    session[:enable_factorybot] = true unless session.to_h.keys.include? :enable_factorybot
    @examples = EXAMPLES.map { |k,v|
      [I18n.t("shared.examples.display_names.#{k}"), v]
    }
  end
end
