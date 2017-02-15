module CardLibrary
  RANK_NAMES = {
      1 => 'Ace',
      11 => 'Jack',
      12 => 'Queen',
      13 => 'King'
    }

  SUITS = [:hearts, :diamonds, :spades, :clubs]

  class Deck
    DECK_RANKS = (1..13).to_a
    attr_accessor :cards

    def initialize
      @cards = self.class::DECK_RANKS.product(SUITS).map do |card_arguments|
        Card.new(card_arguments[0], card_arguments[1])
      end
    end

    def count
      @cards.length
    end

    def shuffle
      cards.shuffle!
      self
    end

    def draw(count = 1)
      @cards.pop(count)
    end
  end

  class Card
    include Comparable
    attr_reader :rank, :suit

    def initialize(rank, suit)
      raise ArgumentError unless is_valid_rank(rank) && is_valid_suit(suit)
      @rank = rank
      @suit = suit
    end

    def face_card?
      @rank > 10
    end

    def to_s
      rank_name = RANK_NAMES.has_key?(@rank) ? RANK_NAMES[@rank] : @rank
      suit = @suit.to_s.capitalize
      "%s of %s" % [rank_name, suit]
    end

    def <=>(another_card)
      if self.rank < another_card.rank
        -1
      elsif self.rank > another_card.rank
        1
      else
        0
      end
    end

    private

    def is_valid_rank(rank)
      0 < rank && rank < 14
    end

    def is_valid_suit(suit)
      SUITS.include?(suit)
    end
  end

  class Hand
    attr_accessor :cards

    def initialize(cards)
      @cards = cards
    end

    def size
      @cards.length
    end
  end

  class BelotteDeck < Deck
    DECK_RANKS = [1, 7, 8, 9, 10, 11, 12, 13]
  end

  class SixtySixDeck < Deck
    DECK_RANKS = [1, 9, 10, 11, 12, 13]
  end
end
