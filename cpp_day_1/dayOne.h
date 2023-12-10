//
// Created by Fabian Simon on 04.12.23.
//

#ifndef ADVENTOFCODE_DAYONE_H
#define ADVENTOFCODE_DAYONE_H

#include <iostream>
#include <fstream>
#include <unordered_set>

class TrieNode {
public:
    std::unordered_map<char, TrieNode> children;
    bool is_end;

    TrieNode() {
        children = std::unordered_map<char, TrieNode>();
        is_end = false;
    }
};

class DayOne {
private:
    TrieNode root;
    const std::unordered_map<std::string, int> string_values = {
            {"one", 1},
            {"two", 2},
            {"three", 3},
            {"four", 4},
            {"five", 5},
            {"six", 6},
            {"seven", 7},
            {"eight", 8},
            {"nine", 9},
    };
    const std::string filename = "../day1_input";
    int total_sum = 0, left = 0, right = 0;

    inline void add_word(const std::string& word) {
        TrieNode* curr = &root;

        for (char c : word) {
            auto it = curr->children.find(c);
            if (it == curr->children.end()) {
                curr->children[c] = TrieNode();
            }
            curr = &curr->children[c];
        }

        curr->is_end = true;
    }

    inline std::string is_word(const std::string& word, int start) {
        const TrieNode* curr = &root;
        int index = start;

        while (index < word.size() && !isdigit(word.at(index)) && curr != nullptr) {
            char c = word.at(index++);
            auto it = curr->children.find(c);
            if (it == curr->children.end()) return "";
            if (it->second.is_end) return word.substr(start, index-start);
            curr = &it->second;
        }

        return "";
    }

    inline int is_string_digit(const std::string& line, int start) {
        std::string res = is_word(line, start);
        if (!res.empty()) {
            return string_values.find(res)->second;
        }

        return -1;
    }

public:
    DayOne() {
        root = TrieNode();
        for (const auto& pair : string_values) {
            add_word(pair.first);
        }
    }

    inline int getResult() {
        std::ifstream input_file(filename);

        if (input_file.is_open()) {
            std::string line;

            while (std::getline(input_file, line)) {
                left = 0, right = line.size()-1;
                std::string leftStr, rightStr;

                while (leftStr.empty()) {
                    if (isdigit(line.at(left))) {
                        leftStr = std::string(1, line.at(left));
                        break;
                    }
                    int res = is_string_digit(line, left);
                    if (res != -1) {
                        leftStr = std::string(1, static_cast<char>(res + '0'));
                    }
                    left++;
                }

                while (right >= left && rightStr.empty()) {
                    if (isdigit(line.at(right))) {
                        rightStr = std::string(1, line.at(right));
                    }
                    int res = is_string_digit(line, right);
                    if (res != -1) {
                        rightStr = std::string(1, static_cast<char>(res + '0'));
                    }
                    right--;
                }

                std::string sum = leftStr + (!rightStr.empty() ? rightStr : leftStr);

                total_sum += std::stoi(sum);
            }

            input_file.close();
        }

        return total_sum;
    }
};

#endif //ADVENTOFCODE_DAYONE_H
