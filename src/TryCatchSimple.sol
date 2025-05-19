pragma solidity 0.8.28;

interface IERC20 {
    function name() external view returns (string memory);
}

contract TryCatchSimple {
    function main(IERC20 token) public view returns (string memory) {
        // use try catch to return the name of the token using .name()
        // if the call fails, return an empty string
        try token.name() returns (string memory tokenName) {
            return tokenName;
        } catch {
            // If the call to token.name() fails for any reason,
            // (e.g., revert, panic, contract doesn't exist, etc.),
            // this general catch block will be executed.
            return "";
        }
    }
}
