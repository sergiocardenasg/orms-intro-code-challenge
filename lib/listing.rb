class Listing
    # Listing belongs to Agent
    attr_reader :location, :id
    attr_accessor :status, :price, :agent

    @@all = []

    def initialize(id = nil, location, price, status)
        @id = id
        @location = location
        @price = price
        @status = status
        @@all << self
    end

    def price_drop(percentage)
        self.price -= self.price*percentage
    end

    def self.all
        @@all
    end

    def self.create_table
        sql = <<-SQL
            CREATE TABLE IF NOT EXISTS listings (
                id INTEGER PRIMARY KEY,
                location TEXT,
                price INTEGER,
                status TEXT,
                agent TEXT
            )
        SQL
        DB[:conn].execute(sql)
    end

    def save
        sql = <<-SQL
          INSERT INTO agent (location, price, status, agent)
          VALUES (?, ?, ?, ?)
        SQL
        DB[:conn].execute(sql, self.location, self.price, self.status, self.agent)
    end
    
end