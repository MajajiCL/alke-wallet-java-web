package com.alkewallet.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Account {
    private int accountId;
    private String accountNumber;
    private double balance;
    private List<Transaction> transactions;
    private int nextTransactionId = 1;

    public Account(int accountId, String accountNumber, double initialBalance) {
        this.accountId = accountId;
        this.accountNumber = accountNumber;
        this.balance = initialBalance;
        this.transactions = new ArrayList<>();
    }

    public int getAccountId() {
        return accountId;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public double getBalance() {
        return balance;
    }

    public List<Transaction> getTransactions() {
        return transactions;
    }

    public synchronized boolean deposit(double amount, String description) {
        if (amount <= 0) {
            return false;
        }
        this.balance += amount;
        Transaction t = new Transaction(
            nextTransactionId++,
            "DEPOSIT",
            amount,
            new Date(),
            (description != null && !description.trim().isEmpty()) ? description : "Depósito de fondos"
        );
        this.transactions.add(0, t); // Agregar al inicio (más reciente primero)
        return true;
    }

    public synchronized boolean withdraw(double amount, String description) {
        if (amount <= 0 || amount > this.balance) {
            return false;
        }
        this.balance -= amount;
        Transaction t = new Transaction(
            nextTransactionId++,
            "WITHDRAWAL",
            amount,
            new Date(),
            (description != null && !description.trim().isEmpty()) ? description : "Retiro de fondos"
        );
        this.transactions.add(0, t); // Agregar al inicio (más reciente primero)
        return true;
    }

    public String getFormattedBalance() {
        return String.format("$%.2f", balance);
    }
}
