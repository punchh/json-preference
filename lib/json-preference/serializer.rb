module JsonPreference
  class HashSerializer
    def self.dump(hash)
      hash
    end

    def self.load(hash)
      return hash if hash.is_a?(String) # For Rails migration only. Please remove this line after it

      (hash || {}).with_indifferent_access
    end
  end
end