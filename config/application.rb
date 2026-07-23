require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Eteam
  class Application < Rails::Application
    config.load_defaults 7.1

    # 日本時間に設定
    config.time_zone = "Asia/Tokyo"

    # DBはUTCで保存（Railsでは一般的な設定）
    config.active_record.default_timezone = :utc

    config.autoload_lib(ignore: %w(assets tasks))

    config.i18n.default_locale = :ja
  end
end