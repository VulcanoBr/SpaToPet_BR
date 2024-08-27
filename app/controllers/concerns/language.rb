module Language
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale

    def switch_localexxxxx(&action)
      I18n.with_locale(locale_from_session || locale_from_header, &action)
    end

    private

    def locale_from_header
      request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
    end

    def locale_from_session
      cookies[:locale]
    end

    def switch_locale(&action)
      I18n.with_locale(cookies[:locale] || I18n.default_locale, &action)
    end

    def user_locale
      session[:locale] || request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
    end
  end
end
