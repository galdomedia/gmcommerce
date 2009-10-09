raw_config = File.read(RAILS_ROOT + "/config/gmcommerce_config.yml")
GMCOMMERCE_CONFIG = YAML.load(raw_config)[RAILS_ENV].symbolize_keys
