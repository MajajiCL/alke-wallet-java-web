package com.alkewallet.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Transaction {
    private int id;
    private String type; // "DEPOSIT" o "WITHDRAWAL"
    private double amount;
    private Date date;
    private String description;

    public Transaction(int id, String type, double amount, Date date, String description) {
        this.id = id;
        this.type = type;
        this.amount = amount;
        this.date = date;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public String getType() {
        return type;
    }

    public double getAmount() {
        return amount;
    }

    public Date getDate() {
        return date;
    }

    public String getDescription() {
        return description;
    }

    public String getFormattedDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMM, hh:mm a");
        return sdf.format(date != null ? date : new Date());
    }

    public String getFormattedAmount() {
        if ("DEPOSIT".equalsIgnoreCase(type)) {
            return String.format("+$%.2f", amount);
        } else {
            return String.format("-$%.2f", amount);
        }
    }
}
