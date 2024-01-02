module JsonPreference
  class HashSerializer
    def self.dump(hash)
      hash
    end

    def self.load(hash)
      # return hash if it is a string
      return hash if hash.is_a?(String)
      (hash || {}).try(:with_indifferent_access)
    end
  end
end