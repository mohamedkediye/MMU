

// Mohamed kediye

//16038109

// CardHolder class to run all threads for the transactions.

public class CardHolder implements Runnable {
	private int id;
	private Account account;
	final static int numIterations = 20;

	public CardHolder(int id, Account account) {
		this.id = id;
		this.account = account;
	}

	/*
	 * run method is what is executed when you start a Thread that is initialised
	 * with an instance of this class. You will need to add code to keep track of
	 * local balance (cash in hand) and report this when the thread completes.
	 */

	public void run() {
		for (int i = 0; i < numIterations; i++) {
			// Generate a random amount from 1-10
			int amount = (int) (Math.random() * 10) + 1;
			// Then with 50/50 chance, either deposit or withdraw it
			if (Math.random() > 0.5) {
				account.withdraw(id, amount); // random withdraw
			} else {
				account.deposit(id, amount); // random deposit
			}
			
			try {
				Thread.sleep(200);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println("THREAD " + id + " finished");

	}
}