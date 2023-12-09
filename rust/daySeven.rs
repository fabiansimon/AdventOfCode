use std::fs::File;
use std::io::{self, BufRead, BufReader};
use std::collections::{HashMap, BinaryHeap};
use std::cmp::{Ordering};


#[derive(Debug, Eq, PartialEq)]
struct Hand {
    strength: i32,    
    bid: i32, 
    input: String,
}

impl Ord for Hand {
    fn cmp(&self, other: &Self) -> Ordering {
        let labels: Vec<char> = "AKQJT98765432".chars().collect();
        let mut card_order: HashMap<char, usize> = HashMap::new();

        for (index, &label) in labels.iter().enumerate() {
            card_order.insert(label, labels.len() - index);
        }

        if &self.strength == &other.strength {
            
            for idx in 0..self.input.len() {
                let a = self.input.chars().nth(idx).unwrap();
                let b = other.input.chars().nth(idx).unwrap();

                if a != b {
                    if let (Some(order_a), Some(order_b)) = (card_order.get(&a), card_order.get(&b)) {
                        return order_b.cmp(&order_a);
                    }
                }
            }
        }

        return other.strength.cmp(&self.strength)
    }
}

impl PartialOrd for Hand {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

fn main () -> io::Result<()> {
    let file_path = "./daySeven_input.txt";
    
    let mut sorted_hands: BinaryHeap<Hand> = BinaryHeap::new();
    let _ = populate_hands(file_path, &mut sorted_hands);

    let mut total_winnings = 0; 
    let mut rank = 1;
    while let Some(hand) = sorted_hands.pop() {
        total_winnings += &hand.bid * rank;
        rank += 1;

        // println!("{:?}", hand);
    }

    println!("Total Winnings: {}", total_winnings);

    Ok(())
}

fn populate_hands (path: &str, list: &mut BinaryHeap<Hand>) -> io::Result<()> {
    let file = File::open(path)?;
    let reader = BufReader::new(file);

    for line in reader.lines() {
        let content = line?;
        let parts: Vec<&str> = content.split_whitespace().collect();

        if parts.len() >= 2 {
            list.push(Hand {
                bid: parts[1].parse().unwrap_or(0),
                input: parts[0].parse().unwrap(),
                strength: get_strength(parts[0]),
            });

        } else {
            println!("Bad line: {}", content);
        }
    }

    Ok(())
}

fn get_strength (input: &str) -> i32 {
    let mut occs: HashMap<char, i32> = HashMap::new();

    for c in input.chars() {
        let val = *occs.entry(c).or_insert(0) + 1;
        occs.insert(c, val);
    }

    let mut max_scores: BinaryHeap<(i32, char)> = occs
        .iter()
        .map(|(key, value)| (*value, *key))
        .collect();

    while let Some((val, _key)) = max_scores.pop() {

        // Five of a Kind or Four of a Kind 
        if val == 5 || val == 4 {
            return val+1; 
        };

        // Three of a Kind or Full House
        if val == 3 {
            return match max_scores.peek().map(|(p_val, _)| p_val) {
                Some(2) => 4,
                _ => 3,
            };
        }

        // Two Pair or One Pair
        if val == 2 {
            return match max_scores.peek().map(|(p_val, _)| p_val) {
                Some(2) => 2,
                _ => 1,
            };
        }

        return 1
    }

    return 0;
}