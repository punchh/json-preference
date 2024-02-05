module JsonPreference
  class HashSerializer
    def self.dump(hash)
      hash
    end

    def self.load(hash)
      return if hash.nil?
      hash.try(:with_indifferent_access)
    end
  end
end