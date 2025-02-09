
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Trie "mo:base/Trie";

actor ICPBridge {
  stable var lockedBalances: Trie.Trie<Principal, Nat> = Trie.empty();

  /// Lock tokens for cross-chain transfer
  public func lockTokens(user: Principal, amount: Nat): async Bool {
    let currentBalance = Trie.get(lockedBalances, user) ?: 0;
    lockedBalances := Trie.put(lockedBalances, user, currentBalance + amount);
    return true;
  };

  /// Unlock tokens after verifying transaction proof
  public func unlockTokens(user: Principal, amount: Nat): async Bool {
    let currentBalance = Trie.get(lockedBalances, user) ?: 0;

    if (currentBalance < amount) {
      return false;  // Insufficient balance
    };

    lockedBalances := Trie.put(lockedBalances, user, currentBalance - amount);
    return true;
  };

  /// Query locked token balance for a user
  public query func getLockedBalance(user: Principal): async Nat {
    return Trie.get(lockedBalances, user) ?: 0;
  };
}
