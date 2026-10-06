package com.alkewallet.model;

public class User {
    private int id;
    private String name;
    private String email;
    private String password;
    private Account account;

    public User(int id, String name, String email, String password, Account account) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.account = account;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }
}
