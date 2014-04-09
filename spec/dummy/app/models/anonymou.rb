class Anonymou
  def self.find_by(query={})
    if query[:id] == 'open'
      self.new(true)
    elsif query[:id] == 'restricted'
      self.new(false)
    else
      nil
    end
  end

  def initialize(open)
    @open = open
  end

  def open?
    @open
  end
end
