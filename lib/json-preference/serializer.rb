module JsonPreference
  class HashSerializer
    def self.dump(hash)
      hash
    end

    def self.load(hash)
      (hash || {}).try(:with_indifferent_access)
    end
  end
end