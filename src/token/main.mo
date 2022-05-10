import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";

actor Token {

    var owner : Principal = Principal.fromText("6p6ot-mmrbb-3smmq-d5l6z-lzq3r-xpsfb-mxqxd-wlyyd-2mgoa-o7flb-qqe");
    //number of coins you want - 1 billion for now
    var totalSupply : Nat = 1000000000;
    var symbol : Text = "ZEE";

    //need the ledger - a datastore that stores the id of the owner/user and how many coins they possess
    //lets use something similar to a dictionary - a hash map takes 3 arguments: size, identity which you can use id and how to hash those keys
    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    //insert value into and give all coins to owner
    balances.put(owner, totalSupply);

    public query func balanceOf(who: Principal) : async Nat {
        //get rid of optional question mark ? 
        let balance : Nat = switch (balances.get(who)) {
            case null 0;
            case (?result) result;
        };

        return balance;
    };

    public query func getSybmol() : async Text {
        return symbol;
    };
    public shared(msg) func payOut() : async Text {
        //Debug.print(debug_show(msg.caller));
        if ( balances.get(msg.caller) == null){
            let amount = 10000;
            balances.put(msg.caller, amount);
            return "Success";
        } else {return "already claimed";}
        
    };

    public shared(msg) func transfer(to: Principal, amount: Nat) : async Text {
        let fromBalance = balanceOf(msg.caller);
        if (fromBalance > amount){
            let newFromBalance: Nat = fromBalance - amount;
            balances.put(msg.caller, newFromBalance);

            let toBalance = balanceOf(to);
            let newToBalance = toBalance + amount;
            balances.put(to, newToBalance);

            return "Success";
        } else {
            return "Inusfficicent funds";
        }

        
    }

};