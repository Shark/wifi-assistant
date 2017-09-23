class AppConfig
  CONFIG = HashWithIndifferentAccess.new(
    YAML.load_file(
      Rails.root.join('config', 'app.yml')
    )
  )

  def self.method_missing(m, *args, &block)
    CONFIG.send(m, *args, &block)
  end
end
