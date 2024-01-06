module JsonPreference
  class HashSerializer
    def self.dump(hash)
      hash
    end

    def self.load(hash)
      # This line below is only needed for the DB migration.
      return hash if hash.is_a?(String)
      (hash || {}).try(:with_indifferent_access)
    end
  end
end