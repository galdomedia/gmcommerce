class Payments
  def self.load_settings_for(payments_ident)
    raw_config = File.read(RAILS_ROOT + "/config/gateways/#{payments_ident}.yml")
    config = YAML.load(raw_config)[RAILS_ENV].symbolize_keys
    config
  end
end
