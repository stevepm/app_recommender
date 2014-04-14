class AppRepository

  class << self
    attr_reader :db

    def attach_db(db)
      @db = db[:apps]
    end

    def create?(app_name, app_url = nil)
      app_url = 'None provided' unless app_url && !app_url.strip.empty?
      db.insert(:app_name => app_name, :app_url => app_url)
    rescue Sequel::UniqueConstraintViolation
      false
    end

    def find(id)
      new(@db[:id => id])
    end

  end

  attr_reader :app_name, :app_url, :id

  def initialize(app_info)
    @app_name = app_info[:app_name]
    @app_url = app_info[:app_url]
    @id = app_info[:id]
  end

end