module ColorLS
  def self.load_from_yaml(filename, aliase=false)
    user_config_filepath = File.join(Dir.home, ".config/colorls/#{filename}")
    filepath             = File.join(File.dirname(__FILE__),"../yaml/#{filename}")
    yaml                 = read_file(filepath)

    if File.exist?(user_config_filepath)
      user_config_yaml = read_file(user_config_filepath)
      yaml             = yaml.merge(user_config_yaml)
    end

    return yaml unless aliase
    yaml
      .to_a
      .map! { |k, v| [k, v.to_sym] }
      .to_h
  end

  def self.read_file(filepath)
    YAML.safe_load(File.read(filepath)).symbolize_keys
  end
end
