// SPDX-License-Identifier: MIT
pragma solidity 0.8.21;

/**
 * @author Abhishek S
 * @title TournamentBracket
 * @dev A contract for managing a tournament bracket with multiple rounds and matches.
 */
contract TournamentBracketGenerator {
    struct Match {
        string participant1;
        string participant2;
        uint256 participant1Score;
        uint256 participant2Score;
        bool completed;
        string winner;
    }

    struct Round {
        Match[] matches;
        bool completed;
    }

    Round[] private bracket;

    // Modifier to ensure that the previous round is completed before executing a function
    modifier roundCompleted(uint256 roundIndex) {
        require(roundIndex == 0 || bracket[roundIndex - 1].completed, "Previous round must be completed");
        _;
    }

    /**
     * @dev Creates a tournament bracket based on the number of participants and their names.
     * @param numParticipants The number of participants in the tournament (must be a power of 2).
     * @param participantNames An array of participant names.
     */
    function createBracket(uint256 numParticipants, string[] memory participantNames) external {
        require(numParticipants > 1, "At least 2 participants are required to create a bracket");
        require(isPowerOfTwo(numParticipants), "Number of participants must be a power of 2");
        require(participantNames.length == numParticipants, "Mismatch in participant names count");

        uint256 numRounds = log2(numParticipants);

        bracket.push();

        uint256 matchCount = numParticipants / 2;

        for (uint256 roundIndex = 0; roundIndex < numRounds; roundIndex++) {
            Match[] storage matches = bracket[roundIndex].matches;

            for (uint256 matchIndex = 0; matchIndex < matchCount; matchIndex++) {
                matches.push(Match(participantNames[matchIndex * 2], participantNames[matchIndex * 2 + 1], 0, 0, false, ""));
            }

            bracket.push();

            matchCount /= 2;
        }
    }

    /**
     * @dev Updates the result of a match in the tournament bracket.
     * @param roundIndex The index of the round containing the match.
     * @param matchIndex The index of the match within the round.
     * @param participant1Score The score of participant 1.
     * @param participant2Score The score of participant 2.
     * @param winner The name of the winner.
     */
    function updateMatchResult(uint256 roundIndex, uint256 matchIndex, uint256 participant1Score, uint256 participant2Score, string memory winner) external roundCompleted(roundIndex) {
        require(roundIndex < bracket.length, "Invalid round index");
        require(matchIndex < bracket[roundIndex].matches.length, "Invalid match index");
        require(!bracket[roundIndex].matches[matchIndex].completed, "Match already completed");

        bracket[roundIndex].matches[matchIndex].participant1Score = participant1Score;
        bracket[roundIndex].matches[matchIndex].participant2Score = participant2Score;
        bracket[roundIndex].matches[matchIndex].completed = true;
        bracket[roundIndex].matches[matchIndex].winner = winner;

        if (allMatchesCompleted(roundIndex)) {
            bracket[roundIndex].completed = true;
        }
    }

    /**
     * @dev Checks if all matches in a round are completed.
     * @param roundIndex The index of the round.
     * @return A boolean indicating whether all matches are completed in the round.
     */
    function allMatchesCompleted(uint256 roundIndex) private view returns (bool) {
        Match[] memory matches = bracket[roundIndex].matches;
        for (uint256 i = 0; i < matches.length; i++) {
            if (!matches[i].completed) {
                return false;
            }
        }
        return true;
    }

    /**
     * @dev Retrieves the current state of the tournament bracket.
     * @return An array of Round structs representing the bracket state.
     */
    function getBracketState() external view returns (Round[] memory) {
        return bracket;
    }

    /**
     * @dev Checks if a number is a power of two.
     * @param number The number to check.
     * @return A boolean indicating whether the number is a power of two.
     */
    function isPowerOfTwo(uint256 number) public pure returns (bool) {
        return (number != 0) && ((number & (number - 1)) == 0);
    }

    /**
     * @dev Calculates the logarithm base 2 of a number.
     * @param x The number.
     * @return The logarithm base 2 of the number.
     */
    function log2(uint256 x) private pure returns (uint256) {
        uint256 res = 0;
        while (x > 1) {
            x /= 2;
            res++;
        }
        return res;
    }
}
