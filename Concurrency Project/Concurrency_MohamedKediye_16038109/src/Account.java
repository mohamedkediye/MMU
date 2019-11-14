// Mohamed kediye 

//16037109


import java.util.ArrayList;

public class Account { // this creates the public class for Account 
	
	private String name; // creates String NAME
	
	private int balance;// creates private integers for balance, 
	
	private int id;// creates private integers for ID,
	
	private int counter;// creates private integers for the counter
	
	private ArrayList<Transaction> transactions; // creates ArrayList for transactions

	public static void main(String[] args) throws InterruptedException {
		// Check to make sure program has been called with correct number of
		// command line arguments
		if (args.length != 3) {
			System.err.println("Error: program should take exactly three command line arguments:");
			System.err.println("\t<No. of card holders> <main acct starting bal.> <backup acct. starting bal.>");
			System.exit(0);
		}
		// this shows that all the Args are Integers
		try {
			int numCards = Integer.parseInt(args[0]);
			Account account = new Account("Main", Integer.parseInt(args[1]));
			Account backup = new Account("Backup", Integer.parseInt(args[2]));

			// this is the code created to manage threads.
			Thread[] cards = new Thread[numCards]; // creates a new card
			for (int i = 0; i < numCards; i++) {
				cards[i] = new Thread(new CardHolder(i, account)); // this creates a new thread for a cardholder.
				cards[i].start(); // this makes sure the thread begins the execution.
			}
			// join.
			for (int i = 0; i < numCards; i++) {
				cards[i].join(); // waits for the thread to die.
			}

			account.printStatement(); // This prints the statement for the Account
			
			backup.printStatement(); // This Prints the statement for the backup Account

		} catch (NumberFormatException e) {
			System.err.println("All three arguments should be integers"); // print
			
			System.err.println("\t<No. of card holders> <main acct starting bal.> <backup acct. starting bal.>"); // print
		}
	}

	// This creates an account 
	public Account(String name, int startingBalance) {
		
		this.name = name; // this creates the name object
		
		this.balance = startingBalance; //this creates the balance object
		
		counter = 1; // ensures the transactions start from number 1.
		
		this.transactions = new ArrayList<Transaction>(); // this creates the transaction object and the Arraylist.
	}

	// Deposit <amount> into the account
	//The synchronized method prevents threads interfering and keeps memory consistency 
	synchronized public void deposit(int id, int amount) {
		
		this.id = id; // adds the ID
		
		balance = balance + amount; // adds the amount of deposit onto the total balance.
		
		transactions.add(new Transaction(id, counter++, balance, amount, 0)); // This adds a new transaction
		
		notifyAll(); // this tells  all the threads to wake up.
	}

	// Withdraw <amount> from the account
	//The synchronized method prevents threads interfering and keeps memory consistency 
	synchronized public void withdraw(int id, int amount) {
		
		while (amount > balance) {
			
			try {
				
				wait(); // current thread will wait until another thread is notified.
				
			} catch (InterruptedException e) {
				
				System.out.println(e.getMessage());
			}
		}
		
		balance = balance - amount; // takes the amount of withdrawal off the total balance.
		
		transactions.add(new Transaction(id, counter++, balance, 0, amount)); // After the thread has been notified it will add a new transaction
	}
	

	
	// This Prints out the statement of transactions
	public void printStatement() {
		System.out.println("Account \"" + name + "\":"); // Prints out Account and Name

		if (transactions != null) {
			
			System.out.format("%-16s%-15s%-17s%-15s\n", "Transactions", "Deposit", "Withdraw", "Balance"); // This aligns the table for Transactions, Deposit, Withdraw and Balance.
			
		} else {
			
			System.out.println("There are No Transactions to show"); // This prints out "There are No Transactions to show" if there is no output
		}

		for (int i = 0; i < transactions.size(); i++) {
			
			Transaction transac = transactions.get(i);
			
			
			if (transac.getDeposit() == 0 && transac.getWithdrawal() == 0) {
				
				System.out.println(String.format("%3d(%2d)\t\t\t\t\t%2.0f", transac.getCounter(), transac.id(), transac.getbalance())); // This prints it out in decimal integers and tabs to make sure that it is aligned correctly. %f means the floating point of a decimal number
				
			} else if (transac.getDeposit() == 0) { // This gets the Deposit from transaction
				
				System.out.println(String.format("%3d(%2d)\t\t\t\t %2.0f\t\t%3.0f", transac.getCounter(), transac.id(), // This prints it out in decimal integers and tabs to make sure that it is aligned correctly. %f means the floating point of a decimal number
						
						transac.getWithdrawal(), transac.getbalance()));  // This gets the withdrawal from transaction
				
			} else if (transac.getWithdrawal() == 0) {
				
				System.out.println(String.format("%3d(%2d)\t\t%2.0f\t\t\t\t%3.0f", transac.getCounter(), transac.id(),// This prints it out in decimal integers and tabs to make sure that it is aligned correctly. %f means the floating point of a decimal number
						
						transac.getDeposit(), transac.getbalance())); // This gets  the balance from transaction
			} else {
				
				System.out.println(String.format("%3d(%2d)\t\t\t\t%3.0f\t%3.0f\t\t%4.0f", transac.getCounter(), transac.id(), // This prints it out in decimal integers and tabs to make sure that it is aligned correctly. %f means the floating point of a decimal number
						
						transac.getWithdrawal(), transac.getDeposit(), transac.getbalance())); //This prints out the deposit, withdrawal and the balance.
				
			}
		}
	}
}