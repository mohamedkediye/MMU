
// mohamed kediye

//This is the Transaction class which holds all the details for the transactions and passes it on to the Account class.

public class Transaction {

	private int id; // this creates private integers for ID,
	
	private int counter = 0;// this creates private integers for balance and the counter is set to 0
	
	private double deposit;// this creates a new class on a existing deposit class
	
	private double withdrawal;// this creates a new class on a existing withdraw class
	
	private double balance;//this creates a new class on a existing balance class

	public Transaction(int id, int counter, double balance, double deposit, double withdrawal) {
		
		this.id = id; //identify the parameter variable of ID
		
		this.counter = counter;// identify the parameter of counter
		
		this.deposit = deposit;// identify the parameter of deposit
		
		this.withdrawal = withdrawal;// identify the parameter of withdraw
		
		this.balance = balance; //identify the parameter balance
		
	}
	
	/*
	* These set and get methods are called in the Account printStatement method 
	* 		to print the transactions in the correct format.
	*/

	public int id() {
		
		return id; // returns the ID
		
	}
	
	
	
	public int getCounter() { 
		
		return counter; // This returns the counter
		
	}

	
	
	public void setCounter(int counter) {
		
		this.counter = counter; // this sets the counter
		
	}
	
	
	
	public double getDeposit() {
		
		return deposit; // this returns the deposit
		
	}
	
	
	
	public double getWithdrawal() {
		
		return withdrawal; // this returns the withdrawal
		
	}
	
	
	
	public double getbalance() {
		
		return balance; // this returns the balance
		
	}

	
	
}